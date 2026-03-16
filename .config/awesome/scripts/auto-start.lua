--[[
        Title:      auto-start.lua
        Brief:      auto start script for awesomeWM
        Path:       /home/jkyon/.config/awesome/scripts/auto-start.lua
        Author:     John Kennedy a.k.a. jKyon
        Created:    2026-03-16
        Updated:    2026-03-16
        Notes:      Script to quick start
--]]


local awful = require("awful")

local auto_start = {}

local start_apps_script = "/home/jkyon/.config/awesome/scripts/start-apps-viamar-pc.sh"
local ssh_terminal = "alacritty -o font.size=3.5"

function auto_start.run()
        local primary_screen = screen[1]
        local secondary_screen = screen[2]

        if not primary_screen then
                return
        end

        local monitor_tag = secondary_screen and secondary_screen.tags[5] or nil
        local term_tag = primary_screen.tags[5]
        local ssh_tag = primary_screen.tags[6]

        if term_tag then
                term_tag.master_width_factor = 0.55
                term_tag.master_count = 1
        end

        if monitor_tag then
                awful.spawn(ssh_terminal .. " -e btop", { tag = monitor_tag })
                awful.spawn(ssh_terminal .. " -e htop", { tag = monitor_tag })
        end

        if term_tag then
                awful.spawn("alacritty -e sh /home/jkyon/.config/awesome/scripts/tmux-main.sh", { tag = term_tag })
                awful.spawn("alacritty -e sh /home/jkyon/.config/awesome/scripts/tmux-fastfetch.sh", { tag = term_tag })
        end

        if ssh_tag then
                awful.spawn("alacritty -e ssh theseusmachine", { tag = ssh_tag })
                awful.spawn("alacritty -e ssh crisnote", { tag = ssh_tag })
        end

        awful.spawn(start_apps_script)
end

return auto_start