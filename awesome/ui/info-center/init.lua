local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")

-- Appearance
local box_radius = dpi(5)
local box_gap = dpi(10)

local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
	local box_container = wibox.container.background()
	box_container.bg = bg_color
	box_container.forced_height = height
	box_container.forced_width = width
	box_container.shape = helpers.rrect(box_radius)

	local boxed_widget = wibox.widget({
		-- Add margins
		{
			-- Add background color
			{
				-- Center widget_to_be_boxed horizontally
				nil,
				{
					-- Center widget_to_be_boxed vertically
					nil,
					-- The actual widget goes here
					widget_to_be_boxed,
					layout = wibox.layout.align.vertical,
					expand = "none",
				},
				layout = wibox.layout.align.horizontal,
				expand = "none",
			},
			widget = box_container,
		},
		margins = box_gap,
		color = "#FF000000",
		widget = wibox.container.margin,
	})

	return boxed_widget
end

awful.screen.connect_for_each_screen(function(s)
	local info_center_width = dpi(600)
	local info_center_height = dpi(500)

	info_center = awful.popup({
		type = "dock",
		screen = s,
		width = dpi(info_center_width),
		maximum_width = dpi(info_center_width),
		maximum_height = dpi(info_center_height),
		bg = beautiful.transparent,
		ontop = true,
		visible = false,
		widget = {},
	})

	-- Day
	local day = wibox.widget({
		font = "Brightside 48",
		format = helpers.colorize_text("%A", beautiful.accent),
		align = "center",
		valign = "center",
		widget = wibox.widget.textclock,
	})

	-- Calendar
	s.calendar = require("ui.widgets.calendar")
	info_center:connect_signal("property::visible", function()
		if info_center.visible then
			s.calendar.date = os.date("*t")
		end
	end)

	-- Profile
	s.user_profile = require("ui.widgets.user-profile.user-profile-info-center")


  -- Notification
  local notif_center_widget = {
			{
				layout = wibox.layout.flex.horizontal,
				spacing = dpi(10),
				spacing_widget = wibox.widget.separator({
					span_ratio = 0.80,
					color = beautiful.dashboard_bg,
				}),
				require("ui.widgets.notif-center")(s),
			},
			bg = beautiful.widget_bg,
			widget = wibox.container.background,
	}
  s.notif_center = notif_center_widget 

	local day_box = create_boxed_widget(day, dpi(270), dpi(125), beautiful.widget_bg)
	local calendar_box = create_boxed_widget(s.calendar, dpi(270), dpi(330), beautiful.widget_bg)
	local user_profile_box = create_boxed_widget(s.user_profile, dpi(270), dpi(90), beautiful.widget_bg)
  local notif_center = create_boxed_widget(s.notif_center, dpi(270), dpi(365), beautiful.widget_bg)

	info_center:setup({
		{
			{
				layout = wibox.layout.fixed.horizontal,
				{
					layout = wibox.layout.fixed.vertical,
					day_box,
					calendar_box,
				},
				{
					layout = wibox.layout.fixed.vertical,
					user_profile_box,
          notif_center,
				},
			},
			margins = dpi(10),
			widget = wibox.container.margin,
		},
		bg = beautiful.wibar_bg,
		shape = helpers.rrect(beautiful.border_radius),
		widget = wibox.container.background,
	})

	awful.placement.top(info_center, {
		honor_workarea = true,
		parent = s,
		margins = {
			top = dpi(60),
		},
	})

	-- Make toogle button
	local info_center_show = function()
		info_center.visible = true
		info_center:emit_signal("opened")
	end

	local info_center_hide = function()
		info_center.visible = false
		info_center:emit_signal("closed")
	end

	function info_center:toggle()
		if self.opened then
			info_center_hide()
		else
			info_center_show()
		end
		self.opened = not self.opened
	end
end)
