local status, focus = pcall(require, "focus")
if (not status) then return end

focus.setup({
  auto_zen = true,
  window = {
      width = .55 -- width will be 85% of the editor width
  }
})

