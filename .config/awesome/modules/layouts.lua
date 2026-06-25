--[[
--       Title:      layouts.lua
--       Brief:
--       Path:       /home/jkyon/.config/awesome/modules/layouts.lua
--       Author:     John Kennedy a.k.a. jKyon
--       Created:    2025-07-10
--       Updated:    2026-06-25
--       Notes:
--                   Custom layout configurations for AwesomeWM.
--                   Defines a set of layouts to be used in the window manager, enhancing user experience and workflow.
--
--                   Configurações de layout personalizadas para o AwesomeWM.
--                   Define um conjunto de layouts a serem usados no gerenciador de janelas, melhorando a experiência do usuário e o fluxo de trabalho.
--]]


--------------------------------------------------------------
----------------------  Load Libraries  ----------------------
local awful = require("awful")

---------------------------------------------------------------
----------------------  layouts module  ----------------------
local layouts = {}

---------------------------------------------------------------
---------------------  layouts available  ---------------------
awful.layout.layouts = {
    -- tile horizontal layouts
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,

    -- tile vertical layouts
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,

    -- maximized layout
    awful.layout.suit.max,
}

return layouts