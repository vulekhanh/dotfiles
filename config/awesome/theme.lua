---------------------------
-- Default awesome theme --
---------------------------

local theme_assets          = require("beautiful.theme_assets")
local xresources            = require("beautiful.xresources")
local rnotification         = require("ruled.notification")
local dpi                   = xresources.apply_dpi
local os                    = os
local gfs                   = require("gears.filesystem")
local themes_path           = gfs.get_themes_dir()

local theme                 = {}

theme.confdir               = os.getenv("HOME") .. "/.config/awesome/"
theme.font                  = "Terminus Heavy 10"
theme.menu_bg_focus         = "#000000"
theme.bg_normal             = "#303446"
theme.bg_focus              = "#98971a"
theme.bg_urgent             = "#cc241d"
theme.fg_normal             = "#ebdbb2"
theme.fg_focus              = "#1d2021"
theme.fg_urgent             = "#1d2021"
theme.fg_minimize           = "#ffffff"
theme.border_width          = dpi(3)
theme.useless_gap           = dpi(4)
theme.border_normal         = "#00000000"
theme.border_focus          = "#ebdbb2"
theme.border_marked         = "#98971a"
theme.menu_border_width     = 0
theme.menu_width            = dpi(130)
theme.menu_submenu_icon     = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal        = "#deb2ee"
theme.menu_fg_focus         = "#ff8c00"
theme.menu_bg_normal        = "#282828"
-- taglist markers
theme.taglist_squares_sel   = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel = theme.confdir .. "/icons/square_b.png"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"


-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height       = dpi(15)
theme.menu_width        = dpi(150)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

theme.wallpaper         = "/home/vulekhanh/.dotfiles/wallpapers/cube.png"

-- You can use your own layout icons like this:
theme.layout_tile       = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps   = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft   = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop    = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv      = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh      = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral     = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle    = theme.confdir .. "/icons/dwindle.png"
theme.layout_max        = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier  = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating   = theme.confdir .. "/icons/floating.png"


-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
