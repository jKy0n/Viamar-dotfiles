--[[
        jKyon (John Kennedy Loria Segundo)
        notify_manager.lua – awesomeWM
        2025-07-10

        Purpose:
            Manages notifications in AwesomeWM.
            Configures default settings for notifications, enhancing user experience.

            Gerencia notificações no AwesomeWM.
            Configura as definições padrão para notificações, melhorando a experiência do usuário.
--]]

--------------------------------------------------------------
----------------------  Load Libraries  ----------------------
local naughty = require("naughty")

--------------------------------------------------------------
---------------------  notify_manager module  ----------------
local notify_manager = {}

-- notifications default configuration
naughty.config.defaults = {
    timeout = 10, -- Tempo de exibição em segundos
    -- screen = awful.screen.focused(), -- Qual tela exibir as notificações
    screen = 2, -- Qual tela exibir as notificações
    position = "top_left", -- Posição: 'top_right', 'top_left', 'bottom_right', 'bottom_left'
    margin = 10,
    ontop = true,
    font = "MesloLGS Nerd Font Bold 10", -- Fonte
    icon_size = 300,
    border_width = 2,
}

return notify_manager