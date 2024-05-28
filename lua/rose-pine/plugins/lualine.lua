local generator = {}

function generator.alternate(p)
    return {
        normal = {
            a = { bg = p.surface, fg = p.rose, gui = "bold" },
            b = { bg = p.surface, fg = p.text },
            c = { bg = p.surface, fg = p.subtle, gui = "italic" },
        },
        insert = {
            a = { bg = p.surface, fg = p.foam, gui = "bold" },
        },
        visual = {
            a = { bg = p.surface, fg = p.iris, gui = "bold" },
        },
        replace = {
            a = { bg = p.surface, fg = p.pine, gui = "bold" },
        },
        command = {
            a = { bg = p.surface, fg = p.love, gui = "bold" },
        },
        terminal = {
            a = { bg = p.surface, fg = p.gold, gui = "bold" },
        },
        inactive = {
            a = { bg = p.surface, fg = p.tree, gui = "bold" },
            b = { bg = p.surface, fg = p.text },
            c = { bg = p.surface, fg = p.subtle, gui = "italic" },
        },
        variants = {},
    }
end

function generator.normal(p)
    local config = require("rose-pine.config")

    local bg_base = p.base
    if config.options.styles.transparency then
        bg_base = "NONE"
    end

    return {
        normal = {
            a = { bg = p.rose, fg = p.base, gui = "bold" },
            b = { bg = p.overlay, fg = p.rose },
            c = { bg = bg_base, fg = p.text },
        },
        insert = {
            a = { bg = p.foam, fg = p.base, gui = "bold" },
            b = { bg = p.overlay, fg = p.foam },
        },
        visual = {
            a = { bg = p.iris, fg = p.base, gui = "bold" },
            b = { bg = p.overlay, fg = p.iris },
        },
        replace = {
            a = { bg = p.pine, fg = p.base, gui = "bold" },
            b = { bg = p.overlay, fg = p.pine },
        },
        command = {
            a = { bg = p.love, fg = p.base, gui = "bold" },
            b = { bg = p.overlay, fg = p.love },
        },
        terminal = {
            a = { bg = p.gold, fg = p.base, gui = "bold" },
            b = { bg = p.overlay, fg = p.gold },
        },
        inactive = {
            a = { bg = p.tree, fg = p.base, gui = "bold" },
            b = { bg = p.overlay, fg = p.tree },
            c = { bg = bg_base, fg = p.text },
        },
        variants = {},
    }
end

function generator.neutral(p)
    return {
        normal = {
            a = { bg = p.rose, fg = p.base, gui = "bold" },
            b = { bg = p.highlight_med, fg = p.rose },
            c = { bg = p.highlight_high, fg = p.text },
        },
        insert = {
            a = { bg = p.foam, fg = p.base, gui = "bold" },
            b = { bg = p.highlight_med, fg = p.foam },
        },
        visual = {
            a = { bg = p.iris, fg = p.base, gui = "bold" },
            b = { bg = p.highlight_med, fg = p.iris },
        },
        replace = {
            a = { bg = p.pine, fg = p.base, gui = "bold" },
            b = { bg = p.highlight_med, fg = p.pine },
        },
        command = {
            a = { bg = p.love, fg = p.base, gui = "bold" },
            b = { bg = p.highlight_med, fg = p.love },
        },
        terminal = {
            a = { bg = p.gold, fg = p.base, gui = "bold" },
            b = { bg = p.highlight_med, fg = p.gold },
        },
        inactive = {
            a = { bg = p.tree, fg = p.base, gui = "bold" },
            b = { bg = p.highlight_med, fg = p.tree },
            c = { bg = p.highlight_high, fg = p.text },
        },
        variants = {}
    }
end

function generator.inverse(p)
    -- To prevent cached import during background change
    local palette = require("rose-pine.palette")
    if p.base == palette.variants.moon.base then
        return generator.normal(palette.variants.dawn)
    elseif p.base == palette.variants.main.base then
        return generator.normal(palette.variants.dawn)
    elseif p.base == palette.variants.dawn.base then
        return generator.normal(palette.variants.moon)
    end
end

-- function generator.
local function make()
    -- To prevent cached import during background change
    local palette = require("rose-pine.palette")

    local default = {}
    for t, fn in pairs(generator) do
        default[t] = fn(palette)
        for k, v in pairs(palette.variants) do
            default[t].variants[k] = fn(v)
        end
    end

    return default
end

return make
