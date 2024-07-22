local plug = require("rose-pine.swatch.derive")
local derived = plug.generatePalette({
    paint = {
        love = "#c27c51",    -- Tree: Compliment -> Triad -> Analagous -> Compliment
        gold = "#b8ab40",    -- Tree: Compliment -> Triad
        rose = "#cf7782",    -- Tree: Complement -> Triad -> Analagous -> Compliment -> Analagous
        pine = "#339288",    -- Tree: Compliment -> Triad
        foam = "#336d92",    -- Tree: Compliment -> Triad -> Analagous
        iris = "#883392",    -- Tree: Compliment
        tree = "#3d9233",    -- Tree
    },
    dawn = {
        base = "#d7f0d5",    -- Tree: Mono
        text = "#1d4718",    -- Tree: Shade
    },
    main = {
        base = "#0b1a09",    -- Tree: Mono
        text = "#a7bca5",    -- Tree: Tint
    },
    moon = {
        base = "#122c0f",    -- Tree: Mono
        text = "#a7bca5",    -- Tree: Tint
    }
})

return derived
