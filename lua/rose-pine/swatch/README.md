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

# Generate all colors
1. You can use `:lua =require("rose-pine.swatch.sakura")`
2. You can use the following code


```py
# run.py
import derive
palette = derive.generate_palette({
    "__name__": "Sakura Pine",
    "paint": {
        "love": "#d87576",
        "gold": "#b4b433",
        "rose": "#d875a7",
        "pine": "#466481",
        "foam": "#6996c2",
        "iris": "#696ac2",
        "tree": "#39c780"
    },
    "dawn": {
        "base": "#faedf3",
        "text": "#464681"
    },
    "main": {
        "base": "#15060e",
        "text": "#cbcbe3"
    },
    "moon": {
        "base": "#3d1127",
        "text": "#cbcbe3"
    }
})
```
```py
# generate.py
import math

__all__ = [
    "rgb_to_hex",
    "hex_to_rgb",
    "rgb_to_hsl",
    "hsl_to_rgb",
    "hsl_transfer",
    "hsl_vector",
    "generate_palette"
]


def hex_to_rgb(st):
    return {
        "r": int(st[1:3], 16),
        "g": int(st[3:5], 16),
        "b": int(st[5:7], 16),
    }


def rgb_to_hsl(rgb):
    r, g, b = rgb["r"] / 255, rgb["g"] / 255, rgb["b"] / 255
    Cmax, Cmin = max(r, g, b), min(r, g, b)

    hue = 0
    saturation = (Cmax - Cmin) / Cmax
    luminance = Cmax
    delta = Cmax - Cmin

    if delta == 0:
        pass
    elif r == Cmax:
        hue = (g - b) / delta % 6
    elif g == Cmax:
        hue = (b - r) / delta + 2
    else:
        hue = (r - g) / delta + 4

    hue = (hue * 60) % 360

    return {
        "h": hue,
        "s": min(100, saturation * 100),
        "v": min(100, luminance * 100),
    }


def hsl_to_rgb(hsl):
    hue = hsl["h"] / 360
    saturation = hsl["s"] / 100
    value = hsl["v"] / 100

    r, g, b = 0, 0, 0

    i = math.floor(hue * 6)
    f = hue * 6 - i
    p = value * (1 - saturation)
    q = value * (1 - f * saturation)
    t = value * (1 - (1 - f) * saturation)

    match i:
        case 0:
            r, g, b = value, t, p
        case 1:
            r, g, b = q, value, p
        case 2:
            r, g, b = p, value, t
        case 3:
            r, g, b = p, q, value
        case 4:
            r, g, b = t, p, value
        case _:
            r, g, b = value, p, q

    return {
        "r": min(255, round(r * 255)),
        "g": min(255, round(g * 255)),
        "b": min(255, round(b * 255)),
    }


def rgb_to_hex(rgb):
    return f"#{rgb['r']:02x}{rgb['g']:02x}{rgb['b']:02x}"


def hsl_transfer(st, vector):
    hsl = rgb_to_hsl(hex_to_rgb(st))
    rgb = hsl_to_rgb({
        "h": hsl["h"] + vector["h"],
        "s": hsl["s"] + vector["s"],
        "v": hsl["v"] + vector["v"],
    })

    return rgb_to_hex(rgb)


def hsl_vector(source, target):
    src_hsl = rgb_to_hsl(hex_to_rgb(source))
    tgt_hsl = rgb_to_hsl(hex_to_rgb(target))

    return {
        "h": tgt_hsl["h"] - src_hsl["h"],
        "s": tgt_hsl["s"] - src_hsl["s"],
        "v": tgt_hsl["v"] - src_hsl["v"],
    }


def generate_palette(skel):
    palette = {
        "dawn": {
            "foam": skel["paint"]["foam"],
            "gold": skel["paint"]["gold"],
            "iris": skel["paint"]["iris"],
            "love": skel["paint"]["love"],
            "pine": skel["paint"]["pine"],
            "rose": skel["paint"]["rose"],
            "tree": skel["paint"]["tree"],

            "base": skel["dawn"]["base"],
            "text": skel["dawn"]["text"],
            "none": "NONE",
        },
        "moon": {
            "base": skel["moon"]["base"],
            "text": skel["moon"]["text"],
            "none": "NONE",
        },
        "main": {
            "base": skel["main"]["base"],
            "text": skel["main"]["text"],
            "none": "NONE",
        },
    }

    for theme, value in vectors["dawn"]["to"].items():
        for color, vector in value.items():
            palette[theme][color] = hsl_transfer(palette["dawn"][color], vector)

    for theme, value in palette.items():
        for color, vector in vectors[theme]["base"].items():
            palette[theme][color] = hsl_transfer(value["base"], vector)

        for color, vector in vectors[theme]["text"].items():
            palette[theme][color] = hsl_transfer(value["text"], vector)

    palette["__name__"] = skel["__name__"]
    return palette


# These vectors are calculated from the original Rose Pine theme. Do not touch these, otherwise the ratios will be off.
vectors = {
    "dawn": {
        "base": {
            "_nc": { "h": -0.54298642533943, "v": -0.78431372549019, "s": 1.6548387096774 },
            "highlight_high": { "h": 282.69230769231, "v": -17.254901960784, "s": -3.2582524271845 },
            "highlight_low": { "h": -7.3076923076923, "v": -2.3529411764706, "s": -0.28196721311474 },
            "highlight_med": { "h": -22.307692307692, "v": -10.588235294118, "s": -2.5094170403587 },
            "overlay": { "h": -4.0723981900453, "v": -3.1372549019608, "s": 1.8247933884298 },
            "surface": { "h": 2.6923076923076, "v": 1.9607843137255, "s": -0.49411764705881 }
        },
        "text": {
            "muted": { "h": 8.974358974359, "v": 17.254901960784, "s": -21.322314049587 },
            "subtle": { "h": 0.30769230769235, "v": 10.196078431373, "s": -11.823241693372 }
        },
        "to": {
            "main": {
                "foam": { "h": -0.041095890410929, "v": 22.352941176471, "s": -18.134171907757 },
                "gold": { "h": 0.34524530587521, "v": 4.7058823529412, "s": -26.151761517615 },
                "iris": { "h": -0.89760638297872, "v": 24.313725490196, "s": -0.10502318194625 },
                "love": { "h": 0.10155316606932, "v": 21.56862745098, "s": 7.7659574468085 },
                "pine": { "h": 0.091185410334361, "v": 4.7058823529412, "s": -3.7313831206961 },
                "rose": { "h": -0.24764962164638, "v": 7.843137254902, "s": -20.544285007422 },
                "tree": { "h": -0.12084172511982, "v": 4.7058823529412, "s": -3.4704246956188 }
            },
            "moon": {
                "foam": { "h": -0.041095890410929, "v": 22.352941176471, "s": -18.134171907757 },
                "gold": { "h": 0.34524530587521, "v": 4.7058823529412, "s": -26.151761517615 },
                "iris": { "h": -0.89760638297872, "v": 24.313725490196, "s": -0.10502318194625 },
                "love": { "h": 0.10155316606932, "v": 21.56862745098, "s": 7.7659574468085 },
                "pine": { "h": 0.22556390977445, "v": 17.647058823529, "s": -4.6929215822346 },
                "rose": { "h": -0.52795451468796, "v": 7.4509803921569, "s": -5.9252633671238 },
                "tree": { "h": -0.45378151260505, "v": 17.647058823529, "s": -4.775828460039 }
            }
        }
    },
    "main": {
        "base": {
            "_nc": { "h": 1.6783216783217, "v": -1.9607843137255, "s": -0.62724014336917 },
            "highlight_high": { "h": -1.7307692307693, "v": 26.274509803922, "s": -12.810140237325 },
            "highlight_low": { "h": -4.9450549450549, "v": 3.921568627451, "s": -5.6763285024155 },
            "highlight_med": { "h": -0.6593406593407, "v": 18.039215686275, "s": -10.50135501355 },
            "overlay": { "h": -1.4046822742475, "v": 8.6274509803922, "s": 3.544061302682 },
            "surface": { "h": -2.1719457013575, "v": 3.921568627451, "s": 0.84541062801932 }
        },
        "text": {
            "muted": { "h": 3.1168831168831, "v": -43.137254901961, "s": 11.879128945437 },
            "subtle": { "h": 2.5454545454545, "v": -29.019607843137, "s": 8.6306653809064 }
        }
    },
    "moon": {
        "base": {
            "_nc": { "h": 0.60150375939853, "v": -2.3529411764706, "s": 0.69444444444444 },
            "highlight_high": { "h": 2.8571428571429, "v": 21.960784313725, "s": -13.434343434343 },
            "highlight_low": { "h": -0.25974025974025, "v": 3.1372549019608, "s": -3.4050179211469 },
            "highlight_med": { "h": 1.4857142857143, "v": 14.117647058824, "s": -11.111111111111 },
            "overlay": { "h": 2.5615763546798, "v": 10.980392156863, "s": -3.5230352303523 },
            "surface": { "h": 1.7857142857143, "v": 3.5294117647059, "s": -0.79365079365079 }
        },
        "text": {
            "muted": { "h": 3.1168831168831, "v": -43.137254901961, "s": 11.879128945437 },
            "subtle": { "h": 2.5454545454545, "v": -29.019607843137, "s": 8.6306653809064 }
        }
    }
}
```
