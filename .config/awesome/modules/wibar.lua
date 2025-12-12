--[[
        jKyon (John Kennedy Loria Segundo)
        wibar.lua – awesomeWM
        2025-07-10

        Purpose:
            Defines the wibar (top bar) for AwesomeWM.
            Configures widgets, layouts, and appearance for the wibar, enhancing user interaction.

            Define a wibar (barra superior) para o AwesomeWM.
            Configura widgets, layouts e aparência da wibar, melhorando a interação do usuário.
--]]

--------------------------------------------------------------
----------------------  Load Libraries  ----------------------
local awful = require("awful")
local wibox = require("wibox")


--- awesome-wm-widgets widgets ---
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")

local volume_widget = require('awesome-wm-widgets.wpctl-widget.volume')
local todo_widget = require("awesome-wm-widgets.todo-widget.todo")
local weather_api_widget = require("awesome-wm-widgets.weather-api-widget.weather")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")

--- jKyon Widgets ---
local internet_widget = require("jkyon-widgets.internet_widget")
local dnd_widget = require ("jkyon-widgets.DoNotDisturb_widget")
local pkg_widget = require("jkyon-widgets.paru_update_checker")
local cpu_monitor = require("jkyon-widgets.cpu_monitor")
local ram_monitor = require("jkyon-widgets.ram_monitor")


--- Separators ---
tbox_separator_space = wibox.widget.textbox (" ")
tbox_separator_pipe = wibox.widget.textbox (" | ")
tbox_separator_dash = wibox.widget.textbox (" - ")


-- Fixing CPU width on wibox
local cpu_usage = awful.widget.watch('bash -c "sh /home/jkyon/ShellScript/Viamar-PC/StatusBar-Scripts/CPU-usage-monitor.sh"', 1)
cpu_usage.forced_width = 30

--- textclock and calendar widget ---
mytextclock = wibox.widget.textclock(' %a, %d %b - %H:%M ', 60)

local cw = calendar_widget({
    theme = 'naughty',
    placement = 'top_right',
    start_sunday = false,
    radius = 8,
--  with customized next/previous (see table above)
    previous_month_button = 1,
    next_month_button = 3,
})
mytextclock:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)

--------------------------------------------------------------
-------------------  wibar_manager module  -------------------
local wibar = {}

function wibar.setup(s)


-----------------------------------------------------------------
---------------------  Fisrt monitor Wibar  ---------------------

    if s.index == 1 then
        -- Primeiro monitor
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mylayoutbox,
            tbox_separator_space,
            -- mylauncher,
            s.mytaglist,
            tbox_separator_space,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,

            internet_widget,        --  Internet widget detect internet connection
            tbox_separator_space,
            pkg_widget,             --  Paru update checker widget
            tbox_separator_space,
            cpu_monitor({"usage", "freq", "temp"}),     --  Graphical CPU usage widget
            tbox_separator_pipe,    --  |
            cpu_widget(),           -- Graphical CPU usage widget
            tbox_separator_pipe,    --  |
            ram_monitor({"usage_available"}),  --  Shows RAM usage in % and Available RAM in GB
            ram_widget({ color_used = '#8aadf4', color_buf = '#24273a' }),
------------------------------------------------------------------------------------------------
            tbox_separator_pipe,
            tbox_separator_space,
            tbox_separator_space,

            volume_widget({         -- Volume control widget
                widget_type = 'arc',
                thickness   = 2 ,
                step        = 5 ,   -- 5% volume change per scroll
                mixer_cmd   = 'pavucontrol',
                device      = '@DEFAULT_SINK@',
                tooltip     = false
            }),
            tbox_separator_space,
            todo_widget(),          -- To-do list widget
            tbox_separator_space,
            wibox.widget.systray(), -- System tray widget
            dnd_widget,             -- Do Not Disturb widget
            weather_api_widget({
                api_key = 'b08df374f2a4412d887190759250711',
                coordinates = {'-24.0058', '-46.4028'}, -- Praia Grande, SP, Brazil
                units = 'metric',
                show_daily_forecast = true,
                show_hourly_forecast = true,
                timeout = 1800,     -- 30 minutes
                lang = 'en',
            }),
            tbox_separator_dash,
            mytextclock,            -- Text clock widget

            logout_menu_widget{     -- Logout menu widget
                font = 'MesloLGS Nerd Font Bold 10',
                onlogout   =  function() awful.spawn.with_shell("loginctl terminate-user $USER") end,
                onlock     =  function() awful.spawn.with_shell('dm-tool lock') end,
                onsuspend  =  function() awful.spawn.with_shell("systemctl suspend") end,
                onreboot   =  function() awful.spawn.with_shell("systemctl reboot") end,
                onpoweroff =  function() awful.spawn.with_shell("systemctl poweroff") end,

            },
        },
    }

-----------------------------------------------------------------
---------------------  Second monitor Wibar  --------------------

    elseif s.index == 2 then
        -- Primeiro monitor
            -- Add widgets to the wibox
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mylayoutbox,
            tbox_separator_space,
            -- mylauncher,
            s.mytaglist,
            tbox_separator_space,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,

            internet_widget,    -- Internet widget detect internet connection
            tbox_separator_space,
            cpu_monitor({"usage", "temp"}),     --  Graphical CPU usage widget
            tbox_separator_space,
            ram_monitor({"usage_available"}),   --  Shows RAM usage in % and Available RAM in GB
            tbox_separator_space,
------------------------------------------------------------------------------------------------

            dnd_widget,     -- Do Not Disturb widget
            mytextclock,    -- Text clock widget

            logout_menu_widget{ -- Logout menu widget
                font = 'MesloLGS Nerd Font Bold 10',
                onlogout   =  function() awful.spawn.with_shell("loginctl terminate-user $USER") end,
                onlock     =  function() awful.spawn.with_shell('dm-tool lock') end,
                onsuspend  =  function() awful.spawn.with_shell("systemctl suspend") end,
                onreboot   =  function() awful.spawn.with_shell("systemctl reboot") end,
                onpoweroff =  function() awful.spawn.with_shell("systemctl poweroff") end,
            },
        },
    }
    end
end

return wibar