local awful = require("awful")
local wibox = require("wibox")

-- Função para criar o widget configurável
local function cpu_monitor(args)
    args = args or {}
    local show_usage, show_freq, show_temp = false, false, false
    local sep = "  "  -- Espaçamento entre itens

    -- Checa quais informações mostrar
    for _, v in ipairs(args) do
        if v == "usage" then show_usage = true end
        if v == "freq"  then show_freq  = true end
        if v == "temp"  then show_temp  = true end
    end

    local icon = '<span font="Font Awesome 11">  </span> '
    local widget = wibox.widget {
        markup = icon .. " Loading... ",
        widget = wibox.widget.textbox
    }
    -- widget.forced_width = 150  -- Ajuste conforme necessário

    -- Atualiza o widget periodicamente
    awful.widget.watch(
        "sh /home/jkyon/ShellScript/Viamar-PC/StatusBar-Scripts/CPU-monitor.sh",
        1, -- intervalo em segundos
        function(w, stdout)
            -- Processa a saída formatada
            local usage = stdout:match("usage_percent:%s*(%d+)")
            local freq = stdout:match("frequency_GHz:%s*([%d%.]+)")
            local temp = stdout:match("temperature_Celsius:%s*(%d+)")

            local items = {}
            if show_usage and usage then table.insert(items, string.format("%3s%%", usage)) end
            if show_freq  and freq  then table.insert(items, string.format("%4sGHz", freq)) end
            if show_temp  and temp  then table.insert(items, string.format("%3s°C ", temp)) end

            w.markup = icon .. "<span font='MesloLGS NF Mono,Bold 8.5'>" .. table.concat(items, sep) .. "</span>"
        end,
        widget
    )

    return widget
end

return cpu_monitor