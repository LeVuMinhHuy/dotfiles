local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. "ui/widgets/control-center-switch/icons/"
local clickable_container = require("ui.widgets.clickable-container")
local icons = require("icons")
local monitor_mode = false
local helpers = require("helpers")

local return_button = function()
	local widget = wibox.widget({
		{
			id = "icon",
			image = icons.memory,
			widget = wibox.widget.imagebox,
			resize = true,
		},
		layout = wibox.layout.align.horizontal,
	})

	local widget_button = wibox.widget({
    {
      {
			  {
			  	widget,
			  	margins = dpi(8),
			  	widget = wibox.container.margin,
			  },
			  widget = clickable_container,
		  },
		  bg = beautiful.transparent,
		  widget = wibox.container.background,
    },
    {
      align = "center",
		  valign = "center",
      markup = "<i>   " .. helpers.colorize_text("code wat u love, love wat u code", beautiful.vcolor2) .. "</i>",
	    font = beautiful.font_name .. " Regular 10",
		  widget = wibox.widget.textbox,
    },
		layout = wibox.layout.align.horizontal,
  })

	local control_center_switch_mode = function()
		local cc_widget = control_center.widget
		if monitor_mode then
			widget.icon:set_image(icons.memory)
			cc_widget:get_children_by_id("main_control")[1].visible = true
			cc_widget:get_children_by_id("monitor_control")[1].visible = false
		else
			widget.icon:set_image(widget_icon_dir .. "control-center.svg")
			cc_widget:get_children_by_id("main_control")[1].visible = false
			cc_widget:get_children_by_id("monitor_control")[1].visible = true
		end
		monitor_mode = not monitor_mode
	end

	widget_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
		control_center_switch_mode()
	end)))

	return widget_button
end

return return_button
