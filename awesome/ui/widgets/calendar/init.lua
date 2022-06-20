local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local icons = require("icons")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- calendar
local styles = {}

styles.month = {
	bg_color = "#00000000",
	border_width = 0,
}

styles.normal = {
	padding = dpi(6),
}

styles.focus = {
	fg_color = beautiful.xforeground,
	markup = function(t)
		return "<b>" .. t .. "</b>"
	end,
	bg_color = beautiful.accent,
	padding = dpi(6),
	shape = gears.shape.circle,
}

styles.header = {
	fg_color = beautiful.xforeground,
	bg_color = "#00000000",
	markup = function(t)
		return '<span font="Cascadia Code 12">' .. t .. "</span>"
	end,
}

styles.weekday = {
	fg_color = beautiful.accent,
	markup = function(t)
		return '<span font="Cascadia Code">' .. string.lower(t) .. "</span>"
	end,
}

local function decorate_cell(widget, flag, date)
	if flag == "monthheader" and not styles.monthheader then
		flag = "header"
	end
	local props = styles[flag] or {}
	if props.markup and widget.get_text and widget.set_markup then
		widget:set_markup(props.markup(widget:get_text()))
	end
	-- Change fg color for weekends
	local d = { year = date.year, month = (date.month or 1), day = (date.day or 1) }
	local weekday = tonumber(os.date("%w", os.time(d)))
  local currentMonth = tonumber(os.date("%m"))
  local isInCurrentMonth = (currentMonth==date.month) and true or false
  local default_fg = (weekday==0 or weekday==6) and "#B25068" or beautiful.fg_normal 
	local ret = wibox.widget({
		{
			widget,
			margins = (props.padding or 0) + (props.border_width or 0),
			widget = wibox.container.margin,
		},
		shape = props.shape ,
		shape_border_color = props.border_color,
		shape_border_width = props.border_width or 0,
		fg = props.fg_color or default_fg,
		bg = isInCurrentMonth and props.bg_color or beautiful.transparent,
		widget = wibox.container.background,
	})
	return ret
end

local calendar = wibox.widget({
	date = os.date("*t"),
	font = beautiful.font_name .. " 10",
	long_weekdays = false,
	start_sunday = true,
	fn_embed = decorate_cell,
	widget = wibox.widget.calendar.month,
})

local button = function(icon_path)
	local widget = wibox.widget({
		{
			image = icon_path,
			resize = true,
			forced_width = dpi(16),
			forced_height = dpi(16),
			widget = wibox.widget.imagebox
		},
		margins = dpi(2),
		widget = wibox.container.margin,
	})

	local old_cursor, old_wibox

	widget:connect_signal("mouse::enter", function(c)
		local wb = mouse.current_wibox
		old_cursor, old_wibox = wb.cursor, wb
		wb.cursor = "hand1"
	end)
	widget:connect_signal("mouse::leave", function(c)
		if old_wibox then
			old_wibox.cursor = old_cursor
			old_wibox = nil
		end
	end)

	return widget
end

local button_previous = button(icons.previous)
local button_next = button(icons.next)

button_previous:buttons(gears.table.join(awful.button({}, 1, function()
	local date = calendar:get_date()
	date.month = date.month - 1
	calendar:set_date(nil)
	calendar:set_date(date)
end)))

button_next:buttons(gears.table.join(awful.button({}, 1, function()
	local date = calendar:get_date()
	date.month = date.month + 1
	calendar:set_date(nil)
	calendar:set_date(date)
end)))

local calendar_widget = wibox.widget({
	layout = wibox.layout.align.vertical,
	{
		calendar,
		margins = dpi(5),
		widget = wibox.container.margin,
	},
	{
		{
			layout = wibox.layout.align.horizontal,
			expand = "inside",
			nil,
			nil,
			{
				layout = wibox.layout.align.horizontal,
				button_previous,
				button_next,
			},
		},
		margins = dpi(5),
		widget = wibox.container.margin,
	},
})

return calendar_widget
