---@class RosePine.Palette
---@field _nc string
---@field base string Focused window background color
---@field surface string Unfocused window background color
---@field overlay string Popup background color
---@field muted string Muted text; eg for comments
---@field subtle string Subtle text; eg for virtual text
---@field text string Main text color
---@field love string A deep red
---@field gold string A bright yellow
---@field rose string A calm pink
---@field pine string A subtle blue pine
---@field foam string A calm cyan
---@field iris string A muted purple
---@field tree string A pastel green
---@field inv string Background color: Moon/Main --> Dawn; Dawn --> Moon
---@field highlight_low string A low contrast background
---@field highlight_med string A medium contrast background
---@field highlight_high string A high contrast background
---@field none "NONE" None
---@field variants? RosePine.Variant


---@class RosePine.Variant
---@field main RosePine.Palette Darkest palette
---@field moon RosePine.Palette Lighter than main palette
---@field dawn RosePine.Palette Lightest palette


---@class RosePine.Swatches
---@field rosepine RosePine.Variant The original RosePine palette
---@field sakura RosePine.Variant A calming pink palette
---@field forest RosePine.Variant For those who really like touching grass
---@field [string] RosePine.Variant An unnamed swatch


---@class RosePine.Options
---@field public variant? "auto" | RosePine.Enum.Variant Set the desired variant; "auto" will follow the Vim background
---@field public dark_variant? RosePine.Enum.Variant Set the desired dark variant when `options.variant` is set to "auto" and `vim.o.background` = "dark"
---@field public swatch? RosePine.Enum.Swatch Set the desired swatch
---@field public dim_inactive_windows? boolean Differentiate between active and inactive windows and panels.
---@field public extend_background_behind_borders? boolean Extend background behind borders
---@field public enable? RosePine.Options.Enable
---@field public styles? RosePine.Options.Styles
---@field public groups? RosePine.Options.Groups
---@field public highlight_groups? RosePine.Options.HighlightGroups
---@field public before_highlight? fun(group: string, highlight: vim.api.keyset.highlight, palette: RosePine.Palette) Called before each highlight group is set


---@class RosePine.Options.Enable
---@field legacy_highlights? boolean
---@field migrations? boolean
---@field terminal? boolean


---@class RosePine.Options.Styles
---@field bold? boolean
---@field italic? boolean
---@field transparency? boolean


---@class RosePine.Options.Groups
---@field border? RosePine.Enum.Palette.Any Nvim window border color
---@field link? RosePine.Enum.Palette.Any Link color in docs/comments
---@field panel? RosePine.Enum.Palette.Any Panel background color
---@field error? RosePine.Enum.Palette.Any Error virtual text color
---@field hint? RosePine.Enum.Palette.Any Hint virtual text color
---@field info? RosePine.Enum.Palette.Any Info virtual text color
---@field note? RosePine.Enum.Palette.Any Note virtual text color
---@field todo? RosePine.Enum.Palette.Any Todo virtual text color
---@field warn? RosePine.Enum.Palette.Any Warning virtual text color
---@field git_add? RosePine.Enum.Palette.Any Git column icon color for Add line
---@field git_change? RosePine.Enum.Palette.Any Git column icon color for Change line
---@field git_delete? RosePine.Enum.Palette.Any Git column icon color for Delete line
---@field git_dirty? RosePine.Enum.Palette.Any Git column icon color for Dirty File
---@field git_ignore? RosePine.Enum.Palette.Any Git text color for Commit Comment
---@field git_merge? RosePine.Enum.Palette.Any Git column icon color for Merge Conflict
---@field git_rename? RosePine.Enum.Palette.Any Git column icon color for Renamed File
---@field git_stage? RosePine.Enum.Palette.Any Git text color for Commit Summary
---@field git_text? RosePine.Enum.Palette.Any Git text color for Commit Description
---@field git_untracked? RosePine.Enum.Palette.Any Git column icon for Untracked/Ignored file
---@field h1? RosePine.Enum.Palette.Any - # Markdown H1 color
---@field h2? RosePine.Enum.Palette.Any - ## Markdown H2 color
---@field h3? RosePine.Enum.Palette.Any - ### Markdown H3 color
---@field h4? RosePine.Enum.Palette.Any - #### Markdown H4 color
---@field h5? RosePine.Enum.Palette.Any - ##### Markdown H5 color
---@field h6? RosePine.Enum.Palette.Any - ###### Markdown H6 color
---@field [string] RosePine.Enum.Palette.Any


---@class RosePine.Options.HighlightGroups
---@field [string] vim.api.keyset.highlight


---@alias RosePine.Enum.Variant "main" | "moon" | "dawn"
---@alias RosePine.Enum.Swatch "rosepine" | "sakura" | "forest"
---@alias RosePine.Enum.Palette.Paint "love" | "gold" | "rose" | "pine" | "foam" | "iris" | "tree"
---@alias RosePine.Enum.Palette.Layer "base" | "surface" | "overlay"
---@alias RosePine.Enum.Palette.Highlight "highlight_low" | "highlight_med" | "highlight_high"
---@alias RosePine.Enum.Palette RosePine.Enum.Palette.Paint | RosePine.Enum.Palette.Layer | RosePine.Enum.Palette.Highlight
---@alias RosePine.Enum.Palette.Any string | RosePine.Enum.Palette
