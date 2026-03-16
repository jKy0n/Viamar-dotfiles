--[[
--       Title:      wallpaper.lua
--       Brief:      Configuração do wallpaper
--       Path:       /home/jkyon/.config/awesome/modules/wallpaper.lua
--       Author:     John Kennedy a.k.a. jKyon
--       Created:    2026-03-16
--       Updated:    2026-03-16
--]]

local gears    = require("gears")
local beautiful = require("beautiful")

local function set_wallpaper(s)
   local wp = beautiful.wallpaper
   if not wp then return end
   local image = type(wp) == "function" and wp(s) or wp
   gears.wallpaper.maximized(image, s, false)
end

screen.connect_signal("request::wallpaper", set_wallpaper)

for s in screen do
   set_wallpaper(s)
end

return {}