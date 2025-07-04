local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local pkg_widget = wibox.widget.textbox()

local pkg_tooltip = awful.tooltip({
    objects = {},
    text = "Nenhuma atualização disponível",
    visible = false,
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal,
    font = beautiful.font,
    -- border_width = beautiful.border_width or 2,
    -- border_color = beautiful.border_focus or "#8aadf4",
    -- opacity = 1,
})

local function update_widget(widget)
    awful.spawn.easy_async("paru -Qu", function(stdout)
        local count = 0
        for _ in stdout:gmatch("[^\r\n]+") do
            count = count + 1
        end
        widget.markup = count > 0 and ("<span font='MesloLGS Nerd Font Bold'>  " .. count .. " Pkgs |</span>") or ""
        pkg_tooltip.text = (stdout ~= "" and stdout or "Nenhuma atualização disponível")
    end)
end

awful.widget.watch("sleep 3600", 3600, update_widget, pkg_widget)   --  Update every 5 minutes

pkg_widget:connect_signal("button::press", function(_, x, y, button)
    if button == 1 then
        if not pkg_tooltip.visible then
            pkg_tooltip.visible = true
            pkg_tooltip.x = mouse.current_widget_geometry.x
            pkg_tooltip.y = mouse.current_widget_geometry.y + 20
        else
            pkg_tooltip.visible = false
        end
    end
end)

return pkg_widget