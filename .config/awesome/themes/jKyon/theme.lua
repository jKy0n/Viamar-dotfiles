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

theme.font               =  "MesloLGS NF Bold 8.5"

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


-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ed8796"

-- Generate taglist squares:
-- local taglist_square_size = dpi(20)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--     taglist_square_size, theme.fg_normal
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--     taglist_square_size, theme.fg_normal
-- )

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_submenu_icon = themes_path.."jKyon/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#ed8796"

-- You can use your own layout icons like this:
theme.layout_tile         =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/tilew.png"
theme.layout_tileleft     =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/tileleftw.png"
theme.layout_tilebottom   =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/tilebottomw.png"
theme.layout_tiletop      =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/tiletopw.png"
theme.layout_max          =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/maxw.png"
theme.layout_floating     =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/floatingw.png"
theme.layout_fullscreen   =   "/home/jkyon/.config/awesome/themes/jKyon/layouts/fullscreenw.png"

-- Generate Awesome icon:
-- theme.awesome_icon = theme_assets.awesome_icon(
--     theme.menu_height, theme.bg_focus, theme.fg_focus
-- )

theme.taglist_shape      =  gears.shape.rounded_rect
theme.tasklist_shape     =  gears.shape.rounded_rect
theme.notification_shape =  gears.shape.rounded_rect

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
-- theme.icon_theme = nil

return theme
