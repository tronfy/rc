local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local lain = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup")
local table = awful.util.table

require("util.error_handling")

local env = require("env")
local mod = env.MOD

local keybindings = require("keybindings")

local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({
    "picom", -- compositor
    "unclutter -root" -- autohide mouse cursor
})

awful.util.terminal = env.TERM
awful.util.tagnames = {"1", "2", "3", "4", "5"}
awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.floating
}

awful.util.taglist_buttons = table.join(
    awful.button({}, 1, function(t)
        t:view_only()
    end),

    awful.button({mod}, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end)
)

beautiful.init(string.format("%s/.config/awesome/theme/theme.lua", env.HOME))

-- create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
    beautiful.at_screen_connect(s)
end)

awful.rules.rules = {{
    rule = {},
    properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        callback = awful.client.setslave,
        focus = awful.client.focus.filter,
        raise = true,
        keys = keybindings.client.keys,
        buttons = keybindings.client.buttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        size_hints_honor = false,
        maximized = false
    }
}, {
    rule = { name = "Picture-in-Picture" },
    properties = {
        floating = true,
        ontop = true,
        sticky = true,
        above = true,
        below = false,
        maximized = false,
        maximized_vertical = false,
        maximized_horizontal = false,
        titlebars_enabled = false
    }
}}

-- focus follows mouse
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {
        raise = false
    })
end)

-- change border color on focus
client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)
