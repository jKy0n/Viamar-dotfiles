--[[
        jKyon (John Kennedy Loria Segundo)
        theme.lua – awesomeWM
        2025-07-11

        Purpose:
          Custom theme for the jKyon configuration,
          enhancing aesthetics and usability.
          Colors based on Catppuccin Frappé Blue.

          Customização de tema para a configuração jKyon,
          melhorando estética e usabilidade.
          Cores baseado em Catppuccin Frappé Blue.
--]]


------------------------------------------------------------
---------------------  Load libraries  ---------------------

local gears = require("gears")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi


------------------------------------------------------------
--------------------  Define Variables  --------------------

--- define a color palette based on Catppuccin Frappé Blue ---
local color_palette = {

    background  = "#303446",
    foreground  = "#c6d0f5", -- White - Text color
    blue        = "#8caaee",
    red         = "#e78284",
    pink        = "#f4b8e4",
    yellow      = "#e5c890",
    green       = "#a6d189",
    lavender    = "#babbf1",
    teal        = "#81c8be",
    gray        = "#a5adce",
    Crust       = "#232634",
}

--- define the font to be used in the theme ---
local font = "MesloLGS NF Mono Bold 8.5"

--- Define the wallpaper path ---
local wallpaper = "/home/jkyon/Pictures/Wallpapers/blueNebula.png"


------------------------------------------------------------
---------------------  Theme definition  -------------------

local theme = {}

theme.font               =  font

-- Colors reference: https://catppuccin.com/palette/ - Catppuccin Frappé Blue color palette
--- Foreground colors ---
theme.fg_normal          =  color_palette.foreground
theme.fg_focus           =  color_palette.blue
theme.fg_urgent          =  theme.fg_normal
theme.fg_minimize        =  color_palette.gray

--- Background colors ---
theme.bg_normal          =  color_palette.background
theme.bg_focus           =  theme.bg_normal
theme.bg_urgent          =  color_palette.red
theme.bg_minimize        =  color_palette.Crust

--- systray ---
theme.fg_systray         =  theme.fg_normal
theme.bg_systray         =  theme.bg_normal

--- Borders ---
theme.border_normal      =  theme.bg_normal
theme.border_focus       =  theme.fg_focus
theme.border_active      =  theme.fg_focus
theme.border_marked      =  theme.bg_urgent

-- Taglist colors ---
theme.taglist_fg_empty   =  theme.fg_minimize

theme.tasklist_bg_focus  =  theme.bg_focus


--- Shapes ---
theme.notification_shape =  gears.shape.rounded_rect
theme.taglist_shape      =  gears.shape.rounded_rect
theme.tasklist_shape     =  gears.shape.rounded_rect


--- Borders --
theme.border_width       =  dpi(2)

--- Gaps ---
theme.useless_gap        =  dpi(2)


-- Wallpaper --
theme.wallpaper = wallpaper


--- Layout icons ---
theme.layout_tile         =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/tilew.png"
theme.layout_tileleft     =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/tileleftw.png"
theme.layout_tilebottom   =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/tilebottomw.png"
theme.layout_tiletop      =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/tiletopw.png"
theme.layout_max          =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/maxw.png"
theme.layout_floating     =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/floatingw.png"
theme.layout_fullscreen   =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/fullscreenw.png"


return theme