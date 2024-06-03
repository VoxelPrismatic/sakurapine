local plug = require("rose-pine.swatch.derive")
local derived = plug.generatePalette({
    paint = {
        love = "#b4637a",
        gold = "#ea9d34",
        rose = "#d7827e",
        pine = "#286983",
        foam = "#56949f",
        iris = "#907aa9",
        tree = "#34ab7e",
    },
    dawn = {
        base = "#faf4ed",
        text = "#575279",
    },
    main = {
        base = "#191724",
        text = "#e0def4",
    },
    moon = {
        base = "#232136",
        text = "#e0def4",
    }
})

return derived
