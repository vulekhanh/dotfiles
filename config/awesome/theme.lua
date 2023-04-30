--[[

     Multicolor Awesome WM theme 2.0
     github.com/lcpz

--]]
local gears                    = require("gears")
local lain                     = require("lain")
local awful                    = require("awful")
local wibox                    = require("wibox")
local dpi                      = require("beautiful.xresources").apply_dpi

local os                       = os
local my_table                 = awful.util.table or gears.table -- 4.{0,1} compatibility
local theme                    = {}
theme.confdir                  = os.getenv("HOME") .. "/.config/awesome/"

-- Widgets import
theme.wallpaper                = "/home/vulekhanh/.dotfiles/wallpapers/wallpaper.jpg"
theme.font                     = "Terminus Heavy 10"
theme.menu_bg_normal           = "#232634"
theme.menu_bg_focus            = "#000000"
theme.bg_normal                = "#303446"
theme.bg_transparent           = "#30344600"
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
theme.widget_temp              = theme.confdir .. "/icons/temp.png"
theme.widget_uptime            = theme.confdir .. "/icons/ac.png"
theme.widget_mem               = theme.confdir .. "/icons/mem.png"
theme.widget_note              = theme.confdir .. "/icons/note.png"
theme.widget_note_on           = theme.confdir .. "/icons/note_on.png"
theme.widget_netdown           = theme.confdir .. "/icons/net_down.png"
theme.widget_netup             = theme.confdir .. "/icons/net_up.png"
theme.widget_batt              = theme.confdir .. "/icons/bat.png"
theme.widget_symbol            = theme.confdir .. "/icons/octocat.png"
theme.widget_vol               = theme.confdir .. "/icons/spkr.png"
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
local markup                   = lain.util.markup

-- Calendar
os.setlocale(os.getenv("LANG")) -- to localize the clock
local symbol = wibox.widget.imagebox(theme.widget_symbol)
local mytextclock = wibox.widget.textclock(markup(theme.fg_normal, " %A %d %B "))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
  attach_to = { mytextclock },
  notification_preset = {
    font = "Terminus Heavy 10",
    fg   = theme.fg_normal,
    bg   = theme.bg_normal
  }
})
-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, theme.maroon, coretemp_now .. "°C "))
  end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_batt)
local bat = lain.widget.bat({
  settings = function()
    local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

    if bat_now.ac_status == 1 then
      perc = perc .. " plug"
    end

    widget:set_markup(markup.fontfg(theme.font, theme.pink, perc .. " "))
  end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
  settings = function()
    if volume_now.status == "off" then
      volume_now.level = volume_now.level .. "M"
    end

    widget:set_markup(markup.fontfg(theme.font, theme.cyan, volume_now.level .. "% "))
  end
})

-- Net
local netdownicon = wibox.widget.imagebox(theme.widget_netdown)
local netdowninfo = wibox.widget.textbox()
local netupicon = wibox.widget.imagebox(theme.widget_netup)
local netupinfo = lain.widget.net({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, theme.red, net_now.sent .. " "))
    netdowninfo:set_markup(markup.fontfg(theme.font, theme.green, net_now.received .. " "))
  end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, theme.yellow, mem_now.used .. "M "))
  end
})

function theme.at_screen_connect(s)
  -- Quake application
  s.quake = lain.util.quake({ app = awful.util.terminal })

  -- If wallpaper is a function, call it with the screen
  local wallpaper = theme.wallpaper
  if type(wallpaper) == "function" then
    wallpaper = wallpaper(s)
  end
  gears.wallpaper.maximized(wallpaper, s, true)

  -- Tags
  awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
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

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

  -- Create the wibox
  -- The left one is for taglist, the other is resources widgets
  s.mywibox = awful.wibox({
    position = "top",
    screen = s,
    height = dpi(23),
    width = dpi(1908),
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
      --s.mylayoutbox,
      s.mytaglist,
      s.mypromptbox,
    },
    --s.mytasklist, -- Middle widget
    nil,
    {
      -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      -- Network received
      --wibox.container.margin({
      --  { netdownicon, netdowninfo, layout = wibox.layout.align.horizontal },
      --  bottom = 2,
      --  color = '#a9d598',
      --  widget = wibox.container.margin,
      --}, 4, 4),
      ---- Network upload
      --wibox.container.margin({
      --  { netupicon, netupinfo.widget, layout = wibox.layout.align.horizontal },
      --  bottom = 2,
      --  color = '#e98599',
      --  widget = wibox.container.margin,
      --}, 4, 4),
      -- Volume control
      wibox.container.margin({
        { volicon, theme.volume.widget, layout = wibox.layout.align.horizontal },
        bottom = 2,
        color = '#7ebfe3',
        widget = wibox.container.margin,
      }, 4, 4),
      -- MEM info
      --wibox.container.margin({
      --  { memicon, memory.widget, layout = wibox.layout.align.horizontal },
      --  bottom = 2,
      --  color = '#eacea2',
      --  widget = wibox.container.margin,
      --}, 4, 4),
      -- Battery
      wibox.container.margin({
        { baticon, bat.widget, layout = wibox.layout.align.horizontal },
        bottom = 2,
        color = '#f5c2e7',
        widget = wibox.container.margin,
      }, 4, 4),
      -- Temperature info
      --wibox.container.margin({
      --  { tempicon, temp.widget, layout = wibox.layout.align.horizontal },
      --  bottom = 2,
      --  color = '#f4a683',
      --  widget = wibox.container.margin,
      --}, 4, 4),
      -- Calendar
      wibox.container.margin({
        { symbol, mytextclock, layout = wibox.layout.align.horizontal },
        bottom = 2,
        color = theme.fg_normal,
        widget = wibox.container.margin,
      }, 4, 4),

    },
  }
end

return theme
