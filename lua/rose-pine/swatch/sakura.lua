local plug = require("rose-pine.swatch.derive")
local derived = plug.generatePalette({
    paint = {
        love = "#d87576",    -- Rose: Analogous
        gold = "#b4b433",    -- Rose: Triad -> Complement -> Analogous -> Mono
        rose = "#d875a7",    -- Rose
        pine = "#466481",    -- Rose: Triad -> Shade
        foam = "#6996c2",    -- Rose: Triad -> Shade
        iris = "#696ac2",    -- Rose: Triad -> Shade -> Analogous
        tree = "#33b473",    -- Rose: Complement -> Mono
    },
    dawn = {
        base = "#faedf3",    -- Rose: Mono
        text = "#464681",    -- Rose: Triad -> Analogous -> Mono
    },
    main = {
        base = "#15060e",    -- Rose: Mono
        text = "#cbcbe3",    -- Rose: Triad -> Analogous -> Mono
    },
    moon = {
        base = "#3d1127",    -- Rose: Mono
        text = "#cbcbe3",    -- Rose: Triad -> Analogous -> Mono
    }
})

return derived
