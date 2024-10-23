M = {}

local swatch_css_keys = {
    base = "layer-base",
    surface = "layer-surface",
    overlay = "layer-overlay",
    inv = "layer-inv",

    text = "text-norm",
    subtle = "text-subtle",
    muted = "text-muted",

    love = "paint-love",
    rose = "paint-rose",
    pine = "paint-pine",
    foam = "paint-foam",
    iris = "paint-iris",
    tree = "paint-tree",
    gold = "paint-gold",

    highlight_low = "hl-low",
    highlight_med = "hl-med",
    highlight_high = "hl-high"
}

---@param palette RosePine.Palette Palette to use
---@param prefix string | nil Prefix CSS variables (default "sakura")
---@param indent number | nil Indentation level (default 4)
---@param selector string | nil CSS selector (default ":root")
---@return string
function M.palette_to_CSS(palette, prefix, indent, selector)
	if(palette == nil) then
		palette = require("rose-pine.palette")
	end

    if(prefix == nil or type(prefix) ~= "string") then
        prefix = "sakura"
    end

    if(indent == nil or type(indent) ~= "number") then
        indent = 4
    end

    if(selector == nil or type(selector) ~= "string") then
        selector = ":root"
    end

    -- Add ending hyphen if necessary
    if(prefix ~= "" and prefix[#prefix - 1] ~= "-") then
        prefix = prefix .. "-"
    end

    -- Remove starting -- if necessary
    if(prefix ~= "" and prefix[1] == "-" and prefix[2] == "-") then
        prefix = prefix:sub(2)
    end

    local indent_str = string.rep(" ", indent)

    local css = selector .. " {\n"

    for key, value in pairs(swatch_css_keys) do
        css = css .. indent_str .. "--" .. prefix .. value .. ": " .. palette[key] .. ";\n"
    end

    css = css .. "}"

    return css
end

---@param swatch RosePine.Variant Swatch to convert
---@param dark_theme RosePine.Enum.Variant Which theme to use for dark theme
---@param prefix string | nil Prefix CSS variables (default "sakura")
---@param indent number | nil Indentation level (default 4)
---@param selector string | nil CSS selector (default ":root")
---@return string
function M.swatch_to_CSS(swatch, dark_theme, prefix, indent, selector)
    if(swatch == nil) then
        swatch = require("rose-pine.palette").variants
    end
    if(dark_theme ~= "moon" and dark_theme ~= "main") then
        dark_theme = "moon"
    end

    if(prefix == nil or type(prefix) ~= "string") then
        prefix = "sakura"
    end

    if(indent == nil or type(indent) ~= "number") then
        indent = 4
    end

    if(selector == nil or type(selector) ~= "string") then
        selector = ":root"
    end

    -- Add ending hyphen if necessary
    if(prefix ~= "" and prefix[#prefix - 1] ~= "-") then
        prefix = prefix .. "-"
    end

    -- Remove starting -- if necessary
    if(prefix ~= "" and prefix[1] == "-" and prefix[2] == "-") then
        prefix = prefix:sub(2)
    end

    local indent_str = string.rep(" ", indent)
    local dawn = M.palette_to_CSS(swatch.dawn, prefix .. "dawn", indent, selector)
    local moon = M.palette_to_CSS(swatch.moon, prefix .. "moon", indent, selector)
    local main = M.palette_to_CSS(swatch.main, prefix .. "main", indent, selector)

    local css = dawn .. "\n\n" .. moon .. "\n\n" .. main .. "\n\n" .. selector .. " {\n"

    for _, value in pairs(swatch_css_keys) do
        css = css .. indent_str .. "--" .. prefix .. value .. ": light-dark(" ..
            "var(--" .. prefix .. "dawn-" .. value .. "), var(--" .. prefix .. dark_theme .. "-" .. value .. "));\n"
    end

    css = css .. "}"

    return css
end

return M


