local awful = require("awful")

local tags = {}

------------------------------------------------------------------
---------------------- Fisrt Monitor Tags  ----------------------


    awful.tag.add(" Work (1) ", {
        layout = awful.layout.suit.tile,
        selected = true,
        screen = 1
    })

    awful.tag.add(" Work (2) ", {
        layout = awful.layout.suit.tile,
        selected = false,
        screen = 1
    })
    
    awful.tag.add(" Notas (3) ", {
        layout = awful.layout.suit.max,
        selected = false,
        screen = 1
    })

    awful.tag.add(" Code (4) ", {
        layout = awful.layout.suit.tile.left,
        selected = false,
        screen = 1
    })

    awful.tag.add(" Term (5) ", {
        layout = awful.layout.suit.tile.left,
        selected = false,
        screen = 1
    })

------------------------------------------------------------------
---------------------- Second Monitor Tags  ----------------------


    awful.tag.add(" Work (1) ", {
        layout = awful.layout.suit.tile,
        selected = false,
        screen = 2
    })

    awful.tag.add(" Work (2) ", {
        layout = awful.layout.suit.tile,
        selected = false,
        screen = 2
    })

    awful.tag.add(" Chat (3) ", {
        layout = awful.layout.suit.tile,
        selected = false,
        screen = 2
    })

    awful.tag.add(" Music (4) ", {
        layout = awful.layout.suit.tile,
        selected = false,
        screen = 2
    })

    awful.tag.add(" Monitor (5) ", {
        layout = awful.layout.suit.max,
        selected = true,
        screen = 2
    })

return tags