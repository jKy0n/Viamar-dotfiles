--[[
        jKyon (John Kennedy Loria Segundo)
        rules.lua – awesomeWM
        2025-07-10

        Purpose:
            Defines client rules for window management in AwesomeWM.
            Configures properties and behaviors for various applications.

            Define regras de clientes para gerenciamento de janelas no AwesomeWM.
            Configura propriedades e comportamentos para vários aplicativos.
--]]

--------------------------------------------------------------
----------------------  Load Libraries  ----------------------
local awful = require("awful")
local beautiful = require("beautiful")
local create_volatile_tag = require("modules.tag_utils").create_volatile_tag
local screen_utils = require("modules.screen_utils")
------------------------------------------------------------
----------------------  rules module  ----------------------
local rules = {}



awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
        properties = {  border_width = beautiful.border_width,
                        border_color = beautiful.border_normal,
                        focus = awful.client.focus.filter,
                        raise = true,
                        keys = clientkeys,
                        buttons = clientbuttons,
                        screen = awful.screen.preferred,
                        placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

---------------------------------------------------------
----------------  Customized Rules List  ----------------
----
-- A
--
    { rule_any = { class = {"ark"} },
    properties = { floating = true,
    placement = awful.placement.centered },},

    { rule_any = { class = {"Arandr"} },
    properties = { floating = true,
    placement = awful.placement.centered },},

-- B
--
    { rule_any = { class = {"brasero", "Brasero"} },
    properties = { floating = true,
    placement = awful.placement.centered },},

-- C
--
-- D
--
    { rule_any = { class = {"dolphin", "dolphin"} },
    properties = { floating = true,
    placement = awful.placement.centered },},

-- E
--
-- F
--
    { rule_any = { instance = { "floating-terminal" }, class = { "FloatingTerminal" } },
        properties = { floating = true,
        width = 1536,
        height = 864,
        x = 192,
        y = 108,
        placement = awful.placement.centered
        },
    },

    { rule = { class = "feh" },
    properties = {
        floating = true,
        name = "feh",
        width = 1536,     -- Defina o tamanho que deseja
        height = 864,     -- Defina o tamanho que deseja
        x = 192,          -- Posição x
        y = 108, },         -- Posição y
        callback = function(c)
            local s = screen_utils.left()
            if s then
                c.screen = s
            end
            awful.placement.centered(c, { honor_workarea = true })
        end
    },

-- G
--
    { rule_any = { class = { "gedit", "Gedit" } },
    properties = {
        floating = true,
        name = "Okular",
        width = 1536,
        height = 864,
    },
    callback = function(c)
        local s = screen_utils.left()
        if s then
            c.screen = s
        end
        awful.placement.centered(c, { honor_workarea = true })
    end,
    },

    { rule_any = { class = {"gimp", "Gimp"} },
    properties = { floating = false, },
        callback = function(c)
            create_volatile_tag(c, " GIMP ", "left", awful.layout.suit.tile.left)
        end},

    { rule = { class = "Google-chrome" },
    properties = { floating = false,
    placement = awful.placement.centered },},

    { rule = { class = "gnome-calculator" },
    properties = { floating = true,
    placement = awful.placement.centered },},

    { rule_any = { class = {"Gnome-disks", "gnome-disks"} },
    properties = { floating = true,
    placement = awful.placement.centered },},

    { rule_any = { class = {"gpt4all-chat", "GPT4All"} },
    properties = { floating = false },
        callback = function(c)
            create_volatile_tag(c, " LLMs ", "left", awful.layout.suit.tile.left)
        end },

-- H
--
-- I
--
-- J
--
-- K
--
    { rule_any = { class = { "kclock", "kclock" } },
    properties = {
        floating = true,
        placement = awful.placement.centered,
    },
    callback = function(c)
        local s = screen_utils.right()
        if s and s.tags and s.tags[5] then
            c:move_to_tag(s.tags[5])
            s.tags[5]:view_only()
        end
    end,
    },

    { rule_any = { class = {"kdeconnect-app", "kdeconnect.app"} },
    properties = { floating = true,
    placement = awful.placement.centered,},
    callback = function(c)
        local s = screen_utils.right()
        if s and s.tags and s.tags[5] then
            c:move_to_tag(s.tags[5])
            s.tags[5]:view_only()
        end
    end,
    },

    { rule_any = { class = { "krita", "krita" } },
    properties = { floating = false, },
        callback = function(c)
            create_volatile_tag(c, " Krita ", "left", awful.layout.suit.tile)
    end },

-- L
--
    { rule_any = { class = {"lm studio", "LM Studio" } },
    properties = { floating = false },
        callback = function(c)
            create_volatile_tag(c, " LLMs ", "left", awful.layout.suit.tile)
    end },

    { rule = { class = "Lxappearance" },
    properties = { floating = true,
    placement = awful.placement.centered },},

-- M
--
    { rule = { class = "mpv" },
    properties = {
        name = "mpv",
        floating = true,
        width = 1536,
        height = 864,
    },
    callback = function(c)
        local s = screen_utils.left()
        if s then
            c.screen = s
        end
        awful.placement.centered(c, { honor_workarea = true })
    end,
    },

    { rule_any = { class = {"mupdf", "MuPDF"} },
    properties = {
        floating = true,
        name = "muPDF",
        width = 1536,
        height = 864,
    },
    callback = function(c)
        local s = screen_utils.left()
        if s then
            c.screen = s
        end
        awful.placement.centered(c, { honor_workarea = true })
    end,
    },

-- N
--
-- O
--
    { rule_any = {  class = { "obsidian", "obsidian" } },
    properties = {  floating = false },
    callback = function(c)
      local s = screen_utils.left() -- ou right()
      if s and s.tags and s.tags[3] then
          c:move_to_tag(s.tags[3])
          s.tags[3]:view_only()
      end
    end },

    { rule_any = { class = { "okular", "okular" } },
    properties = {
        floating = true, name = "Okular",
        width = 1536,     -- Defina o tamanho que deseja
        height = 864 },     -- Defina o tamanho que deseja
        callback = function(c)
                local s = screen_utils.left()
                if s then
                    c.screen = s
                end
                awful.placement.centered(c, { honor_workarea = true })
        end
    },

    { rule = { class = "openrgb" },
    properties = { floating = true,
    placement = awful.placement.centered },},

-- P
--
    { rule_any = { class = {"pavucontrol", "Pavucontrol"} },
    properties = { floating = false,},
      callback = function(c)
      local s = screen_utils.right() -- ou left()
      if s and s.tags and s.tags[4] then
          c:move_to_tag(s.tags[4])
          s.tags[4]:view_only()
      end
    end},

-- Q
--
    { rule = { class = "qt5ct" },
    properties = { floating = true,
    placement = awful.placement.centered },},

    { rule = { class = "qt6ct" },
    properties = { floating = true,
    placement = awful.placement.centered },},

-- R
--
    { rule = { class = "rambox" },
    properties = { floating = false,
    placement = awful.placement.centered },
        callback = function(c)
            local s = screen_utils.right()
            if s and s.tags and s.tags[3] then
                c:move_to_tag(s.tags[3])
                s.tags[3]:view_only()
            end
        end
    },

-- S
--
    { rule_any = { class = {"simple-scan" , "simple-scan"} },
    properties = { floating = false },
        callback = function(c)
            create_volatile_tag(c, " Scan ", "left", awful.layout.suit.tile)
        end,},

    { rule_any = { class = {"skanpage" , "skanpage"} },
    properties = { floating = false },
        callback = function(c)
            create_volatile_tag(c, " Scan ", "left", awful.layout.suit.tile)
        end,},

    { rule = { class = "Spotify" },
    properties = { floating = false,
    placement = awful.placement.centered},
      callback = function(c)
      local s = screen_utils.right() -- ou right()
      if s and s.tags and s.tags[4] then
          c:move_to_tag(s.tags[4])
          s.tags[4]:view_only()
      end
    end },

    { rule_any = { class = {"snappergui", "Snapper-gui"} },
    properties = { floating = true ,
    placement = awful.placement.centered },},

-- T
--
    { rule_any = { class = { "teams-for-linux", "teams-for-linux" } },
    properties = { floating = false },
        callback = function(c)
            create_volatile_tag(c, " Teams ", "right", awful.layout.suit.tile)
    end },

    { rule_any = { class = {"Telegram", "TelegramDesktop"} },
    properties = { floating = false },
        callback = function(c)
            create_volatile_tag(c, " Telegram ", "right", awful.layout.suit.max)
        end },

    { rule_any = { class = {"Mail", "thunderbird"} },
    properties = { floating = false },
        callback = function(c)
            create_volatile_tag(c, " Mail ", "left", awful.layout.suit.tile)
        end },

-- U
--
-- V
--
    { rule_any = { class = {"virt-manager", "Virt-manager"} },
    properties = { floating = false },
        callback = function(c)
            create_volatile_tag(c, " VMs ", "right", awful.layout.suit.tile)
        end },

    { rule_any = { class = {"code", "Code"} }, -- VSCode
    properties = { floating = false,
    placement = awful.placement.left},
        callback = function(c)
            local s = screen_utils.left()
            if s and s.tags and s.tags[4] then
                c:move_to_tag(s.tags[4])
                s.tags[4]:view_only()
            end
        end
    },

-- W
--
    { rule_any = { class = {"winboat", "winboat"} },
    properties = { floating = true },
        callback = function(c)
            create_volatile_tag(c, " WinBoat ", "right", awful.layout.suit.max)
        end },

-- X
--
-- Y
--
-- Z


----------------------------------------------------------
----------------------  Misc rules  ----------------------

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },
}
-- }}}

return rules