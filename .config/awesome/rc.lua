--[[
        jKyon (John Kennedy Loria Segundo)
        rc.lua – awesomeWM
        2025-07-10

        Purpose:
            Configuração personalizada e modularizada para o Viamar‑PC,
            maximizando performance, aparência e aproveitamento de tela.

            Tailored and modular configuration for the Viamar‑PC,
            maximizing performance, aesthetics, and efficient use of screen space.
--]]

--------------------------------------------------------------
---------------  Temporary workaround for lgi  ---------------

local lgi = require("lgi")
local Gio = lgi.Gio
local GioUnix = lgi.GioUnix

-- compatibilidade: se Gio.UnixInputStream não existir, aponta para GioUnix.InputStream
if not Gio.UnixInputStream and GioUnix then
    Gio.UnixInputStream = GioUnix.InputStream
    Gio.UnixOutputStream = GioUnix.OutputStream
end

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

--------------------------------------------------------------
----------------------  jKyon last adds  ---------------------

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