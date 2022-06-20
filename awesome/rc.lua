pcall(require, "luarocks.loader")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")
require("awful.autofocus")

local theme_dir = gears.filesystem.get_configuration_dir() .. "theme/"
beautiful.init(theme_dir .. "theme.lua")

-- configuration
-- =============
require("configuration")

-- modules
-- =============
require("module")

-- deamon
-- =============
require("signal")

-- ui
-- =============
require("ui")

-- wallpaper
-- =============
awful.screen.connect_for_each_screen(function(s)
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper

		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end

		gears.wallpaper.maximized(gears.surface.load_uncached(wallpaper), s, false, nil)
	end
end)

-- garbage
-- ============
-- Enable for lower memory consumption
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
