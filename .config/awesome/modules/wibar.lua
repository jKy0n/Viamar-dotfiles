local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")


--- awesome-wm-widgets widgets ---
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")

local volume_widget = require('awesome-wm-widgets.pactl-widget.volume')
local todo_widget = require("awesome-wm-widgets.todo-widget.todo")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")

--- jKyon Widgets ---
local internet_widget = require("jkyon-widgets.internet_widget")
local dnd_widget = require ("jkyon-widgets.DoNotDisturb_widget")
local pkg_widget = require("jkyon-widgets.paru_update_checker")



tbox_separator_space = wibox.widget.textbox (" ")
tbox_separator_pipe = wibox.widget.textbox (" | ")
tbox_separator_dash = wibox.widget.textbox (" - ")

local function styled_textbox(text, font_size, margins)
    return wibox.widget {
        text = text,
        font = 'MesloLGS Nerd Font ' .. font_size,
        widget = wibox.widget.textbox,
        margins = margins
    }
end

local cpu_icon = styled_textbox('  ', 11, 2)
local ram_icon = styled_textbox('   ', 11, 2)
-- local gpu_icon = styled_textbox(' 󰢮 ', 16, 1)
local temp_icon = styled_textbox(' ', 11, 1)

-- Fixing CPU width on wibox
local cpu_usage = awful.widget.watch('bash -c "sh /home/jkyon/ShellScript/Viamar-PC/StatusBar-Scripts/CPU-usage-monitor.sh"', 1)
cpu_usage.forced_width = 30

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


local wibar = {}

function wibar.setup(s)

-------------------------------------------------------------------------    
-------------------------  Fisrt monitor Wibar  -------------------------
-------------------------------------------------------------------------

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
            pkg_widget, --  Paru update checker widget    <<<<<<
            tbox_separator_space,
            cpu_icon,   --  
            cpu_usage,  --  Shows CPU usage in %
            -- awful.widget.watch('bash -c "sh /home/jkyon/ShellScript/Viamar-PC/StatusBar-Scripts/CPU-usage-monitor.sh"', 1),
            tbox_separator_space,
            tbox_separator_space,   --  Shows CPU frequency in GHz
            awful.widget.watch('bash -c "sh /home/jkyon/ShellScript/Viamar-PC/StatusBar-Scripts/CPU-freq-monitor.sh"', 1),
            tbox_separator_space,
            temp_icon,  --  
            tbox_separator_space,   -- Shows CPU temperature in °C
            awful.widget.watch('bash -c "sh /home/jkyon/ShellScript/Viamar-PC/StatusBar-Scripts/CPU-temp-monitor.sh"', 1),
            tbox_separator_space,
            tbox_separator_pipe,    --  |
            cpu_widget(),           -- Graphical CPU usage widget
            tbox_separator_pipe,    --  |
            ram_icon,   --         --   Shows RAM usage in %
            awful.widget.watch('bash -c "sh /home/jkyon/ShellScript/Viamar-PC/StatusBar-Scripts/RAM-usage-monitor.sh"', 1),
            -- tbox_separator_space,   --  Graphical RAM usage widgets
            ram_widget({ color_used = '#8aadf4', color_buf = '#24273a' }),
------------------------------------------------------------------------------------------------            
            tbox_separator_pipe,
            tbox_separator_space,
            tbox_separator_space,

            volume_widget({         -- Volume control widget
                widget_type = 'arc',
                thickness   = 2 ,
                step        = 5 ,
                mixer_cmd   = 'pavucontrol',
                device      = '@DEFAULT_SINK@',
                tooltip     = false
            }),
            tbox_separator_space,
            todo_widget(),          -- To-do list widget
            tbox_separator_space,
            wibox.widget.systray(), -- System tray widget
            dnd_widget,             -- Do Not Disturb widget
            mytextclock,            -- Text clock widget

            logout_menu_widget{     -- Logout menu widget
                font = 'MesloLGS Nerd Font Bold 10',
                onlogout   =  function() awful.spawn.with_shell("loginctl terminate-user $USER") end,
                onlock     =  function() awful.spawn.with_shell('light-locker-command --lock') end,
                onsuspend  =  function() awful.spawn.with_shell("systemctl suspend") end,
                onreboot   =  function() awful.spawn.with_shell("systemctl reboot") end,
                onpoweroff =  function() awful.spawn.with_shell("systemctl poweroff") end,
            },
        },
    }

--------------------------------------------------------------------------    
-------------------------  Second monitor Wibar  -------------------------
--------------------------------------------------------------------------

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
            cpu_icon,   --   
            cpu_usage,  --  Shows CPU usage in %
            -- awful.widget.watch('bash -c "sh /home/jkyon/ShellScript/Viamar-PC/StatusBar-Scripts/CPU-usage-monitor.sh"', 1),
            tbox_separator_space,
            temp_icon,  --  
            tbox_separator_space,   -- Shows CPU temperature in °C
            awful.widget.watch('bash -c "sh /home/jkyon/ShellScript/Viamar-PC/StatusBar-Scripts/CPU-temp-monitor.sh"', 1),
            tbox_separator_space,
            ram_icon,   --     --  Shows RAM usage in %
            awful.widget.watch('bash -c "sh /home/jkyon/ShellScript/Viamar-PC/StatusBar-Scripts/RAM-usage-monitor.sh"', 1),
            tbox_separator_space,
------------------------------------------------------------------------------------------------            

            dnd_widget,     -- Do Not Disturb widget
            mytextclock,    -- Text clock widget

            logout_menu_widget{ -- Logout menu widget
                font = 'MesloLGS Nerd Font Bold 10',
                onlogout   =  function() awful.spawn.with_shell("loginctl terminate-user $USER") end,
                onlock     =  function() awful.spawn.with_shell('light-locker-command --lock') end,
                onsuspend  =  function() awful.spawn.with_shell("systemctl suspend") end,
                onreboot   =  function() awful.spawn.with_shell("systemctl reboot") end,
                onpoweroff =  function() awful.spawn.with_shell("systemctl poweroff") end,
            },
        },
    }
    end
end

return wibar