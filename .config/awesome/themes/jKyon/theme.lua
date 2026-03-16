--[[
        jKyon (John Kennedy Loria Segundo)
        theme.lua – awesomeWM
        2025-07-11

        Purpose:
          Custom theme for the jKyon configuration,
          enhancing aesthetics and usability.
          Colors based on Catppuccin Macchiato Blue.

          Customização de tema para a configuração jKyon,
          melhorando estética e usabilidade.
          Cores baseado em Catppuccin Macchiato Blue.
--]]

------------------------------------------------------------
---------------------  Load libraries  ---------------------
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local gears = require("gears")

------------------------------------------------------------
---------------------  Theme definition  -------------------
local theme = {}

theme.font               =  "MesloLGS NF Mono Bold 8.5"

-- Colors reference: https://catppuccin.com/palette/ - Catppuccin Macchiato Blue color palette
theme.fg_normal          =  "#cad3f5"
theme.fg_focus           =  "#8aadf4"
theme.fg_urgent          =  "#cad3f5"
theme.fg_minimize        =  "#6e738d"

theme.bg_normal          =  "#24273a"
theme.bg_focus           =  "#24273a"
theme.bg_urgent          =  "#ed8796"
theme.bg_minimize        =  "#181926"
theme.bg_systray         =  theme.bg_normal

theme.useless_gap        =  dpi(2)
theme.border_width       =  dpi(2)

theme.border_normal      =  "#24273a"
theme.border_focus       =  "#8aadf4"
theme.border_active      =  "#8aadf4"
theme.border_marked      =  "#ed8796"
theme.tasklist_bg_focus  =  "#24273a"

theme.titlebar_fg_focus  =  theme.fg_focus
theme.titlebar_bg_normal =  theme.bg_normal
theme.titlebar_bg_focus  =  theme.bg_focus

theme.taglist_fg_empty   =  "#6e738d"


-- -- Variables set for theming the menu:
-- -- menu_[bg|fg]_[normal|focus]
-- -- menu_[border_color|border_width]
-- -- theme.menu_submenu_icon = themes_path.."jKyon/submenu.png"
-- theme.menu_height = dpi(15)
-- theme.menu_width  = dpi(100)

-- You can use your own layout icons like this:
theme.layout_tile         =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/tilew.png"
theme.layout_tileleft     =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/tileleftw.png"
theme.layout_tilebottom   =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/tilebottomw.png"
theme.layout_tiletop      =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/tiletopw.png"
theme.layout_max          =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/maxw.png"
theme.layout_floating     =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/floatingw.png"
theme.layout_fullscreen   =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/fullscreenw.png"

theme.taglist_shape      =  gears.shape.rounded_rect
theme.tasklist_shape     =  gears.shape.rounded_rect
theme.notification_shape =  gears.shape.rounded_rect

-- Wallpaper --
theme.wallpaper = "/home/jkyon/Pictures/Wallpapers/blueNebula.png"

return theme
