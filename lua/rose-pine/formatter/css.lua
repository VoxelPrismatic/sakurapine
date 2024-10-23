M = {}

---@param palette RosePine.Palette Palette to use
---@param prefix string | nil Prefix CSS variables (default "sakura")
---@param indent number | nil Indentation level (default 4)
---@param selector string | nil CSS selector (default ":root")
---@return string
function M.toCSS(palette, prefix, indent, selector)
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

	local css = selector .. " {\n" ..
				indent_str .. "--" .. prefix .. "hl-high: " .. palette.highlight_high .. ";\n" ..
				indent_str .. "--" .. prefix .. "hl-med: " .. palette.highlight_med .. ";\n" ..
				indent_str .. "--" .. prefix .. "hl-low: " .. palette.highlight_low .. ";\n\n" ..
				indent_str .. "--" .. prefix .. "layer-overlay: " .. palette.overlay .. ";\n" ..
				indent_str .. "--" .. prefix .. "layer-surface: " .. palette.surface .. ";\n" ..
				indent_str .. "--" .. prefix .. "layer-base: " .. palette.base .. ";\n" ..
				indent_str .. "--" .. prefix .. "layer-inv: " .. palette.inv .. ";\n\n" ..
				indent_str .. "--" .. prefix .. "text-norm: " .. palette.text .. ";\n" ..
				indent_str .. "--" .. prefix .. "text-muted: " .. palette.muted .. ";\n" ..
				indent_str .. "--" .. prefix .. "text-subtle: " .. palette.subtle .. ";\n\n" ..
				indent_str .. "--" .. prefix .. "paint-foam: " .. palette.foam .. ";\n" ..
				indent_str .. "--" .. prefix .. "paint-gold: " .. palette.gold .. ";\n" ..
				indent_str .. "--" .. prefix .. "paint-iris: " .. palette.iris .. ";\n" ..
				indent_str .. "--" .. prefix .. "paint-pine: " .. palette.pine .. ";\n" ..
				indent_str .. "--" .. prefix .. "paint-tree: " .. palette.tree .. ";\n" ..
				indent_str .. "--" .. prefix .. "paint-love: " .. palette.love .. ";\n" ..
				indent_str .. "--" .. prefix .. "paint-rose: " .. palette.rose .. ";\n" ..
				"}"

	return css
end

return M
