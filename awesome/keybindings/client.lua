local awful = require("awful")
local lain = require("lain")
local table = awful.util.table

local env = require("env")
local mod = env.MOD
local alt = env.ALT


clientkeys = table.join(

awful.key({mod}, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
end, {
    description = "toggle fullscreen",
    group = "client"
}),

awful.key({mod, "Shift"}, "c", function(c)
    c:kill()
end, {
    description = "close",
    group = "client"
}),

awful.key({mod, "Control"}, "space", awful.client.floating.toggle, {
    description = "toggle floating",
    group = "client"
}),

awful.key({mod}, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
end, {
    description = "toggle maximized",
    group = "client"
})

)


clientbuttons = table.join(

awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", {
        raise = true
    })
end),

-- move window with mod+m1
awful.button({mod}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", {
        raise = true
    })
    awful.mouse.client.move(c)
end),

-- resize window with mod+m3
awful.button({mod}, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", {
        raise = true
    })
    awful.mouse.client.resize(c)
end)

)


return {
    keys = clientkeys,
    buttons = clientbuttons
}
