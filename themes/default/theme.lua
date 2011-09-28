---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.confdir = awful.util.getdir("config")

theme.font          = "Tahoma 8"
theme.taglist_font  = "Tahoma 8"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = theme.confdir .. "/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = theme.confdir .. "/themes/default/taglist/squarew.png"

theme.tasklist_floating_icon = theme.confdir .. "/themes/default/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme.confdir .. "/themes/default/submenu.png"
theme.menu_height = "20"
theme.menu_width  = "150"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = theme.confdir .. "/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme.confdir .. "/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme.confdir .. "/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme.confdir .. "/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.confdir .. "/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme.confdir .. "/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme.confdir .. "/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme.confdir .. "/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.confdir .. "/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme.confdir .. "/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme.confdir .. "/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme.confdir .. "/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.confdir .. "/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme.confdir .. "/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.confdir .. "/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme.confdir .. "/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg " .. awful.util.getdir("config") .. "/wallpapers/bricks.png" }

-- You can use your own layout icons like this:
theme.layout_fairh = theme.confdir .. "/themes/default/layouts/fairhw.png"
theme.layout_fairv = theme.confdir .. "/themes/default/layouts/fairvw.png"
theme.layout_floating  = theme.confdir .. "/themes/default/layouts/floatingw.png"
theme.layout_magnifier = theme.confdir .. "/themes/default/layouts/magnifierw.png"
theme.layout_max = theme.confdir .. "/themes/default/layouts/maxw.png"
theme.layout_fullscreen = theme.confdir .. "/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom = theme.confdir .. "/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft   = theme.confdir .. "/themes/default/layouts/tileleftw.png"
theme.layout_tile = theme.confdir .. "/themes/default/layouts/tilew.png"
theme.layout_tiletop = theme.confdir .. "/themes/default/layouts/tiletopw.png"
theme.layout_spiral  = theme.confdir .. "/themes/default/layouts/spiralw.png"
theme.layout_dwindle = theme.confdir .. "/themes/default/layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
