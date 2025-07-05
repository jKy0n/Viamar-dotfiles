local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function rtrim(s)
    return s:match("^(.-)%s*$")
end

local pkg_widget = wibox.widget.textbox()

local pkg_tooltip = awful.tooltip({
    objects = {},
    text = "Nenhuma atualização disponível",
    visible = false,
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal,
    font = beautiful.font,
    opacity = 1,
})

local function update_widget(widget)
    awful.spawn.easy_async("paru -Qu", function(stdout)
        local count = 0
        for _ in stdout:gmatch("[^\r\n]+") do
            count = count + 1
        end
        widget.markup = count > 0 and ("<span font='MesloLGS Nerd Font Bold'>  " .. count .. " Pkgs |</span>") or ""
        pkg_tooltip.text = (stdout ~= "" and rtrim(stdout) or "Nenhuma atualização disponível")
    end)
end

-- Atualiza imediatamente ao iniciar
update_widget(pkg_widget)

-- E depois usa o timer
awful.widget.watch("sleep 3600", 3600, update_widget, pkg_widget)   -- 1 hora

pkg_widget:connect_signal("button::press", function(_, x, y, button)
    if button == 1 then
        -- Esquerdo: tooltip on/off
        if not pkg_tooltip.visible then
            pkg_tooltip.visible = true
            pkg_tooltip.x = mouse.current_widget_geometry.x
            pkg_tooltip.y = mouse.current_widget_geometry.y + 20
        else
            pkg_tooltip.visible = false
        end
    elseif button == 3 then
        -- Direito: atualizar agora
        update_widget(pkg_widget)
    end
end)

return pkg_widget