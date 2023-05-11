-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local dpi   = require("beautiful.xresources").apply_dpi
require("awful.autofocus")
-- Widget and layout library
local wibox             = require("wibox")
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local volume_widget     = require('awesome-wm-widgets.volume-widget.volume')
local net_widgets       = require("net_widgets")
-- Theme handling library
local beautiful         = require("beautiful")
-- Notification library
local naughty           = require("naughty")
-- Declarative object management
local ruled             = require("ruled")
local hotkeys_popup     = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title   = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message
  }
end)

-- Handle runtime errors after startup
do
  local in_error = false

  awesome.connect_signal("debug::error", function(err)
    if in_error then return end

    in_error = true

    naughty.notify {
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err)
    }

    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/vulekhanh/.dotfiles/config/awesome/theme.lua")
-- Catppuccin color palette
local catppuccin    = {
  pink     = "#f4b8e4",
  mauve    = "#ca9ee6",
  red      = "#e78284",
  maroon   = "#ea999c",
  peach    = "#ef9f76",
  yellow   = "#e5c890",
  green    = "#a6d189",
  teal     = "#81c8be",
  cyan     = "#7ebfe3",
  sky      = "#99d1db",
  sapphire = "#85c1dc",
  blue     = "#8aadf4",
  lavender = "#babbf1",
  white    = "#c6d0f5",
}

-- Gruvbox color palette
local gruvbox       = {
  black  = "#282828",
  red    = "#cc241d",
  green  = "#98971a",
  yellow = "#d79921",
  blue   = "#458588",
  purple = "#b16286",
  aqua   = "#689d6a",
  gray   = "#a89984",
  orange = "#fe8019",
  white  = "#ebdbb2",
}
-- This is used later as the default terminal and editor to run.
local modkey        = "Mod4"
local altkey        = "Mod1"
local browser       = "firefox"
local multi_monitor = "arandr"
local terminal      = "kitty"
editor              = os.getenv("EDITOR") or "nvim"
editor_cmd          = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu       = {
  { "hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual",      terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart",     awesome.restart },
  { "quit",        function() awesome.quit() end },
}

mymainmenu          = awful.menu({
  items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "open terminal", terminal }
  }
})

mylauncher          = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mymainmenu
})

-- }}}

-- {{{ Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts({
    awful.layout.suit.tile,
    awful.layout.suit.spiral,
    awful.layout.suit.fair,
    awful.layout.suit.floating,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
  })
end)
-- }}}

-- {{{ Wallpaper
screen.connect_signal("request::wallpaper", function(s)
  awful.wallpaper {
    screen = s,
    widget = {
      {
        image     = beautiful.wallpaper,
        upscale   = true,
        downscale = true,
        widget    = wibox.widget.imagebox,
      },
      valign = "center",
      halign = "center",
      tiled  = false,
      widget = wibox.container.tile,
    }
  }
end)
-- }}}
-- FontAwesome
--------------------------
-- WIDGET CONFIGURATION
--------------------------
local icon_size = 12
local icon_font = "Font Awesome 5 Free-Solid-900 "
local function make_fa_icon(code, icon_color)
  return wibox.widget {
    font   = icon_font .. icon_size,
    markup = '<span color="' .. icon_color .. '">' .. code .. '</span> ',
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
  }
end
local baticon      = make_fa_icon(' ', gruvbox.blue)
local volicon      = make_fa_icon('', gruvbox.green)
local wifiicon     = make_fa_icon('', gruvbox.red)
-- {{{ Wibar
--
-- Keyboard map indicator and switcher
mykeyboardlayout   = awful.widget.keyboardlayout()
-- Wireless widget
local net_wireless = net_widgets.wireless({
  interface = "wlp5s0",
  indent = 0,
})
-- Create a textclock widget
local mytextclock  = wibox.widget.textclock(
  '<span color="#b16286" font="Terminus Heavy 10"> %d %B %H %M </span>',
  5)

screen.connect_signal("request::desktop_decoration", function(s)
  -- Each screen has its own tag table.
  awful.tag({ " 󰍹 ", " 󰈹 ", "  ", "  ", "  ", "  " }, s, awful.layout.layouts[1])

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox {
    screen  = s,
    buttons = {
      awful.button({}, 1, function() awful.layout.inc(1) end),
      awful.button({}, 3, function() awful.layout.inc(-1) end),
      awful.button({}, 4, function() awful.layout.inc(-1) end),
      awful.button({}, 5, function() awful.layout.inc(1) end),
    }
  }

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = {
      awful.button({}, 1, function(t) t:view_only() end),
      awful.button({ modkey }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
      awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
      awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
    }
  }

  -- Create the wibox
  s.mywibox = awful.wibar {
    position = "top",
    screen   = s,
    height   = dpi(21),
    bg       = "#00000000",
    widget   = {
      layout = wibox.layout.align.horizontal,
      expand = "none",
      {
        -- Left widgets
        layout = wibox.layout.fixed.horizontal,

        wibox.container.margin({
          { s.mylayoutbox, layout = wibox.layout.align.horizontal },
          widget = wibox.container.margin,
          bottom = 2,
          color = gruvbox.white,
        }, dpi(10), 4),
      },
      -- Middle widget
      s.mytaglist,
      {
        -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        wibox.widget.systray(),

        --Wifi widget
        wibox.container.margin({
          {
            wifiicon,
            net_wireless,
            layout = wibox.layout.align.horizontal
          },
          widget = wibox.container.margin,
          bottom = 2,
          color = gruvbox.red,
        }, 4, 4),
        --Volume widget
        wibox.container.margin({
          {
            volicon,
            volume_widget({
              widget_type = 'vertical_bar',
              with_icon = false,
              thickness = 3,
              main_color = gruvbox.green,
              mute_color = gruvbox.red,
              size = 19,
            }),
            layout = wibox.layout.align.horizontal
          },
          widget = wibox.container.margin,
          bottom = 2,
          color = gruvbox.green,
        }, 4, 4),

        --battery_widget
        wibox.container.margin({
          {
            baticon,
            batteryarc_widget({
              arc_thickness = 3,
              low_level_color = gruvbox.red,
              medium_level_color = gruvbox.yellow,
              charging_color = gruvbox.green,
              main_color = gruvbox.blue,
              warning_msg_title = 'Houston, we have a problem!',
              warning_msg_text = 'Battery is f*cking dying!',
              warning_msg_position = 'top_right',
              enable_battery_warning = true,
              size = 19,
            }),
            layout = wibox.layout.align.horizontal
          },
          widget = wibox.container.margin,
          bottom = 2,
          color = gruvbox.blue,
        }, 4, 4),

        -- Date widget
        wibox.container.margin({
          { mytextclock, layout = wibox.layout.align.horizontal },
          widget = wibox.container.margin,
          bottom = 2,
          color = gruvbox.purple,
        }, 4, dpi(10)),
      },
    }
  }
end)

-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
  awful.button({}, 3, function() mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext),
})
-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
  -- Destroy all notifications
  awful.key({ "Control", }, "space", function() naughty.destroy_all_notifications() end,
    { description = "destroy all notifications", group = "hotkeys" }),
  awful.key({ modkey, }, "s", hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }),
  awful.key({ modkey, "Control" }, "r", awesome.restart,
    { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "q", awesome.quit,
    { description = "quit awesome", group = "awesome" }),
  -- Show/hide wibox
  awful.key({ modkey }, "b", function()
      for s in screen do
        s.mywibox.visible = not s.mywibox.visible
      end
    end,
    { description = "toggle wibox", group = "awesome" }),

  -- User programs
  awful.key({ modkey }, "q", function() awful.spawn(browser) end,
    { description = "run browser", group = "launcher" }),
  awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
    { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey }, "p", function()
      awful.spawn(multi_monitor)
    end,
    { description = "toggle multi monitor", group = "launcher" }),

  -- ALSA volume control
  awful.key({ altkey }, "Up",
    function()
      os.execute(string.format("amixer -q set %s 1%%+", "Master"))
    end,
    { description = "volume up", group = "hotkeys" }),
  awful.key({ altkey }, "Down",
    function()
      os.execute(string.format("amixer -q set %s 1%%-", "Master"))
    end,
    { description = "volume down", group = "hotkeys" }),
  awful.key({ altkey }, "m",
    function()
      os.execute(string.format("amixer -q set %s toggle", "Master"))
    end,
    { description = "toggle mute", group = "hotkeys" }),
  awful.key({ altkey, "Control" }, "m",
    function()
      os.execute(string.format("amixer -q set %s 100%%", "Master"))
    end,
    { description = "volume 100%", group = "hotkeys" }),
  awful.key({ altkey, "Control" }, "0",
    function()
      os.execute(string.format("amixer -q set %s 0%%", "Master"))
    end,
    { description = "volume 0%", group = "hotkeys" }),

  -- Screen brightness
  awful.key({ modkey }, ";", function() os.execute("brightnessctl -q set 10%+") end,
    { description = "+10%", group = "hotkeys" }),
  awful.key({ modkey, "Shift" }, ";", function() os.execute("brightnessctl -q set 10%-") end,
    { description = "-10%", group = "hotkeys" }),

  --rofi
  awful.key({ modkey }, "r", function()
      os.execute(string.format("$HOME/.config/rofi/bin/launcher"))
    end,
    { description = "app launcher", group = "launcher" }),
  awful.key({ modkey }, "x", function() os.execute(string.format("$HOME/.config/rofi/bin/runner")) end,
    { description = "execute prompt", group = "launcher" }),
  awful.key({ modkey, "Shift" }, "s", function() os.execute(string.format("$HOME/.config/rofi/bin/screenshot")) end,
    { description = "screenshot", group = "launcher" })

})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ modkey, }, "Escape", awful.tag.history.restore,
    { description = "go back", group = "tag" }),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ modkey }, "j",
    function()
      awful.client.focus.global_bydirection("down")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus down", group = "client" }),
  awful.key({ modkey }, "k",
    function()
      awful.client.focus.global_bydirection("up")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus up", group = "client" }),
  awful.key({ modkey }, "h",
    function()
      awful.client.focus.global_bydirection("left")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus left", group = "client" }),
  awful.key({ modkey }, "l",
    function()
      awful.client.focus.global_bydirection("right")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus right", group = "client" }),
  awful.key({ modkey, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "go back", group = "client" }),
  awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:activate { raise = true, context = "key.unminimize" }
      end
    end,
    { description = "restore minimized", group = "client" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }),
  awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }),
  awful.key({ modkey, }, "Right", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey, }, "Left", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
    { description = "increase the number of master clients", group = "layout" }),
  awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }),
  awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }),
  awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
    { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
    { description = "select previous", group = "layout" }),
})


awful.keyboard.append_global_keybindings({
  awful.key {
    modifiers   = { modkey },
    keygroup    = "numrow",
    description = "only view tag",
    group       = "tag",
    on_press    = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  },
  awful.key {
    modifiers   = { modkey, "Control" },
    keygroup    = "numrow",
    description = "toggle tag",
    group       = "tag",
    on_press    = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  },
  awful.key {
    modifiers   = { modkey, "Shift" },
    keygroup    = "numrow",
    description = "move focused client to tag",
    group       = "tag",
    on_press    = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  },
  awful.key {
    modifiers   = { modkey, "Control", "Shift" },
    keygroup    = "numrow",
    description = "toggle focused client on tag",
    group       = "tag",
    on_press    = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  },
  awful.key {
    modifiers   = { modkey },
    keygroup    = "numpad",
    description = "select layout directly",
    group       = "layout",
    on_press    = function(index)
      local t = awful.screen.focused().selected_tag
      if t then
        t.layout = t.layouts[index] or t.layout
      end
    end,
  }
})

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate { context = "mouse_click" }
    end),
    awful.button({ modkey }, 1, function(c)
      c:activate { context = "mouse_click", action = "mouse_move" }
    end),
    awful.button({ modkey }, 3, function(c)
      c:activate { context = "mouse_click", action = "mouse_resize" }
    end),
  })
end)

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({ modkey, }, "f",
      function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end,
      { description = "close", group = "client" }),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
      { description = "toggle floating", group = "client" }),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
      { description = "move to master", group = "client" }),
    awful.key({ modkey, }, "o", function(c) c:move_to_screen() end,
      { description = "move to screen", group = "client" }),
    awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end,
      { description = "toggle keep on top", group = "client" }),
    awful.key({ modkey, }, "n",
      function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
      end,
      { description = "minimize", group = "client" }),
    awful.key({ modkey, }, "m",
      function(c)
        c.maximized = not c.maximized
        c:raise()
      end,
      { description = "(un)maximize", group = "client" }),
    awful.key({ modkey, "Control" }, "m",
      function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
      end,
      { description = "(un)maximize vertically", group = "client" }),
    awful.key({ modkey, "Shift" }, "m",
      function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
      end,
      { description = "(un)maximize horizontally", group = "client" }),
  })
end)

-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
  -- All clients will match this rule.
  ruled.client.append_rule {
    id         = "global",
    rule       = {},
    properties = {
      focus     = awful.client.focus.filter,
      raise     = true,
      screen    = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  }

  -- Floating clients.
  ruled.client.append_rule {
    id         = "floating",
    rule_any   = {
      instance = { "copyq", "pinentry" },
      class    = {
        "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
        "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name     = {
        "Event Tester", -- xev.
      },
      role     = {
        "AlarmWindow",   -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = { floating = true }
  }

  -- Set Firefox to always map on the tag named "2" on screen 1.
  --ruled.client.append_rule {
  --  rule       = { class = "firefox" },
  --  properties = { screen = 1, tag = "2" }
  --}
end)
-- }}}

-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
  -- All notifications will match this rule.
  ruled.notification.append_rule {
    rule       = {},
    properties = {
      screen           = awful.screen.preferred,
      implicit_timeout = 5,
    }
  }
end)

naughty.connect_signal("request::display", function(n)
  naughty.layout.box { notification = n }
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:activate { context = "mouse_enter", raise = false }
end)

-- Autostart Applications
collectgarbage()
collectgarbage('setpause', 110)
collectgarbage('setstepmul', 1000)
awful.spawn.with_shell("picom")
