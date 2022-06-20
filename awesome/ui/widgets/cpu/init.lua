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
		  	id = "cpu_usage",
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

  local total_prev = 0
  local idle_prev = 0
  
  watch(
  	[[bash -c "
  	cat /proc/stat | grep '^cpu '
  	"]],
  	10,
  	function(_, stdout)
  		local user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice = stdout:match(
  			"(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s"
  		)
  
  		local total = user + nice + system + idle + iowait + irq + softirq + steal
  
  		local diff_idle = idle - idle_prev
  		local diff_total = total - total_prev
  		local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10
  
  		widget.cpu_usage:set_markup(helpers.colorize_text("cpu: ", beautiful.vcolor2) .. string.format("%.2f", diff_usage))
  
  		total_prev = total
  		idle_prev = idle
  		collectgarbage("collect")
  	end
  )
	return widget_button
end

return return_button
