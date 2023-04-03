local awful = require("awful")
local lain = require("lain")
local naughty = require("naughty")
local table = awful.util.table
local hotkeys_popup = require("awful.hotkeys_popup")

local env = require("env")
local mod = env.MOD
local alt = env.ALT


globalkeys = table.join(

-- [ awesome ]

awful.key({mod, "Control"}, "r", awesome.restart, {
    description = "reload awesome",
    group = "awesome"
}),

awful.key({mod, "Shift"}, "q", awesome.quit, {
    description = "quit awesome",
    group = "awesome"
}),

awful.key({mod}, "s", hotkeys_popup.show_help, {
    description = "show help",
    group = "awesome"
}),

awful.key({mod}, "b", function()
    for s in screen do
        s.mywibox.visible = not s.mywibox.visible
    end
end, {
    description = "toggle wibox",
    group = "awesome"
}),


-- [ client ]

-- directional client focus
awful.key({alt}, "Down", function()
    awful.client.focus.global_bydirection("down")
    if client.focus then client.focus:raise() end
end, {
    description = "focus down",
    group = "client"
}),

awful.key({alt}, "Up", function()
    awful.client.focus.global_bydirection("up")
    if client.focus then client.focus:raise() end
end, {
    description = "focus up",
    group = "client"
}),

awful.key({alt}, "Left", function()
    awful.client.focus.global_bydirection("left")
    if client.focus then client.focus:raise() end
end, {
    description = "focus left",
    group = "client"
}),

awful.key({alt}, "Right", function()
    awful.client.focus.global_bydirection("right")
    if client.focus then client.focus:raise() end
end, {
    description = "focus right",
    group = "client"
}),

-- layout manipulation

awful.key({alt, "Shift"}, "Left", function()
    awful.client.swap.byidx(1)
end, {
    description = "swap with next client by index",
    group = "client"
}),

awful.key({alt, "Shift"}, "Right", function()
    awful.client.swap.byidx(-1)
end, {
    description = "swap with previous client by index",
    group = "client"
}),

awful.key({alt}, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then client.focus:raise() end
end, {
    description = "cycle with previous/go back",
    group = "client"
}),

awful.key({mod}, "space", function()
    awful.layout.inc(1)
end, {
    description = "switch layouts",
    group = "client"
}),


-- [ hotkeys ]

awful.key({mod}, "Return", function()
    awful.spawn(env.TERM)
end, {
    description = "open a terminal",
    group = "hotkeys"
}),

awful.key({mod}, "u", function()
    awful.client.urgent.jumpto()
end, {
    description = "go to urgent",
    group = "hotkeys"
}),

awful.key({alt}, "space", function()
    awful.spawn("rofi -show drun")
end, {
    description = "run rofi",
    group = "hotkeys"
}),

awful.key({alt, "Control"}, "space", function()
    awful.spawn("rofi -show power-menu -modi power-menu:rofi-power-menu")
end, {
    description = "open rofi power menu",
    group = "hotkeys"
}),

awful.key({mod}, "l", function()
    os.execute("scrot -o /tmp/screenshot.png")
    os.execute("convert /tmp/screenshot.png -blur 0x5 /tmp/screenshotblur.png")
    os.execute("i3lock -i /tmp/screenshotblur.png")
end, {
    description = "lock screen",
    group = "hotkeys"
}),

awful.key({}, "Print", function()
    awful.spawn("flameshot gui")
end, {
    description = "take a screenshot",
    group = "hotkeys"
}),

awful.key({mod}, "c", function()
    os.execute("colorpicker --short --one-shot | xclip -sel clipboard")
end, {
    description = "launch colorpicker",
    group = "hotkeys"
}),

awful.key({mod, "Shift"}, "b", function()
    awful.spawn("bluetoothctl disconnect")
end, {
    description = "disconnect bluetooth",
    group = "hotkeys"
}),



-- [ tag ]

-- browsing
awful.key({mod}, "Left", awful.tag.viewprev, {
    description = "view previous",
    group = "tag"
}),
awful.key({mod}, "Right", awful.tag.viewnext, {
    description = "view next",
    group = "tag"
}),

-- dynamic tagging

awful.key({mod, "Shift"}, "r", function()
    lain.util.rename_tag()
end, {
    description = "rename tag",
    group = "tag"
}),

awful.key({mod, "Shift"}, "n", function()
    lain.util.add_tag()
end, {
    description = "add new tag",
    group = "tag"
}),

awful.key({mod, "Shift"}, "d", function()
    lain.util.delete_tag()
end, {
    description = "delete tag",
    group = "tag"
}),

awful.key({mod, "Shift"}, "Left", function()
    lain.util.move_tag(-1)
end, {
    description = "move tag to the left",
    group = "tag"
}),

awful.key({mod, "Shift"}, "Right", function()
    lain.util.move_tag(1)
end, {
    description = "move tag to the right",
    group = "tag"

})

)

-- apply to all tags
for i = 1, 9 do
    globalkeys = table.join(globalkeys,

    -- view tag
    awful.key({mod}, "#" .. i + 9, function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            tag:view_only()
        end
    end),

    -- move client to tag
    awful.key({mod, "Shift"}, "#" .. i + 9, function()
        if not client.focus then
            return
        end
        local tag = client.focus.screen.tags[i]
        if tag then
            client.focus:move_to_tag(tag)
        end
    end),

    -- toggle tag on focused client
    awful.key({mod, "Control", "Shift"}, "#" .. i + 9, function()
        if not client.focus then
            return
        end
        local tag = client.focus.screen.tags[i]
        if tag then
            client.focus:toggle_tag(tag)
        end
    end)

    )
end
-- todo: add descriptions manually


root.keys(globalkeys)
