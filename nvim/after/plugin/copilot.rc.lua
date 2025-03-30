local status, copilot = pcall(require, "copilot")
if not status then return end

-- Function to check Node.js version
local function get_node_version()
  local handle = io.popen("node -v")
  if not handle then return 0 end
  local version = handle:read("*a")
  handle:close()

  -- Extract major version from vXX.X.X
  local major = version:match("v(%d+)")
  return major and tonumber(major) or 0
end

local node_version = get_node_version()

-- If Node.js < 20, do not load Copilot
if node_version < 20 then
  vim.notify("Custom Copilot disabled: Node.js 20+ required (found " .. node_version .. ")", vim.log.levels.WARN)
  return
end

-- Setup Copilot only if Node.js is 20 or newer
copilot.setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "right",
      ratio = 0.6
    },
  }, 
  suggestion = {
    enabled = true,
    auto_trigger = false,
    hide_during_completion = true,
    debounce = 75,
    keymap = {
      accept_word = false,
      accept_line = false,
      next = "<M-l>",
      prev = "<M-k>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = "node",
  workspace_folders = {},
  copilot_model = "",
  root_dir = function()
    return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
  end,
  should_attach = function(_, _)
    if not vim.bo.buflisted then
      return false, "buffer not 'buflisted'"
    end
    if vim.bo.buftype ~= "" then
      return false, "buffer 'buftype' is " .. vim.bo.buftype
    end
    return true
  end,
  server = {
    type = "nodejs",
    custom_server_filepath = nil, -- Use LSP server
  },
  server_opts_overrides = {}
})



-- ===========
local utils = require('config.utils')
utils.desc('<leader>a', 'AI')

-- Copilot autosuggestions
vim.g.copilot_hide_during_completion = false
vim.g.copilot_proxy_strict_ssl = false
vim.g.copilot_settings = { selectedCompletionModel = 'gpt-4o-copilot' }

-- Copilot chat
local chat = require('CopilotChat')
local prompts = require('CopilotChat.config.prompts')
local select = require('CopilotChat.select')
local cutils = require('CopilotChat.utils')

local COPILOT_PLAN = [[
You are a software architect and technical planner focused on clear, actionable development plans.
]] .. prompts.COPILOT_BASE.system_prompt .. [[

When creating development plans:
- Start with a high-level overview
- Break down into concrete implementation steps
- Identify potential challenges and their solutions
- Consider architectural impacts
- Note required dependencies or prerequisites
- Estimate complexity and effort levels
- Track confidence percentage (0-100%)
- Format in markdown with clear sections

Always end with:
"Current Confidence Level: X%"
"Would you like to proceed with implementation?" (only if confidence >= 90%)
]]

chat.setup({
    model = 'claude-3.7-sonnet',
    references_display = 'write',
    debug = false,
    selection = select.visual,
    context = 'buffers',
    mappings = {
        reset = false,
        show_diff = {
            full_diff = true,
        },
    },
    window = {
        layout = 'float', -- 'vertical', 'horizontal', 'float', 'replace'
        width = 0.75, -- fractional width of parent, or absolute width in columns when > 1
        height = 0.75, -- fractional height of parent, or absolute height in rows when > 1
        -- Options below only apply to floating windows
        relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
        border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        row = nil, -- row position of the window, default is centered
        col = nil, -- column position of the window, default is centered
        title = 'Copilot Chat', -- title of chat window
        footer = nil, -- footer of chat window
        zindex = 1, -- determines if window is on top or below other floating windows
    },
    prompts = {
        Explain = {
            mapping = '<leader>ae',
            description = 'AI Explain',
        },
        Review = {
            mapping = '<leader>ar',
            description = 'AI Review',
        },
        Tests = {
            mapping = '<leader>at',
            description = 'AI Tests',
        },
        Fix = {
            mapping = '<leader>af',
            description = 'AI Fix',
        },
        Optimize = {
            mapping = '<leader>ao',
            description = 'AI Optimize',
        },
        Docs = {
            mapping = '<leader>ad',
            description = 'AI Documentation',
        },
        Commit = {
            mapping = '<leader>ac',
            description = 'AI Generate Commit',
            selection = select.buffer,
        },
        Plan = {
            prompt = 'Create or update the development plan for the selected code. Focus on architecture, implementation steps, and potential challenges.',
            system_prompt = COPILOT_PLAN,
            context = 'file:.copilot/plan.md',
            progress = function()
                return false
            end,
            callback = function(response, source)
                chat.chat:append('Plan updated successfully!', source.winnr)
                local plan_file = source.cwd() .. '/.copilot/plan.md'
                local dir = vim.fn.fnamemodify(plan_file, ':h')
                vim.fn.mkdir(dir, 'p')
                local file = io.open(plan_file, 'w')
                if file then
                    file:write(response)
                    file:close()
                end
            end,
        },
    },
    contexts = {
        vectorspace = {
            description = 'Semantic search through workspace using vector embeddings. Find relevant code with natural language queries.',

            schema = {
                type = 'object',
                required = { 'query' },
                properties = {
                    query = {
                        type = 'string',
                        description = 'Natural language query to find relevant code.',
                    },
                    max = {
                        type = 'integer',
                        description = 'Maximum number of results to return.',
                        default = 10,
                    },
                },
            },

            resolve = function(input, source, prompt)
                local embeddings = cutils.curl_post('http://localhost:8000/query', {
                    json_request = true,
                    json_response = true,
                    body = {
                        dir = source.cwd(),
                        text = input.query or prompt,
                        max = input.max,
                    },
                }).body

                cutils.schedule_main()
                return vim.iter(embeddings)
                    :map(function(embedding)
                        embedding.filetype = cutils.filetype(embedding.filename)
                        return embedding
                    end)
                    :filter(function(embedding)
                        return embedding.filetype
                    end)
                    :totable()
            end,
        },
    },
    providers = {
        github_models = {
            disabled = true,
        },
    },
})

utils.au('BufEnter', {
    pattern = 'copilot-*',
    callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
    end,
})

vim.keymap.set({ 'n' }, '<leader>aa', chat.toggle, { desc = 'AI Toggle' })
vim.keymap.set({ 'v' }, '<leader>aa', chat.open, { desc = 'AI Open' })
vim.keymap.set({ 'n' }, '<leader>ax', chat.reset, { desc = 'AI Reset' })
vim.keymap.set({ 'n' }, '<leader>as', chat.stop, { desc = 'AI Stop' })
vim.keymap.set({ 'n' }, '<leader>am', chat.select_model, { desc = 'AI Models' })
vim.keymap.set({ 'n' }, '<leader>ag', chat.select_agent, { desc = 'AI Agents' })
vim.keymap.set({ 'n', 'v' }, '<leader>ap', chat.select_prompt, { desc = 'AI Prompts' })
vim.keymap.set({ 'n', 'v' }, '<leader>aq', function()
    vim.ui.input({
        prompt = 'AI Question> ',
    }, function(input)
        if input ~= '' then
            chat.ask(input)
        end
    end)
end, { desc = 'AI Question' })
