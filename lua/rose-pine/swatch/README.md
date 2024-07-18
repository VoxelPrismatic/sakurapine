# What's this?
This is where all the themes are stored. Because I don't want to find all the colors for every theme, I decided to take HSL vectors to generate the rest of them.

The `paint` table stores the primary colors **for the Dawn palette**. These are then transformed into those respective colors for the Main and Moon palettes.
The `dawn`, `main`, and `moon` tables store the foreground and background colors. The `base` color will be transformed into `overlay` and `surface` colors, providing
three layers of popups. The `text` color will be transformed into `muted`, `subtle`, `highlight_low`, `highlight_med`, and `highlight_high`.
```lua
local plug = require("rose-pine.swatch.derive")
local derived = plug.generatePalette({
    paint = {
        love = "#b4637a", --Red
        gold = "#ea9d34", --Yellow
        rose = "#d7827e", --Pink
        pine = "#286983", --Darker Blue/navy
        foam = "#56949f", --Medium blue-ish
        iris = "#907aa9", --Lighter blue-ish
        tree = "#34ab7e", --Green
    },
    dawn = {
        base = "#faf4ed", --Background color
        text = "#575279", --Foreground color
    },
    main = {
        base = "#191724", --Background color
        text = "#e0def4", --Foreground color
    },
    moon = {
        base = "#232136", --Background color
        text = "#e0def4", --Foreground color
    }
})

return derived
```
I will generate a python script which will output all palettes as JSON soon, but you can just `:lua =require("rose-pine.swatch").sakura` to get the full table of colors. Enjoy!
