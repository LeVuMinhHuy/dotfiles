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
		  	id = "temp",
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

  local max_temp = 80
  
  awful.spawn.easy_async_with_shell(
  	[[
  	temp_path=null
  	for i in /sys/class/hwmon/hwmon*/temp*_input;
  	do
  		temp_path="$(echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null ||
  			echo $(basename ${i%_*})) $(readlink -f $i)");"
  
  		label="$(echo $temp_path | awk '{print $2}')"
  
  		if [ "$label" = "Package" ];
  		then
  			echo ${temp_path} | awk '{print $5}' | tr -d ';\n'
  			exit;
  		fi
  	done
  	]],
  	function(stdout)
  		local temp_path = stdout:gsub("%\n", "")
  		if temp_path == "" or not temp_path then
  			temp_path = "/sys/class/thermal/thermal_zone0/temp"
  		end
  
  		watch([[
  			sh -c "cat ]] .. temp_path .. [["
  			]], 10, function(_, stdout)
  			local temp = stdout:match("(%d+)")
  
    	widget.temp:set_markup(helpers.colorize_text("temp: ", beautiful.vcolor2) .. string.format("%.2f", (temp / 1000) / max_temp * 100))
  			collectgarbage("collect")
  		end)
  	end
  )

	return widget_button
end

return return_button
