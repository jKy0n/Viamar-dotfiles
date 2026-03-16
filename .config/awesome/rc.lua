--[[
        Title:   rc.lua
        Brief:   main configuration file for awesomeWM
        Path:    /home/jkyon/.config/awesome/rc.lua
        Author:  John Kennedy a.k.a. jKyon
        Created: 2025-07-10
        Updated: 2026-03-16
        Notes:
                Configuração personalizada e modularizada para o Viamar‑PC,
                maximizando performance, aparência e aproveitamento de tela.

                Tailored and modular configuration for the Viamar‑PC,
                maximizing performance, aesthetics, and efficient use of screen space.
--]]


--------------------------------------------------------------
-----------------------  First steps  ------------------------
-- Load luarocks
pcall(require, "luarocks.loader")

-- Standard awesome library required
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")
beautiful.init("/home/jkyon/.config/awesome/themes/jKyon/theme.lua")

-- gears timer for garbage collector
local gears = require("gears")

--------------------------------------------------------------
-----------------  Load variable definitions  ----------------

terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

--------------------------------------------------------------
-----------------------  Load Modules  -----------------------

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
local wallpaper = require("modules.wallpaper")

--------------------------------------------------------------
---------------------  Garbage Collector  --------------------

-- Tune incremental GC: collect more aggressively in the background
-- to avoid large heap buildup during 24/7 uptime
collectgarbage("setpause", 110)     -- start new cycle when memory grows 10% (default: 200)
collectgarbage("setstepmul", 1000)  -- larger steps per cycle (default: 200)

gears.timer {
    timeout   = 1800,               -- @ 30 minutes (better for 24/7 uptime)
    autostart = true,               -- start timer when rc.lua is loaded
    call_now  = true,               -- clean up right at startup
    callback  = function()
        collectgarbage("collect")   -- perform a full garbage collection cycle
    end,
}