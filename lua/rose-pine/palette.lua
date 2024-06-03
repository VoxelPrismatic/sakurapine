local options = require("rose-pine.config").options
local swatches = require("rose-pine.swatch")

local variants = swatches[options.swatch] or swatches.rosepine

local chosen = {}
if variants[options.variant] ~= nil then
    chosen = variants[options.variant]
elseif vim.o.background == "light" then
    chosen = variants.dawn
elseif options.dark_variant then
    chosen = variants[options.dark_variant]
else --fallback
    chosen = variants.main
end

chosen.variants = variants
return chosen
