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

-- gears timer for garbage collector
local gears = require("gears")

--------------------------------------------------------------
-----------------------  Log Generator  ----------------------

local function rc_log(msg)
    local log_path = os.getenv("HOME") .. "/.logs/awesome/rc/rc.log"
    local f = io.open(log_path, "a")
    if f then
        f:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. tostring(msg) .. "\n")
        f:close()
    end
end

rc_log("rc.lua: --- inicio da configuração ---")

--------------------------------------------------------------
-----------------  Load variable definitions  ----------------

rc_log("rc.lua: Carregando Tema")

-- Theme handling library
local beautiful = require("beautiful")
beautiful.init("/home/jkyon/.config/awesome/themes/jKyon/theme.lua")

rc_log("rc.lua: Tema carregado")

--------------------------------------------------------------
-----------------  Load variable definitions  ----------------

rc_log("rc.lua: Carregando variáveis de ambiente")

terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

rc_log("rc.lua: Variáveis de ambiente carregadas")

--------------------------------------------------------------
-----------------------  Load Modules  -----------------------

rc_log("rc.lua: Carregando módulos")

local notify_manager = require("modules.notify_manager")
local errors_handling = require("modules.errors_handling")
local layouts = require("modules.layouts")
local tag_utils = require("modules.tag_utils")
local tags = require("modules.tags")
    tags.setup()
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

rc_log("rc.lua: Módulos carregados")

--------------------------------------------------------------
---------------------  Garbage Collector  --------------------

rc_log("rc.lua: Configurando Garbage Collector")

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

rc_log("rc.lua: Garbage Collector configurado")

awful.spawn.easy_async_with_shell(
    "systemctl --user is-active --quiet awesome-session.target || systemctl --user start awesome-session.target",
    function() end
)

awesome.connect_signal("exit", function(restarting)
    if not restarting then
        awful.spawn.with_shell("systemctl --user stop awesome-session.target")
    end
end)


rc_log("rc.lua: --- fim da inicialização ---")