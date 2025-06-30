local awful = require("awful")
local wibox = require("wibox")

local pkg_widget = wibox.widget.textbox()

local function update_widget(widget)
    awful.spawn.easy_async("paru -Qu", function(stdout)
        local count = 0
        for _ in stdout:gmatch("[^\r\n]+") do
            count = count + 1
        end
        widget.markup = count > 0 and ("<span font='MesloLGS Nerd Font Bold'>  " .. count .. " Pkgs |</span>") or ""
        awful.tooltip({
            objects = {widget},
            text = (stdout ~= "" and stdout or "Nenhuma atualização disponível"),
        })
    end)
end

awful.widget.watch("sleep 300", 300, update_widget, pkg_widget)  -- 5 minutos (ajuste como quiser)
return pkg_widget