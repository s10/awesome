-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Scratch
require("scratch")

-- Notification settings
naughty.config.default_preset.timeout          = 5
naughty.config.default_preset.screen           = 1
naughty.config.default_preset.position         = "top_right"
naughty.config.default_preset.margin           = 5
naughty.config.default_preset.padding          = 5
naughty.config.presets.low.padding             = 4
-- naughty.config.default_preset.height           = 60
-- naughty.config.presets.critical.height         = 60
naughty.config.presets.low.height              = 70
naughty_width                                  = 300 -- in pixels
naughty.config.default_preset.width            = naughty_width
naughty.config.presets.low.width               = naughty_width
naughty.config.presets.critical.width          = naughty_width
naughty.config.default_preset.gap              = 1
naughty.config.default_preset.ontop            = true
naughty_font                                   = "DejaVu Sans Mono 9"
naughty.config.default_preset.font             = naughty_font
naughty.config.presets.low.font                = naughty_font
naughty.config.presets.critical.font           = naughty_font
naughty.config.presets.low.icon_size           = 60
naughty.config.presets.critical.icon_size      = 52
naughty.config.default_preset.icon_size        = 52
naughty.config.default_preset.fg               = '#ffffff'
naughty.config.default_preset.bg               = '#535d6c'
naughty.config.presets.normal.border_color     = '#535d6c'
naughty.config.default_preset.border_width     = 1

-- Load menu entries
-- require("debian.menu")

require('freedesktop.utils')
--freedesktop.utils.terminal = terminal  -- default: "xterm"
freedesktop.utils.icon_theme = 'gnome' -- look inside /usr/share/icons/, default: nil (don't use icon theme)
require('freedesktop.menu')

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.max,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal
--  awful.layout.suit.max.fullscreen
--  awful.layout.suit.spiral
--  awful.layout.suit.spiral.dwindle
--  awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
    names  = { "web", "dev", "gajim", "im","media", "p2p", "text", "vm" },
    layout = {
        awful.layout.suit.max,
        awful.layout.suit.floating,
        awful.layout.suit.max,
        awful.layout.suit.tile.left,
        awful.layout.suit.floating,
        awful.layout.suit.max,
        awful.layout.suit.max,
        awful.layout.suit.floating
    }
}
for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
awful.tag.setmwfact(0.25, tags[1][2])
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
freedesktop_items = freedesktop.menu.new()

myawesomemenu = {
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor .. " " .. awful.util.getdir("config") .. "/rc.lua" },
    { "restart", awesome.restart },
    { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "applications", freedesktop_items },
                                    { "open terminal", terminal }
                                  }, width = 150
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })


-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/Картинки/screenshots/ 2>/dev/null'") end),

    -- Applications
    awful.key({ modkey            }, "p", function () awful.util.spawn("xsetroot -cursor_name left_ptr") end),

    -- Prompt
    awful.key({ modkey            }, "r",     function () mypromptbox[mouse.screen]:run() end),

    -- Dropdown terminal
    awful.key({                   }, "F1",    function () scratch.drop("xterm","bottom","center",1,0.35) end),

    -- Launch Nautilus
    awful.key({ modkey}, "x", function () awful.util.spawn("nautilus .") end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey            }, 'Next',   function() awful.client.moveresize( 20,  20, -40, -40) end),
    awful.key({ modkey            }, 'Prior',  function() awful.client.moveresize(-20, -20,  40,  40) end),
    awful.key({ modkey            }, 'End',    function() awful.client.moveresize(  0,  20,   0,   0) end), -- down
    awful.key({ modkey            }, 'Home',   function() awful.client.moveresize(  0, -20,   0,   0) end), -- top
    awful.key({ modkey            }, 'Insert', function() awful.client.moveresize(-20,   0,   0,   0) end), -- left
    awful.key({ modkey            }, 'Delete', function() awful.client.moveresize( 20,   0,   0,   0) end), -- right

    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey, "Control" }, "i",
        function (c)
           naughty.notify({ text = 
               "Class: " .. c.class ..
               "\nInstance: " .. c.instance .. 
               "\nName: " .. c.name .. "\n",
               width = 400 })
        end),
    awful.key({ modkey,           }, 't',
      function(c)
        local t = awful.client.property.get(c, 'titlebar') or false
        awful.client.property.set(c, 'titlebar', not t)
        if t then
          awful.titlebar.remove(c)
        else
          awful.titlebar.add(c, { modkey = modkey })
        end
      end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },

    -- Rules for some applications
    { rule = { class = "MPlayer"        }, properties = { tag = tags[1][4], floating = true } },
    { rule = { class = "Smplayer"       }, properties = { tag = tags[1][4] } },
    { rule = { class = "pinentry"       }, properties = { floating = true } },
    { rule = { class = "gimp"           }, properties = { floating = true } },
    { rule = { class = "Guake"          }, properties = { floating = true } },
    { rule = { class = "Dialog"         }, properties = { floating = true } },
    { rule = { class = "Download"       }, properties = { floating = true } },
    { rule = { class = "Google-chrome"  }, properties = { tag = tags[1][1] } },
    { rule = { class = "Pidgin"         }, properties = { tag = tags[1][3] } },
    { rule = { class = "Pidgin", name = "Передача файлов" or "Открыть файл..." or "Выбрать ресурс" }, properties = { tag = tags[1][3], floating = true } },
    { rule = { class = "Skype"          }, properties = { tag = tags[1][4], floating = true	 } },
    { rule = { class = "Gajim.py"       }, properties = { tag = tags[1][3], floating = false } },
    { rule = { class = "Wine"           }, properties = { tag = tags[1][2], floating = true } }, -- TeamViewer
    { rule = { class = "VirtualBox"     }, properties = { tag = tags[1][8] } },
    { rule = { class = "banshee-1"      }, properties = { tag = tags[1][4] } },
    { rule = { class = "Eiskaltdcpp-qt" }, properties = { tag = tags[1][5] } },
    { rule = { class = "Deluge-gtk"     }, properties = { tag = tags[1][5] } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
