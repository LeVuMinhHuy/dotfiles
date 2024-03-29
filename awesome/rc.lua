pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.hotkeys_popup.keys")
require("awful.autofocus")

local function just_run(command) 
  awful.spawn.easy_async_with_shell(command, function() end)
end

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = "gedit"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4"
-- }}}

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon })

-- Menubar configuration
menubar.utils.terminal = terminal 
-- }}}


-- {{{ Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        --awful.layout.suit.floating,
    })
end)
-- }}}

-- {{{ Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
                image     = beautiful.wallpaper,
                upscale   = true,
                downscale = true,
                widget    = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled  = false,
            widget = wibox.container.tile,
        }
    }
end)
-- }}}

-- {{{ Wibar

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        style   = {
          font                  = "Sarasa Mono CL 12",
          bg_normal             = "#1d2021",
          fg_normal             = "#ebdbb2",
          bg_focus              = "#32302f",
          fg_focus              = "#ebdbb2",
          bg_minimize           = "#1d2021",
          fg_minimize           = "#ebdbb2",
          tasklist_disable_icon = true,
          align                 = "center"
        },
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        }
    }

    s.myRam =  awful.widget.watch('bash -c "free | grep -z Mem.*Swap.*"', 15, function(widget, stdout)
  	  local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap = stdout:match(
  	  	"(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)"
  	  )
  	  widget:set_markup(" ram: " .. string.format("%.2f", used / total * 100) .. " | ")
  	  collectgarbage("collect")
    end)

   -- s.myBattery = awful.widget.watch('cat /sys/class/power_supply/BAT0/capacity', 30, function(widget, stdout)
   --   local cap = stdout
   --   widget:set_markup(" bat: " .. string.format("%.f", cap) .. " | ")
   --   collectgarbage("collect")
   -- end)
   --
    s.noti_status = wibox.widget.textbox(" dnd: "  .. tostring(naughty.is_suspended())  .. " | ")


    local water_icon = wibox.widget {
      image  = "/home/mhhmm/Pictures/emotes/water.png",
      forced_height = 24,
      forced_width = 24,
      widget = wibox.widget.imagebox,
    }

    local pomodoro_icon = wibox.widget {
      image  = "/home/mhhmm/Pictures/emotes/pomodoro.png",
      widget = wibox.widget.imagebox,
    }

    local twitch_icon = wibox.widget {
      image  = "/home/mhhmm/Pictures/emotes/twitch.png",
      widget = wibox.widget.imagebox,
    }

    local todo_urgent = wibox.widget {
      image  = "/home/mhhmm/Pictures/emotes/wokege.png",
      forced_height = 30,
      forced_width = 30,
      widget = wibox.widget.imagebox,
    }
 
    local time_to_run = awful.widget.watch('date +"%T"', 3600, function(widget, stdout)
       local hour = stdout:match(
          "(%d+):(%.*)"
       )      

       if tonumber(hour) == 18 then
          naughty.notify({
             title = "time to run",
             --text  = string.format("%s %s timeout", timeout, s.water_me.minute_t),
             text  = string.format("stop the work, do it later"),
             timeout = 60,
             height = 1000,
             width = 1000,
             position = 'top_middle',
             margin = {
               top = 440,
               left = 390
             },
             icon = "/home/mhhmm/Pictures/emotes/run.png",
             ignore_suspend = true,
             border_color = "#7F669D",
             fg = "#7F669D",
          })
       end

       local time_left = 0

       if tonumber(hour) < 18 then
         time_left = 18 - tonumber(hour)
       else
         time_left = 24 - tonumber(hour) + 18
       end

       widget:set_markup(" " .. "<span color='yellow'><b>" .. time_left .. "h </b></span>" .. "left | ")
       collectgarbage("collect")
    end)

    local last_list_wtwtich = "none"
   
    local twitch_live_list = awful.widget.watch('wtwitch check ', 60, function(widget, stdout)
       local list = stdout:match(
          "Live channels:\n(.*)\n\n%s*Offline:"
       )      

       if (list == nil or list == "") then
         widget:set_markup(" none | ")
         collectgarbage("collect")
         return
       end

       list = list:gsub("[^%S\n]+", ""):gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "")
       local live_name = ""
       local list_filtered = list:gmatch("[^\r\n]+")

       for name in list_filtered do
         live_name = live_name .. name:match("(%a+):") .. " :: "

         if last_list_wtwtich ~= list then
            naughty.notify({
              title = name:match("(%a+):") .. " is live now !!",
              text  = name,
              position = 'top_middle',
              icon = "/home/mhhmm/Pictures/emotes/twitch.png",
              ignore_suspend = true,
              border_color = "#7F669D",
              fg = "#7F669D",
            })
         end
       end

       widget:set_markup(" " ..  live_name .. " | ")
       last_list_wtwtich = list
       collectgarbage("collect")
    end)


    local function watch_twitch()
      awful.prompt.run {
          prompt       = '<b>streamer: </b>',
          textbox      = awful.screen.focused().mypromptbox.widget,
          exe_callback = function(input)
              if not input or #input == 0 then return end
              just_run("wtwitch w " .. input)
          end
      }
    end


    local function input_todo()
      awful.prompt.run {
          prompt       = '<b>todo: </b>',
          textbox      = awful.screen.focused().mypromptbox.widget,
          exe_callback = function(input)
              if not input or #input == 0 then return end
              s.todo_urgent.widget:set_markup("<span color='#FF7D7D'> ::<i><b> " .. input .. "</b></i></span>  | ")
          end
      }
    end


    s.twitch = {
      widget = twitch_live_list,
      icon = twitch_icon
    }

    s.twitch.widget:buttons(awful.util.table.join(
        awful.button({}, 1, function() watch_twitch() end) -- left click
    ))

    s.twitch.widget:buttons(awful.util.table.join(
        awful.button({}, 1, function() watch_twitch() end) -- left click
    ))

    s.water_me = {
        widget   = wibox.widget.textbox(" | "),
        icon = water_icon
    }

    s.pomodoro = {
        widget   = wibox.widget.textbox(" | "),
        icon = pomodoro_icon
    }

    s.todo_urgent = {
        widget   = wibox.widget.textbox(" :: none | "),
        icon = todo_urgent
    }

    s.todo_urgent.icon:buttons(awful.util.table.join(
        awful.button({}, 1, function() input_todo() end), -- left click
        awful.button({}, 3, function() 
            s.todo_urgent.widget:set_markup(" :: none | ")
        end)     
    ))

    local drink_count = 0
    s.water_me.widget:set_markup(" :: " .. drink_count .. " | ")

    function s.water_me.set()
        s.water_me.widget:set_markup(" :: " .. drink_count .. " | ")
        local timeout = 20
        s.water_me.seconds = tonumber(timeout)
        if not s.water_me.seconds then return end
        s.water_me.minute_t = s.water_me.seconds > 1 and "minutes" or "minute"
        s.water_me.seconds = s.water_me.seconds * 60
        s.water_me.timer = gears.timer({ timeout = 1 })
        s.water_me.timer:connect_signal("timeout", function()
            if s.water_me.seconds > 0 then
                local minutes = math.floor(s.water_me.seconds / 60)
                local seconds = math.fmod(s.water_me.seconds, 60)
                s.water_me.widget:set_markup( string.format("%d:%02d", minutes, seconds) .. " :: " .. drink_count .. " | ")
                s.water_me.seconds = s.water_me.seconds - 1
            else
                drink_count = drink_count + 1
                s.water_me.timer:stop()
                s.water_me.widget:set_markup(" done :: " .. drink_count .. " | ")
                naughty.notify({
                    title = "drink water",
                    --text  = string.format("%s %s timeout", timeout, s.water_me.minute_t),
                    text  = string.format("stay hydrated"),
                    timeout = 30,
                    height = 1000,
                    width = 1000,
                    position = 'top_middle',
                    margin = {
                      top = 440,
                      left = 390
                    },
                    icon = "/home/mhhmm/Pictures/emotes/lilydrink.png",
                    ignore_suspend = true,
                    border_color = "#82C3EC",
                    fg = "#82C3EC",
                })
                s.water_me.set()
            end
        end)
        s.water_me.timer:start()
    end
    
    s.water_me.icon:buttons(awful.util.table.join(
        awful.button({}, 1, function() s.water_me.set() end), -- left click
        awful.button({}, 3, function() -- right click
            if s.water_me.timer and s.water_me.timer.started then
                s.water_me.widget:set_markup(" :: " .. drink_count .. " | ")
                s.water_me.timer:stop()
                naughty.notify({ title = "Countdown", text  = "Timer stopped" })
            end
        end)
    ))

    s.water_me.set()

    local pomodoro_count = 0
    s.pomodoro.widget:set_markup(" today: " .. tostring(pomodoro_count) .. " | ")

    function s.pomodoro.set()
        s.pomodoro.widget:set_markup(" today: " .. tostring(pomodoro_count) .. " | ")
        local timeout = 25
        s.pomodoro.seconds = tonumber(timeout)
        if not s.pomodoro.seconds then return end
        s.pomodoro.minute_t = s.pomodoro.seconds > 1 and "minutes" or "minute"
        s.pomodoro.seconds = s.pomodoro.seconds * 60
        s.pomodoro.timer = gears.timer({ timeout = 1 })
        s.pomodoro.timer:connect_signal("timeout", function()
            if s.pomodoro.seconds > 0 then
                local minutes = math.floor(s.pomodoro.seconds / 60)
                local seconds = math.fmod(s.pomodoro.seconds, 60)
                s.pomodoro.widget:set_markup(string.format("%d:%02d :: today: " .. tostring(pomodoro_count) .. " | ", minutes, seconds))
                s.pomodoro.seconds = s.pomodoro.seconds - 1
            else
                pomodoro_count = pomodoro_count + 1
                s.pomodoro.timer:stop()
                s.pomodoro.widget:set_markup(" today: " .. tostring(pomodoro_count) .. " | ")
                naughty.notify({
                    title = "u made it",
                    --text  = string.format("%s %s timeout", timeout, s.pomodoro.minute_t),
                    text  = string.format("stay focused"),
                    height = 1000,
                    width = 1000,
                    position = 'top_middle',
                    margin = {
                      top = 440,
                      left = 390
                    },
                    icon = "/home/mhhmm/Pictures/emotes/pomodoro.png",
                    ignore_suspend = true,
                    border_color = "#FF6347",
                    fg = "#FF6347",
                })
            end
        end)
        s.pomodoro.timer:start()
    end
 
    s.pomodoro.icon:buttons(awful.util.table.join(
        awful.button({}, 1, function() s.pomodoro.set() end), -- left click
        awful.button({}, 3, function() -- right click
            if s.pomodoro.timer and s.pomodoro.timer.started then
                s.pomodoro.widget:set_markup(" | ")
                s.pomodoro.timer:stop()
                naughty.notify({ title = "Countdown", text  = "Timer stopped" })
            end

            pomodoro_count = 0
            s.pomodoro.widget:set_markup(" today: " .. tostring(pomodoro_count) .. " | ")
        end)
    ))


    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "bottom",
        bg       = "#1d2021",
        fg       = "#ebdbb2",
        screen   = s,
        widget   = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist,
                s.mypromptbox,
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,

                --s.todo_urgent.icon,
                --s.todo_urgent,

                --time_to_run,

                s.twitch.icon,
                s.twitch,

                s.pomodoro.icon,
                s.pomodoro.widget,

                s.water_me.icon,
                s.water_me.widget,

                {
                  id = "dnd",
                  widget = s.noti_status,
                },
                s.myRam,
                --s.myBattery,
                wibox.widget.systray(),
                mytextclock,
            },
        }
    }
end)

-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})
-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "y", function() 
        naughty.toggle()
        screen[1].mywibox.widget:get_children_by_id("dnd")[1].text = " dnd: "  .. tostring(naughty.is_suspended())  .. " | ";
    end, {description = "Toggle hide notifications", group = "recording"}),
    
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),
    awful.key({ modkey }, "d", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Shift" }, "s",      function () 
      client.focus.sticky = not client.focus.sticky  
    end),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({ modkey, "Shift" }, "Tab",
        function ()
            awful.client.focus.byidx(1)
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:activate { raise = true, context = "key.unminimize" }
                  end
              end,
              {description = "restore minimized", group = "client"}),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
})


awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey,           }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        awful.key({                   }, "Alt_R", function () just_run("flameshot full --clipboard --path /home/mhhmm/Pictures/Screenshots") end),
        awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
                {description = "close", group = "client"}),
        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
                {description = "toggle floating", group = "client"}),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "client"}),
        awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "move to screen", group = "client"}),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "toggle keep on top", group = "client"}),
        awful.key({ modkey,           }, "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "minimize", group = "client"}),
        awful.key({ modkey,           }, "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "(un)maximize", group = "client"}),
        awful.key({ modkey, "Control" }, "m",
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end ,
            {description = "(un)maximize vertically", group = "client"}),
        awful.key({ modkey, "Shift"   }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end ,
            {description = "(un)maximize horizontally", group = "client"}),
    })
end)

-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- ruled.client.append_rule {
    --     rule       = { class = "Firefox"     },
    --     properties = { screen = 1, tag = "2" }
    -- }
end)
-- }}}

-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)


-- {{{ Autostart
--
-- Autorun programs

local function run_once_grep(command)
	awful.spawn.easy_async_with_shell(string.format("ps aux | grep '%s' | grep -v 'grep'", command), function(stdout)
		if stdout == "" or stdout == nil then
			awful.spawn(command, false)
		end
	end)
end

-- List of apps to start once on start-up
local autostart_app = {
  "ibus-daemon -drxR",
  "amixer set Master 100%",
  -- "openrgb --server --profile pp.orp & && disown $(jobs -lp | awk '{print $1}')"
  -- "openrgb --server -d 0 -c random -d 1 -c random -d 2 -c random & && disown $(jobs -lp | awk '{print $1}')"
  "picom -b"
}

for _, app in ipairs(autostart_app) do
	run_once_grep(app)
end

just_run("openrgb --server --profile pp.orp & && disown $(jobs -lp | awk '{print $1}')")

--
-- }}}

-- garbage
-- ============
collectgarbage("setpause", 160)
collectgarbage("setstepmul", 400)

gears.timer.start_new(10, function()
  collectgarbage("step", 20000)
  return true
end)
