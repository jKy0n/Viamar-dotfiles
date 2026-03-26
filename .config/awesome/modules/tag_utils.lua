--[[
        jKyon (John Kennedy Loria Segundo)
        tag_utils.lua – awesomeWM
        Restaurado com suporte a screen_utils
--]]

--------------------------------------------------------------
----------------------  Load Libraries  ----------------------
local awful = require("awful")
local screen_utils = require("modules.screen_utils")

--------------------------------------------------------------
---------------------  tag_utils module  ---------------------
local tag_utils = {}

local function resolve_screen(screen_ref)
    if type(screen_ref) == "userdata" then
        return screen_ref
    end

    if screen_ref == "primary" then
        return screen_utils.primary()
    elseif screen_ref == "secondary" then
        return screen_utils.secondary()
    elseif screen_ref == "left" then
        return screen_utils.left()
    elseif screen_ref == "right" then
        return screen_utils.right()
    elseif type(screen_ref) == "number" then
        return screen[screen_ref]
    end

    return screen_utils.primary()
end

local function add_tag()
    awful.tag.add(" NewTag ", {
        screen = awful.screen.focused(),
        layout = awful.layout.suit.tile,
        volatile = true
    }):view_only()
end

local function delete_tag()
    local t = awful.screen.focused().selected_tag
    if not t then return end
    t:delete()
end

local function rename_tag()
    awful.prompt.run {
        prompt       = "New tag name: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = function(new_name)
            if not new_name or #new_name == 0 then return end

            local t = awful.screen.focused().selected_tag
            if t then
                t.name = new_name
            end
        end
    }
end

local function move_to_new_tag()
    local c = client.focus
    if not c then return end

    local t = awful.tag.add(c.class, {
        screen = c.screen,
        layout = awful.layout.suit.tile,
        volatile = true
    })

    c:tags({ t })
    t:view_only()
end

-- Busca tags pelo nome BASE (ignorando o índice entre parênteses)
local function find_tag_by_base_name(target_screen, base_name)
    local pattern = "^" .. base_name .. " %(%d+%) ?$"
    for _, tag in ipairs(target_screen.tags) do
        if tag.name:match(pattern) then
            return tag
        end
    end
    return nil
end

-- Cria tags com nomeação dinâmica "nome (índice)"
local function create_volatile_tag(c, base_name, screen_ref, layout)
    local target_screen = resolve_screen(screen_ref)
    if not target_screen then return end

    local existing_tag = find_tag_by_base_name(target_screen, base_name)

    if existing_tag then
        c:move_to_tag(existing_tag)
        existing_tag:view_only()
    else
        local new_tag = awful.tag.add(base_name, {
            screen = target_screen,
            layout = layout or awful.layout.suit.tile,
            volatile = true,
        })

        new_tag.name = base_name .. " (" .. new_tag.index .. ") "

        c:move_to_tag(new_tag)
        new_tag:view_only()
    end
end

--------------------------------------------------------------
--------------------  Exported Functions  --------------------
tag_utils.add_tag = add_tag
tag_utils.delete_tag = delete_tag
tag_utils.rename_tag = rename_tag
tag_utils.move_to_new_tag = move_to_new_tag
tag_utils.find_tag_by_base_name = find_tag_by_base_name
tag_utils.create_volatile_tag = create_volatile_tag

return tag_utils