--[[
    This file is part of jKyon's AwesomeWM configuration.
--]]

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")

-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/jkyon/.config/awesome/themes/jKyon/theme.lua")


--- Variable definitions ---
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"


--- Modules ---
local notify_manager = require("modules.notify_manager")
local errors_handling = require("modules.errors_handling")

local layouts = require("modules.layouts")
local tags_utils = require("modules.tags_utils")
local tags = require("modules.tags")

local buttons = require("modules.buttons")
local taglist_buttons = buttons.taglist_buttons(modkey)
local tasklist_buttons = buttons.tasklist_buttons()

local wibar_manager = require("modules.wibar_manager")
wibar_manager.setup(taglist_buttons, tasklist_buttons)

local keys = require("modules.keys")
root.keys(globalkeys)
local rules = require("modules.rules")
local signal = require("modules.signals")


----------------------------------------------------
-------------------- jKyon adds --------------------

--- Set screen layout
awful.spawn.with_shell("sh /home/jkyon/.screenlayout/screenlayout.sh")
--- Set wallpaper
awful.spawn.with_shell("feh --bg-fill --no-xinerama ~/Pictures/Wallpapers/blueNebula.jpg")


--- Start awesome target on systemd (screensaver dependency)
awful.spawn.easy_async_with_shell(
  "systemctl --user start awesomewm.target",
  function() end
)
--- Start some applications
awful.spawn.with_shell("sh /home/jkyon/.config/awesome/autorun.sh")