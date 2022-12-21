-- Multicolor theme (modified)
-- https://github.com/lcpz/awesome-copycats

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local theme                     = {}
theme.confdir                   = os.getenv("HOME") .. "/.config/awesome/theme"
theme.wallpaper                 = theme.confdir .. "/wallpaper.png"
theme.font                      = "FiraCode Nerd Font 10"
theme.bg_normal                 = "#00000077"
theme.bg_focus                  = "#00000000"
theme.bg_urgent                 = "#00000000"
theme.fg_normal                 = "#dddddd"
theme.fg_focus                  = "#df6cbe"
theme.fg_focus2                 = "#e09ece"
theme.fg_urgent                 = "#f4b800"
theme.fg_minimize               = "#ffffff"
theme.border_width              = dpi(0)
theme.border_normal             = "#00000000"
theme.border_focus              = "#555555"
theme.taglist_squares_unsel     = theme.confdir .. "/icons/square_b.png"
theme.tasklist_plain_task_name  = true
theme.tasklist_disable_icon     = true
theme.useless_gap               = 3

local markup = lain.util.markup

local spacerS = wibox.container.margin(nil, 6, 0, 0, 0)
local spacerL = wibox.container.margin(nil, 16, 0, 0, 0)

local date = wibox.widget.textclock(markup(theme.fg_focus2, "%A %d %B"))
date.font = theme.font
local time = wibox.widget.textclock(markup(theme.fg_focus2, "%H:%M"))
time.font = theme.font
local clock = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    date,
    spacerS,
    time
}

function tb_set_markup(tb, text, color)
    tb:set_markup(markup.fontfg(theme.font, color, text))
    return tb
end

function textbox(text, color)
    if not color then
        color = theme.fg_normal
    end

    local tb = wibox.widget.textbox()
    tb_set_markup(tb, text, color)

    return tb
end

local netdowninfo = wibox.widget.textbox()
local netupinfo = lain.widget.net({
    settings = function()
        tb_set_markup(widget, net_now.sent .. "u", theme.fg_focus)
        tb_set_markup(netdowninfo, net_now.received .. "d", theme.fg_focus)
    end
})
local net = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    textbox('net'),
    spacerS,
    netupinfo.widget,
    spacerS,
    netdowninfo
}

local mem = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    textbox('mem'),
    spacerS,
    lain.widget.mem({
        settings = function()
            tb_set_markup(widget, mem_now.used .. "m", theme.fg_focus)
        end
    })
}

local cpu = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    textbox('cpu'),
    spacerS,
    lain.widget.cpu({
        settings = function()
            tb_set_markup(widget, cpu_now.usage .. "%", theme.fg_focus)
        end
    }),
    spacerS,
    lain.widget.temp({
        settings = function()
            tb_set_markup(widget, coretemp_now .. "c", theme.fg_focus)
        end
    })
}

theme.at_screen_connect = function(s)
    gears.wallpaper.maximized(theme.wallpaper, s, true)

    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])
    s.mypromptbox = awful.widget.prompt()
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    s.mywibox = awful.wibar {
        position = "top",
        screen = s,
        height = dpi(28),
        bg = theme.bg_normal,
        fg = theme.fg_normal
    }

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            spacerL,
            s.mytaglist,
            s.mypromptbox
        },
        nil,
        {
            layout = wibox.layout.fixed.horizontal,
            net,
            spacerL,
            mem,
            spacerL,
            cpu,
            spacerL,
            clock,
            spacerL
        }
    }
end

return theme
