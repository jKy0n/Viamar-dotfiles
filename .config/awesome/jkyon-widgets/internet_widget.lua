--[[
    jKyon (John Kennedy Loria Segundo)
    internet_widget.lua – awesomeWM


    Purpose:
        Widget to check internet connection status and display it in the AwesomeWM status bar.
        It checks if the internet is working and if the network interface is limited to 100 Mbps.

        Widget para verificar o status da conexão com a internet e exibi-lo na barra de status do AwesomeWM.
        Verifica se a internet está funcionando e se a interface de rede está limitada a 100 Mbps.
--]]

-------------------------------------------------------------
---------------------  Load Libraries  ----------------------
local awful = require("awful")
local wibox = require("wibox")

-------------------------------------------------------------
-------------------  Internet Widget  -----------------------
local internet_widget = {}

-- Função para verificar a conexão com a internet
local function check_internet()
    awful.spawn.easy_async_with_shell("ping -c 1 8.8.8.8", function(stdout, stderr, reason, exit_code)
        if exit_code == 0 then
            -- Se o ping for bem-sucedido, a internet está funcionando
            awful.spawn.easy_async_with_shell("lshw -C network | grep capacity", function(stdout, stderr, reason, exit_code)
                if stdout:match("100Mbit/s") then
                    -- Se a capacidade da interface de rede for 100 Mbps, a conexão pode estar limitada
                    internet_widget:set_markup("<span font='MesloLGS Nerd Font Bold 9' color='yellow'> ⚠️ Conexão limitada |</span>")
                else
                    -- Se a capacidade da interface de rede for diferente de 100 Mbps, a conexão está normal e o widget fica invisível
                    internet_widget:set_markup("")
                end
            end)
        else
            -- Se o ping falhar, a internet não está funcionando e o widget mostra uma mensagem
            internet_widget:set_markup("<span font='MesloLGS Nerd Font Bold 9' color='red'> 🔴 SEM INTERNET |</span>")
        end
    end)
end

-- Criando o widget
internet_widget = wibox.widget.textbox()

-- Verificar a conexão com a internet a cada 30 segundos
awful.widget.watch("echo", 30, check_internet)

return internet_widget