<p align="center">
    <img src="https://github.com/rose-pine/rose-pine-theme/raw/main/assets/icon.png" width="80" />
    <h2 align="center">Sakura Pine for Neovim</h2>
</p>

<p align="center">Like Rosé Pine, but more Sakura</p>

> [!IMPORTANT]
> This fork:
> - Has a new green color called "tree"
>   - I am aware that recent additions to Rosé Pine has "leaf," but that was after this fork
> - Has a new swatch called "Sakura," because I like pink
>   - See the [Swatch Readme](/lua/rose-pine/swatch)
> - Now derives all colors, from only the Dawn palette
>   - Generate themes with ease

## Getting started

Install `rose-pine/neovim` using your favourite plugin manager:

**paq-nvim**

```lua
{ "voxelprismatic/sakurapine", as = "rose-pine" }
```

**lazy.nvim**

```lua
{ "voxelprismatic/sakurapine", name = "rose-pine" }
```

## Gallery

<details>
	<summary><b>Rosé Pine</b></summary>

![Rosé Pine with Neovim](https://user-images.githubusercontent.com/1973/163921570-0f577baf-3199-4f09-9779-a7eb9238151a.png)

**Rosé Pine Moon**

![Rosé Pine Moon with Neovim](https://user-images.githubusercontent.com/1973/163921620-d3acd0d2-d227-4d28-a5e8-97ff22e56c6d.png)

**Rosé Pine Dawn**

![Rosé Pine Dawn with Neovim](https://user-images.githubusercontent.com/1973/163921656-644a2db3-c55c-4e89-9bdd-39cdd7a2681b.png)
	
</details>

<details>
    <summary><b>Sakura Pine</b></summary>

![image](https://github.com/user-attachments/assets/18246fd0-f5f6-4863-aa3b-3128454dff7f)
![image](https://github.com/user-attachments/assets/1bcf7ad1-d13b-4ae9-9e7e-da254c326541)
![image](https://github.com/user-attachments/assets/88d8c75d-86c3-4b1a-b78c-2bb88010623a)

</details>

<details>
    <summary><b>Forest</b></summary>

![image](https://github.com/user-attachments/assets/2c9b0b00-6116-41a0-8ba4-802a6aa3dd80)
![image](https://github.com/user-attachments/assets/30b5f597-19d7-4207-b9e4-a27327da5f2b)
![image](https://github.com/user-attachments/assets/8182ed1e-65ee-4095-8250-a2f7e18b906e)


</details>

## Options

> [!IMPORTANT]
> Configure options _before_ setting colorscheme.

Rosé Pine has three `variant`s: main, moon, and dawn. By default, `vim.o.background` is followed, using dawn when light and `dark_variant` when dark.

Colour values accept named colours from the [Rosé Pine palette](https://rosepinetheme.com/palette/ingredients/), e.g. "foam", or valid hex, e.g. "#fa8072".
Sakura Pine also has a green color called `tree`

> [!NOTE]
> Sakura Pine has the available swatches:
> - `rosepine`
> - `sakura`
> - `forest`

```lua
require("rose-pine").setup({
    variant = "auto", -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    swatch = "rosepine" -- sakura, forest, or rosepine

    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
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

    highlight_groups = {
        -- Comment = { fg = "foam" },
        -- VertSplit = { fg = "muted", bg = "muted" },
    },

    before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
    end,
})

vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme rose-pine-main")
-- vim.cmd("colorscheme rose-pine-moon")
-- vim.cmd("colorscheme rose-pine-dawn")
```

> [!NOTE]
> Visit the [wiki](https://github.com/rose-pine/neovim/wiki) for [plugin configurations](https://github.com/rose-pine/neovim/wiki/Plugin-configurations) and [recipes](https://github.com/rose-pine/neovim/wiki/Recipes).

## Contributing

We welcome and appreciate contributions of any kind. Create an issue or start a discussion for any proposed changes. Pull requests are encouraged for supporting additional plugins or [treesitter improvements](https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#highlights).

Feel free to update the [wiki](https://github.com/rose-pine/neovim/wiki/) with any [recipes](https://github.com/rose-pine/neovim/wiki/Recipes).
