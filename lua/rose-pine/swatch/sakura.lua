local plug = require("rose-pine.swatch.derive")
local derived = plug.generatePalette({
    paint = {
        love = "#c26b74",
        gold = "#ff733f",
        rose = "#d08e95",
        pine = "#415777",
        foam = "#617da1",
        iris = "#8aaacd",
        tree = "#40c9a2",
    },
    dawn = {
        base = "#f4e4e6",
        text = "#526091",
    },
    main = {
        base = "#17090a",
        text = "#dde0eb",
    },
    moon = {
        base = "#220e10",
        text = "#dde0eb",
    }
})

return derived
