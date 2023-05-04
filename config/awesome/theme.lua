--[[

     Multicolor Awesome WM theme 2.0
     github.com/lcpz

--]]
local gears                    = require("gears")
local awful                    = require("awful")
local wibox                    = require("wibox")
local dpi                      = require("beautiful.xresources").apply_dpi
local os                       = os
local my_table                 = awful.util.table or gears.table -- 4.{0,1} compatibility
local theme                    = {}
theme.confdir                  = os.getenv("HOME") .. "/.config/awesome/"

-- Widgets import
local batteryarc_widget        = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local volume_widget            = require('awesome-wm-widgets.volume-widget.volume')
--Defining theme
theme.wallpaper                = "/home/vulekhanh/.dotfiles/wallpapers/wallpaper.jpg"
theme.font                     = "Terminus Heavy 10"
theme.menu_bg_normal           = "#232634"
theme.menu_bg_focus            = "#000000"
theme.bg_normal                = "#303446"
theme.bg_focus                 = "#8aadf4"
theme.bg_urgent                = "#000000"
theme.fg_normal                = "#8aadf4"
theme.fg_focus                 = "#24273A"
theme.fg_urgent                = "#af1d18"
theme.fg_minimize              = "#ffffff"
theme.border_width             = dpi(3)
theme.useless_gap              = dpi(4)
theme.border_normal            = "#ffffff"
theme.border_focus             = "#8caaee"
theme.border_marked            = "#3ca4d8"
theme.menu_border_width        = 0
theme.menu_width               = dpi(130)
theme.menu_submenu_icon        = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal           = "#deb2ee"
theme.menu_fg_focus            = "#ff8c00"
theme.menu_bg_normal           = "#24273A"
theme.menu_bg_focus            = "#8aadf4"
theme.taglist_squares_sel      = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel    = theme.confdir .. "/icons/square_b.png"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon    = true
theme.layout_tile              = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps          = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft          = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom        = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop           = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv             = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh             = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral            = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle           = theme.confdir .. "/icons/dwindle.png"
theme.layout_max               = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen        = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier         = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating          = theme.confdir .. "/icons/floating.png"
-- Catppuccin color palette
theme.pink                     = "#f4b8e4"
theme.mauve                    = "#ca9ee6"
theme.red                      = "#e78284"
theme.maroon                   = "#ea999c"
theme.peach                    = "#ef9f76"
theme.yellow                   = "#e5c890"
theme.green                    = "#a6d189"
theme.teal                     = "#81c8be"
theme.cyan                     = "#7ebfe3"
theme.sky                      = "#99d1db"
theme.sapphire                 = "#85c1dc"
theme.blue                     = theme.fg_normal
theme.lavender                 = "#babbf1"
theme.white                    = "#c6d0f5"

--Calendar
local mytextclock              = wibox.widget.textclock(
  '<span color="#8aadf4" font="Terminus Heavy 10"> %d %B %H %M </span>',
  5)
function theme.at_screen_connect(s)
  -- Quake application
  --s.quake = lain.util.quake({ app = awful.util.terminal })

  -- If wallpaper is a function, call it with the screen
  local wallpaper = theme.wallpaper
  if type(wallpaper) == "function" then
    wallpaper = wallpaper(s)
  end
  gears.wallpaper.maximized(wallpaper, s, true)

  -- Tags
  awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(my_table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 2, function() awful.layout.set(awful.layout.layouts[1]) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

  -- Create the wibox
  s.mywibox = awful.wibox({
    position = "top",
    screen = s,
    height = dpi(23),
    width = dpi(1900),
    border_width = 3,
    border_color = theme.blue,
    bg = theme.bg_normal,
    fg = theme.fg_normal
  })
  s.mywibox.x = 6
  s.mywibox.y = 3
  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    {
      -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mylayoutbox,
      --s.mytaglist,
    },
    --s.mytasklist, -- Middle widget
    wibox.container.margin({
      { s.mytaglist, layout = wibox.layout.align.horizontal },
      widget = wibox.container.margin,
    }, dpi(1920 / 2 - 140), 4),
    {
      -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),

      --volume
      wibox.container.margin({
        {
          volume_widget({
            step = 2,
          }),
          layout = wibox.layout.align.horizontal
        },
        widget = wibox.container.margin,
      }, 4, 4),

      --battery_widget
      wibox.container.margin({
        {
          batteryarc_widget({
            arc_thickness = 2,
            low_level_color = theme.red,
            medium_level_color = theme.yellow,
            charging_color = theme.green,
            main_color = theme.blue,
            warning_msg_title = 'Houston, we have a problem!',
            warning_msg_text = 'Battery is f*cking dying!',
            warning_msg_position = 'top_right',
            enable_battery_warning = true,
            size = 20,
          }),
          layout = wibox.layout.align.horizontal
        },
        widget = wibox.container.margin,
      }, 4, 4),

      -- Date widget
      wibox.container.margin({
        { mytextclock, layout = wibox.layout.align.horizontal },
        widget = wibox.container.margin,
      }, 4, 4),
    },
  }
end

return theme
