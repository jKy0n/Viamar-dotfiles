--[[
        jKyon (John Kennedy Loria Segundo)
        tags.lua – awesomeWM
        2025-07-10

        Purpose:
            Defines the initial tags for the first and second monitors in AwesomeWM.
            Sets up a structured workspace with specific layouts and tag names.

            Define as tags iniciais para os primeiros e segundos monitores no AwesomeWM.
            Configura um espaço de trabalho estruturado com layouts e nomes de tags específicos.
--]]

--------------------------------------------------------------
----------------------  Load Libraries  ----------------------

local awful = require("awful")
local screen_utils = require("modules.screen_utils")

local tags = {}

function tags.setup()
    local left = screen_utils.left()
    local right = screen_utils.right()

    if not left then
        return
    end

    if not right then
        right = left
    end

    awful.tag.add(" Work (1) ", {
        layout = awful.layout.suit.tile,
        selected = true,
        screen = left
    })

    awful.tag.add(" Work (2) ", {
        layout = awful.layout.suit.tile,
        selected = false,
        screen = left
    })

    awful.tag.add(" Notas (3) ", {
        layout = awful.layout.suit.max,
        selected = false,
        screen = left
    })

    awful.tag.add(" Code (4) ", {
        layout = awful.layout.suit.max,
        selected = false,
        screen = left
    })

    awful.tag.add(" Term (5) ", {
        layout = awful.layout.suit.tile.left,
        selected = false,
        screen = left
    })

    awful.tag.add(" SSH (6) ", {
        layout = awful.layout.suit.tile.left,
        selected = false,
        screen = left
    })

    awful.tag.add(" Work (1) ", {
        layout = awful.layout.suit.tile,
        selected = false,
        screen = right
    })

    awful.tag.add(" Work (2) ", {
        layout = awful.layout.suit.tile,
        selected = false,
        screen = right
    })

    awful.tag.add(" Chat (3) ", {
        layout = awful.layout.suit.tile,
        selected = false,
        screen = right
    })

    awful.tag.add(" Music (4) ", {
        layout = awful.layout.suit.tile,
        selected = false,
        screen = right
    })

    awful.tag.add(" Monitor (5) ", {
        layout = awful.layout.suit.max,
        selected = true,
        screen = right
    })
end

return tags