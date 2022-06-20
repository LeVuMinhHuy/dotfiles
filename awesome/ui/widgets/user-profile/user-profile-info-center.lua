local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi

local profile_name = wibox.widget({
	font = beautiful.font_name .. " Regular 10",
  align = "left",
	valign = "center",
	widget = wibox.widget.textbox,
})

local distro_name = wibox.widget({
	font = beautiful.font_name .. " Regular 10",
  align = "left",
	valign = "center",
	widget = wibox.widget.textbox,
})

local kernel_version = wibox.widget({
	font = beautiful.font_name .. " Regular 10",
  align = "left",
	valign = "center",
	widget = wibox.widget.textbox,
})

local packages = wibox.widget({
	font = beautiful.font_name .. " Regular 10",
  align = "left",
	valign = "center",
	widget = wibox.widget.textbox,
})


awful.spawn.easy_async_with_shell(
	[[
		sh -c '
		fullname="$(getent passwd `whoami` | cut -d ':' -f 5 | cut -d ',' -f 1 | tr -d "\n")"
		if [ -z "$fullname" ];
		then
			printf "$(whoami)@$(hostname)"
		else
			printf "$fullname"
		fi
		'
		]],
	function(stdout)
		local stdout = stdout:gsub("%\n", "")
    local title = helpers.colorize_text("User:      ", beautiful.accent)
		profile_name:set_markup(title .. stdout)
	end
)

awful.spawn.easy_async_with_shell(
	[[
		cat /etc/os-release | awk 'NR==1'| awk -F '"' '{print $2}'
		]],
	function(stdout)
		local distroname = stdout:gsub("%\n", "")
    local title = helpers.colorize_text("Distro:    ", beautiful.accent)
		distro_name:set_markup(title .. distroname)
	end
)

awful.spawn.easy_async_with_shell("uname -r", function(stdout)
	local kname = stdout:gsub("%\n", "")
  local title = helpers.colorize_text("Kernel:    ", beautiful.accent)
	kernel_version:set_markup(title .. kname)
end)

awful.spawn.easy_async_with_shell(
  [[ pacman -Q | wc -l ]],
  function(stdout)
    local countPackages = stdout:gsub("%\n", "")
    local title = helpers.colorize_text("Packages:  ", beautiful.accent)
    packages:set_markup(title .. stdout)
  end
)



local user_profile = wibox.widget({
  margins = {
			top = dpi(5),
      bottom = dpi(5)
	},
	layout = wibox.container.margin,
	{
		layout = wibox.layout.align.vertical,
		expand = "none",
		nil,
		{
			layout = wibox.layout.fixed.vertical,
			profile_name,
			distro_name,
			kernel_version,
      packages
		},
		nil,
	},
})

return user_profile
