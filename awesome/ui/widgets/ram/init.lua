local awful = require("awful")
local watch = awful.widget.watch
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local apps = require("configuration.apps")
local clickable_container = require("ui.widgets.clickable-container")

local return_button = function()
	local widget = wibox.widget({
      {
		  	id = "ram_usage",
		  	align = "center",
		  	valign = "center",
	      font = beautiful.font_name .. " Regular 10",
		  	widget = wibox.widget.textbox,
		  },
		  layout = wibox.layout.align.horizontal,
  })

	local widget_button = wibox.widget({
		{
			widget,
			margins = dpi(8),
			widget = wibox.container.margin,
		},
		widget = clickable_container,
	})

	--widget_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
	--	awful.spawn(apps.default.network_manager, false)
	--end)))


  watch('bash -c "free | grep -z Mem.*Swap.*"', 10, function(_, stdout)
  	local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap = stdout:match(
  		"(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)"
  	)
  	widget.ram_usage:set_markup(helpers.colorize_text("ram: ", beautiful.vcolor2) .. string.format("%.2f", used / total * 100))
  	collectgarbage("collect")
  end)


	return widget_button
end

return return_button
