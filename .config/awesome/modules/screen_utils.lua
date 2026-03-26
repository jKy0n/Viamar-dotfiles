--[[
--       Title:      screen_utils.lua
--       Brief:      
--       Path:       /home/jkyon/.config/awesome/modules/screen_utils.lua
--       Author:     John Kennedy a.k.a. jKyon
--       Created:    2026-03-24
--       Updated:    2026-03-24
--       Notes:      
--]]


local awful = require("awful")

local M = {}

local function screens_sorted_by_x()
    local screens = {}

    for s in screen do
        table.insert(screens, s)
    end

    table.sort(screens, function(a, b)
        return a.geometry.x < b.geometry.x
    end)

    return screens
end

function M.left()
    local screens = screens_sorted_by_x()
    return screens[1]
end

function M.right()
    local screens = screens_sorted_by_x()
    return screens[#screens]
end

function M.primary()
    return M.left()
end

function M.secondary()
    local left = M.left()
    local right = M.right()

    if right and right ~= left then
        return right
    end

    return left
end

return M