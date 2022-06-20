local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local naughty = require("naughty")
local helpers = require("helpers")
local ruled = require("ruled")
local menubar = require("menubar")
local icons = require("icons")

-- Notifications
------------------

naughty.connect_signal("request::icon", function(n, context, hints)
	if context ~= "app_icon" then
		return
	end

	local path = menubar.utils.lookup_icon(hints.app_icon) or menubar.utils.lookup_icon(hints.app_icon:lower())

	if path then
		n.icon = path
	end
end)

naughty.config.defaults.ontop = true
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 4
naughty.config.defaults.title = "Notification"
naughty.config.defaults.position = "top_middle"

naughty.config.presets.low.timeout = 3
naughty.config.presets.critical.timeout = 0

naughty.config.presets.normal = {
	font = beautiful.font_name .. " Regular 10",
	fg = beautiful.fg_normal,
	bg = beautiful.bg_normal,
}

naughty.config.presets.low = {
	font = beautiful.font_name .. " Regular 10",
	fg = beautiful.fg_normal,
	bg = beautiful.bg_normal,
}

naughty.config.presets.critical = {
	font = beautiful.font_name .. " Bold 10",
	fg = beautiful.xcolor1,
	bg = beautiful.bg_normal,
	timeout = 0,
}

naughty.config.presets.ok = naughty.config.presets.normal
naughty.config.presets.info = naughty.config.presets.normal
naughty.config.presets.warn = naughty.config.presets.critical

ruled.notification.connect_signal("request::rules", function()
	-- All notifications will match this rule.
	ruled.notification.append_rule({
		rule = {},
		properties = { screen = awful.screen.preferred, implicit_timeout = 6 },
	})
end)

naughty.connect_signal("request::display", function(n)
	local appicon = n.app_icon
	if not appicon then
		appicon = gears.color.recolor_image(icons.notification, beautiful.accent)
	end
	local time = os.date("%I:%M %p")

	local action_widget = {
		{
			{
				id = "text_role",
				align = "center",
				valign = "center",
				font = beautiful.font_name .. " Regular 10",
				widget = wibox.widget.textbox,
			},
			left = dpi(6),
			right = dpi(6),
			widget = wibox.container.margin,
		},
		bg = beautiful.lighter_bg,
		forced_height = dpi(25),
		forced_width = dpi(20),
		shape = helpers.rrect(beautiful.border_radius),
		widget = wibox.container.background,
	}

	local actions = wibox.widget({
		notification = n,
		base_layout = wibox.widget({
			spacing = dpi(8),
			layout = wibox.layout.flex.horizontal,
		}),
		widget_template = action_widget,
		style = { underline_normal = false, underline_selected = true },
		widget = naughty.list.actions,
	})

	helpers.add_hover_cursor(actions, "hand2")

	naughty.layout.box({
		notification = n,
		type = "notification",
		bg = beautiful.transparent,
		widget_template = {
			{
				{
					{
						{
							{
								{
									{
										{
											image = appicon,
											resize = true,
											widget = wibox.widget.imagebox,
										},
										strategy = "max",
										height = dpi(20),
										widget = wibox.container.constraint,
									},
									right = dpi(10),
									widget = wibox.container.margin,
								},
								{
									markup = n.app_name,
									align = "left",
									font = beautiful.font_name .. " Bold 10",
									widget = wibox.widget.textbox,
								},
								{
									markup = time,
									align = "right",
									font = beautiful.font_name .. " Bold 10",
									widget = wibox.widget.textbox,
								},
								layout = wibox.layout.align.horizontal,
							},
							top = dpi(10),
							left = dpi(20),
							right = dpi(20),
							bottom = dpi(10),
							widget = wibox.container.margin,
						},
						bg = beautiful.darker_bg,
						widget = wibox.container.background,
					},
					{
						{
							{
								helpers.vertical_pad(10),
								{
									{
										step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
										speed = 50,
										{
											markup = n.title,
											font = beautiful.font_name .. " Bold 10",
											align = "left",
											widget = wibox.widget.textbox,
										},
										forced_width = dpi(210),
										widget = wibox.container.scroll.horizontal,
									},
									{
										step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
										speed = 50,
										{
											markup = n.message,
											align = "left",
											font = beautiful.font_name .. " Regular 10",
											widget = wibox.widget.textbox,
										},
										forced_width = dpi(210),
										widget = wibox.container.scroll.horizontal,
									},
									spacing = 0,
									layout = wibox.layout.flex.vertical,
								},
								helpers.vertical_pad(10),
								layout = wibox.layout.align.vertical,
							},
							left = dpi(20),
							right = dpi(20),
							widget = wibox.container.margin,
						},
						{
							{
								nil,
								{
									{
										image = n.icon,
										resize = true,
										clip_shape = helpers.rrect(beautiful.border_radius),
										widget = wibox.widget.imagebox,
									},
									strategy = "max",
									height = dpi(40),
									widget = wibox.container.constraint,
								},
								nil,
								expand = "none",
								layout = wibox.layout.align.vertical,
							},
							margins = dpi(10),
							widget = wibox.container.margin,
						},
						layout = wibox.layout.fixed.horizontal,
					},
					{
						{ actions, layout = wibox.layout.fixed.vertical },
						margins = dpi(10),
						visible = n.actions and #n.actions > 0,
						widget = wibox.container.margin,
					},
					layout = wibox.layout.fixed.vertical,
				},
				top = dpi(0),
				bottom = dpi(5),
				widget = wibox.container.margin,
			},
			bg = beautiful.xbackground,
			shape = helpers.rrect(beautiful.border_radius),
			widget = wibox.container.background,
		},
	})

	-- Destroy popups notifs if dont_disturb mode is on
	-- Or if the Dashboard is visible
	if _G.dnd_state or (dashboard and dashboard.visible) then
		naughty.destroy_all_notifications(nil, 1)
	end
end)
