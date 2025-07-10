-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/jkyon/.config/awesome/themes/jKyon/theme.lua")


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
local pkg_widget = require("jkyon-widgets.paru_update_checker") --  Paru update checker widget <<<< 




-- Configurar o tamanho padrão das notificações
local notify_manager = require("modules.notify_manager")

local errors_handling = require("modules.errors_handling")

-- {{{ Variable definitions

terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"


local layouts = require("modules.layouts")


-----------------  Widgets handler  -----------------

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
local mem_icon = styled_textbox('   ', 11, 2)
-- local gpu_icon = styled_textbox(' 󰢮 ', 16, 1)
local temp_icon = styled_textbox(' ', 11, 1)


-- Fixing CPU width on wibox
local cpu_usage = awful.widget.watch('bash -c "sh /home/jkyon/ShellScript/Viamar-PC/StatusBar-Scripts/CPU-usage-monitor.sh"', 1)
cpu_usage.forced_width = 30

-- {{{ Wibar
-- Create a textclock widget
-- mytextclock = wibox.widget.textclock()
mytextclock = wibox.widget.textclock(' %a, %d %b - %H:%M ', 60)

-----------------------------------------------------------------------------
----------------------  Calendar widget config  -------------------

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

tags_utils = require("modules.tags_utils")


-------------------  Tags Manipulation Functions  -------------------

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))


local tags = require("modules.tags")


    awful.screen.connect_for_each_screen(function(s)


    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({   position = "top",
                                screen = s,
                                opacity = 0.8,
                                border_width = 3,
                                shape = gears.shape.rounded_rect
    })


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
            mem_icon,   --         --   Shows RAM usage in %
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
            mem_icon,   --     --  Shows RAM usage in %
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

end)
-- }}}



local buttons = require("modules.buttons")
local keys = require("modules.keys")

local rules = require("modules.rules")

local signal = require("modules.signals")


----------------------------------------------------
-------------------- jKyon adds --------------------

--- Set screen layout
awful.spawn.with_shell("sh /home/jkyon/.screenlayout/screenlayout.sh")
--- Set wallpaper
awful.spawn.with_shell("feh --bg-fill --no-xinerama ~/Pictures/Wallpapers/blueNebula.jpg")


--- Start awesome target on systemd (screensaver dependency)
awful.spawn.easy_async_with_shell(
  "systemctl --user start awesomewm.target",
  function() end
)
--- Start some applications
awful.spawn.with_shell("sh /home/jkyon/.config/awesome/autorun.sh")