local config = {}

---@type RosePine.Options
config.options = {
    variant = "auto",
    dark_variant = "main",
    swatch = "rosepine",

    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        legacy_highlights = true,
        migrations = true,
        terminal = true,
    },

    styles = {
        bold = true,
        italic = true,
        transparency = false,
    },

    groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
    },

    highlight_groups = {},

    before_highlight = function() end,
}

local function migrate(options)
    if options.bold_vert_split then
        local border = options.groups.border or "muted"
        options.highlight_groups["VertSplit"] = { fg = border, bg = border }
        options.highlight_groups["WinSeparator"] = { fg = border, bg = border }
    end

    if options.disable_background then
        options.highlight_groups["Normal"] = { bg = "NONE" }
    end

    if options.disable_float_background then
        options.highlight_groups["NormalFloat"] = { bg = "NONE" }
    end

    options.dim_inactive_windows = options.dim_nc_background or options.dim_inactive_windows

    if options.groups.background ~= nil then
        options.highlight_groups["Normal"] = { bg = options.groups.background }
    end

    if options.groups.comment ~= nil then
        options.highlight_groups["Comment"] = { fg = options.groups.comment }
    end

    if options.groups.punctuation ~= nil then
        options.highlight_groups["@punctuation"] = { fg = options.groups.punctuation }
    end

    options.styles.transparency = (options.disable_background and options.disable_float_background)
    or options.styles.transparency

    -- These never actually existed, but may be set intuitively by the user
    -- because of `disable_italics` existing.
    options.styles.bold = not (options.disable_bold or options.disable_bolds) and options.styles.bold or false

    -- Similar to bold options, `disable_italic` never existed but could be a
    -- common typo of the actual `disable_italics`.
    options.styles.italic = not (options.disable_italic or options.disable_italics) and options.styles.italic or false

    -- Set h1 through h6 to the same color if only one is specified
    if type(options.groups.headings) == "string" then
        options.groups.h1 = options.groups.headings
        options.groups.h2 = options.groups.headings
        options.groups.h3 = options.groups.headings
        options.groups.h4 = options.groups.headings
        options.groups.h5 = options.groups.headings
        options.groups.h6 = options.groups.headings
    elseif options.groups.headings == "table" then
        options.groups.h1 = options.groups.headings.h1 or options.groups.h1
        options.groups.h2 = options.groups.headings.h2 or options.groups.h2
        options.groups.h3 = options.groups.headings.h3 or options.groups.h3
        options.groups.h4 = options.groups.headings.h4 or options.groups.h4
        options.groups.h5 = options.groups.headings.h5 or options.groups.h5
        options.groups.h6 = options.groups.headings.h6 or options.groups.h6
    end
    options.groups.headings = nil

    return options
end

---@param options RosePine.Options | nil
function config.extend_options(options)
    config.options = vim.tbl_deep_extend("force", config.options, options or {})

    if config.options.enable.migrations then
        config.options = migrate(config.options)
    end
end

return config
