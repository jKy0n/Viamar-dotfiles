--[[
        jKyon (John Kennedy Loria Segundo)
        layouts.lua – awesomeWM
        2025-07-10

        Purpose:
            Custom layout configurations for AwesomeWM.
            Defines a set of layouts to be used in the window manager, enhancing user experience and workflow.

            Configurações de layout personalizadas para o AwesomeWM.
            Define um conjunto de layouts a serem usados no gerenciador de janelas, melhorando a experiência do usuário e o fluxo de trabalho.
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
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,

    awful.layout.suit.max,

    awful.layout.suit.floating,
}

return layouts