--[[
        jKyon (John Kennedy Loria Segundo)
        signals.lua – awesomeWM
        2025-07-10

        Purpose:
            Defines signal handlers for client management in AwesomeWM.
            Enhances user experience by managing client focus, appearance, and behavior.

            Define manipuladores de sinal para gerenciamento de clientes no AwesomeWM.
            Melhora a experiência do usuário gerenciando o foco, a aparência e o comportamento dos clientes.
--]]

--------------------------------------------------------------
----------------------  Load Libraries  ----------------------
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

--------------------------------------------------------------
----------------------  signals module  ----------------------
local signals = {}


-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    client.connect_signal("manage", function (c)
        c.shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,10)  -- <--- set the radius 
        end
    end)

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- Focus on client when it is focused.
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

return signals