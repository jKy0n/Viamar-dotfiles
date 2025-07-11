--[[
        jKyon (John Kennedy Loria Segundo)
        errors_handling.lua – awesomeWM
        2025-07-10

        Purpose:
            Handles errors during startup and runtime in the AwesomeWM configuration.
            Provides notifications for critical errors to assist in debugging.

            Gerencia erros durante a inicialização e em tempo de execução na configuração do AwesomeWM.
            Fornece notificações para erros críticos para auxiliar na depuração.
--]]

---------------------------------------------------------------
----------------------  Load Libraries  ----------------------
local naughty = require("naughty")

----------------------------------------------------------------
----------------------  errors_handling module  ----------------
local errors_handling = {}


if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

return errors_handling