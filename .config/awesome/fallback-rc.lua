pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")


local function fallback_log(msg)
    local log_path = os.getenv("HOME") .. "/.logs/awesome/rc/fallback-rc.log"
    local f = io.open(log_path, "a")
    if f then
        f:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. tostring(msg) .. "\n")
        f:close()
    end
end


fallback_log("fallback-rc.lua: --- inicio ---")

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

fallback_log("fallback-rc.lua: tema carregado")

terminal = "alacritty"
modkey = "Mod4"

fallback_log("fallback-rc.lua: variáveis definidas")

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.max,
}

fallback_log("fallback-rc.lua: layouts definidas")

awful.screen.connect_for_each_screen(function(s)
    awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

fallback_log("fallback-rc.lua: tags criadas para a tela " .. s.index)

    s.mypromptbox = awful.widget.prompt()
    s.mylayoutbox = awful.widget.layoutbox(s)

    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all
    }

    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags
    }

fallback_log("fallback-rc.lua: widgets criados para a tela " .. s.index)

    s.mywibox = awful.wibar({ position = "top", screen = s })
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { layout = wibox.layout.fixed.horizontal, s.mytaglist, s.mypromptbox },
        s.mytasklist,
        { layout = wibox.layout.fixed.horizontal, s.mylayoutbox }
    }
end)

fallback_log("fallback-rc.lua: wibar criada")

local globalkeys = gears.table.join(
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end),
    awful.key({ modkey }, "w", function() awful.spawn("firefox") end),
    awful.key({ modkey }, "e", function() awful.spawn("dolphin") end),
    awful.key({ modkey, "Shift" }, "r", awesome.restart),
    awful.key({ modkey, "Shift" }, "q", awesome.quit)
)

root.keys(globalkeys)

fallback_log("fallback-rc.lua: teclas globais definidas")

fallback_log("fallback-rc.lua: --- fim da inicialização ---")