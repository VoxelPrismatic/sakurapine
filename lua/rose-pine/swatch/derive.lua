local M = {}


-- Converts a hex string to RGB
---@param hex string
---@return RGB
function M.hexToRgb(hex)
    hex = hex:gsub("#", "")
    return {
        r = tonumber("0x" .. hex:sub(1, 2)),
        g = tonumber("0x" .. hex:sub(3, 4)),
        b = tonumber("0x" .. hex:sub(5, 6)),
    }
end


-- Converts RGB to HSL
---@param rgb RGB
---@return HSL
function M.rgbToHsl(rgb)
    local r, g, b = rgb.r / 255, rgb.g / 255, rgb.b / 255
    local max, min = math.max(r, g, b), math.min(r, g, b)

    local h = 0
    local s = (max - min) / max
    local l = max
    local d = max - min

    if d == 0 then
        -- pass
    elseif r == max then
        h = (g - b) / d % 6
    elseif g == max then
        h = (b - r) / d + 2
    else
        h = (r - g) / d + 4
    end

    h = math.fmod(h * 60, 360)

    return {
        h = h,
        s = s * 100,
        l = l * 100,
    }
end


-- Converts HSL to RGB
---@param hsl HSL
---@return RGB
function M.hslToRgb(hsl)
    local h = hsl.h / 360
    local s = math.max(0, math.min(1, hsl.s / 100))
    local v = math.max(0, math.min(1, hsl.l / 100))

    local r, g, b = 0, 0, 0

    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    if i == 0 then
        r, g, b = v, t, p
    elseif i == 1 then
        r, g, b = q, v, p
    elseif i == 2 then
        r, g, b = p, v, t
    elseif i == 3 then
        r, g, b = p, q, v
    elseif i == 4 then
        r, g, b = t, p, v
    else
        r, g, b = v, p, q
    end

    return {
        r = math.floor(r * 255 + 0.5),
        g = math.floor(g * 255 + 0.5),
        b = math.floor(b * 255 + 0.5)
    }
end


-- Converts RGB to Hex
---@param rgb RGB
---@return string
function M.rgbToHex(rgb)
    return string.format("#%02x%02x%02x", rgb.r, rgb.g, rgb.b)
end


-- Takes an HSL vector and adds it to a color
-- ---@param hex string
---@param vector HSL
---@return string
function M.hslTransfer(hex, vector)
    local hsl = M.rgbToHsl(M.hexToRgb(hex))
    local rgb = M.hslToRgb({
        h = hsl.h + vector.h,
        s = hsl.s + vector.s,
        l = hsl.l + vector.l,
    })

    return M.rgbToHex(rgb)
end


-- Calculate the vector between two colors
---@param source string
---@param target string
---@return HSL
function M.hslVector(source, target)
    local source_hsl = M.rgbToHsl(M.hexToRgb(source))
    local target_hsl = M.rgbToHsl(M.hexToRgb(target))

    local dh = target_hsl.h - source_hsl.h
    local ds = target_hsl.s - source_hsl.s
    local dl = target_hsl.l - source_hsl.l

    return { h = dh, s = ds, l = dl }
end


function M.pctOut(source, target)
    local source_rgb = M.hexToRgb(source)
    local target_rgb = M.hexToRgb(target)
    if source_rgb.r == nil or target_rgb.r == nil then
        vim.print(source, target)
    end
    return (source_rgb.r - target_rgb.r) ^ 2 + (source_rgb.g - target_rgb.g) ^ 2 + (source_rgb.b - target_rgb.b) ^ 2
end


-- Generate a palette based on some base colors
---@param skeleton Swatch.Skeleton
---@return RosePine.Variant
function M.generatePalette(skeleton)
    local palette = {
        dawn = {
            foam = skeleton.paint.foam,
            gold = skeleton.paint.gold,
            iris = skeleton.paint.iris,
            love = skeleton.paint.love,
            pine = skeleton.paint.pine,
            rose = skeleton.paint.rose,
            tree = skeleton.paint.tree,

            base = skeleton.dawn.base,
            text = skeleton.dawn.text,
            none = "NONE",

            inv = skeleton.moon.base,
        },
        moon = {
            base = skeleton.moon.base,
            text = skeleton.moon.text,
            none = "NONE",

            inv = skeleton.dawn.base,
        },
        main = {
            base = skeleton.main.base,
            text = skeleton.main.text,
            none = "NONE",

            inv = skeleton.dawn.base,
        },
    }

    for k, v in pairs(M.vectors.dawn.to) do
        for c, hsl in pairs(v) do
            palette[k][c] = M.hslTransfer(palette.dawn[c], hsl)
        end
    end

    for k, v in pairs(palette) do
        for c, hsl in pairs(M.vectors[k].base) do
            palette[k][c] = M.hslTransfer(v.base, hsl)
        end
        for c, hsl in pairs(M.vectors[k].text) do
            palette[k][c] = M.hslTransfer(v.text, hsl)
        end
    end

    return palette
end

---@type Swatch.Vector
M.vectors = {
    dawn = {
        base = {
            _nc = {
                h = -0.54298642533943,
                l = -0.78431372549019,
                s = 1.6548387096774
            },
            highlight_high = {
                h = 282.69230769231,
                l = -17.254901960784,
                s = -3.2582524271845
            },
            highlight_low = {
                h = -7.3076923076923,
                l = -2.3529411764706,
                s = -0.28196721311474
            },
            highlight_med = {
                h = -22.307692307692,
                l = -10.588235294118,
                s = -2.5094170403587
            },
            overlay = {
                h = -4.0723981900453,
                l = -3.1372549019608,
                s = 1.8247933884298
            },
            surface = {
                h = 2.6923076923076,
                l = 1.9607843137255,
                s = -0.49411764705881
            }
        },
        text = {
            muted = {
                h = 8.974358974359,
                l = 17.254901960784,
                s = -21.322314049587
            },
            subtle = {
                h = 0.30769230769235,
                l = 10.196078431373,
                s = -11.823241693372
            }
        },
        to = {
            main = {
                foam = {
                    h = -0.041095890410929,
                    l = 22.352941176471,
                    s = -18.134171907757
                },
                gold = {
                    h = 0.34524530587521,
                    l = 4.7058823529412,
                    s = -26.151761517615
                },
                iris = {
                    h = -0.89760638297872,
                    l = 24.313725490196,
                    s = -0.10502318194625
                },
                love = {
                    h = 0.10155316606932,
                    l = 21.56862745098,
                    s = 7.7659574468085
                },
                pine = {
                    h = 0.091185410334361,
                    l = 4.7058823529412,
                    s = -3.7313831206961
                },
                rose = {
                    h = -0.24764962164638,
                    l = 7.843137254902,
                    s = -20.544285007422
                },
                tree = {
                    h = -0.12084172511982,
                    l = 4.7058823529412,
                    s = -3.4704246956188
                }
            },
            moon = {
                foam = {
                    h = -0.041095890410929,
                    l = 22.352941176471,
                    s = -18.134171907757
                },
                gold = {
                    h = 0.34524530587521,
                    l = 4.7058823529412,
                    s = -26.151761517615
                },
                iris = {
                    h = -0.89760638297872,
                    l = 24.313725490196,
                    s = -0.10502318194625
                },
                love = {
                    h = 0.10155316606932,
                    l = 21.56862745098,
                    s = 7.7659574468085
                },
                pine = {
                    h = 0.22556390977445,
                    l = 17.647058823529,
                    s = -4.6929215822346
                },
                rose = {
                    h = -0.52795451468796,
                    l = 7.4509803921569,
                    s = -5.9252633671238
                },
                tree = {
                    h = -0.45378151260505,
                    l = 17.647058823529,
                    s = -4.775828460039
                }
            }
        }
    },
    main = {
        base = {
            _nc = {
                h = 1.6783216783217,
                l = -1.9607843137255,
                s = -0.62724014336917
            },
            highlight_high = {
                h = -1.7307692307693,
                l = 26.274509803922,
                s = -12.810140237325
            },
            highlight_low = {
                h = -4.9450549450549,
                l = 3.921568627451,
                s = -5.6763285024155
            },
            highlight_med = {
                h = -0.6593406593407,
                l = 18.039215686275,
                s = -10.50135501355
            },
            overlay = {
                h = -1.4046822742475,
                l = 8.6274509803922,
                s = 3.544061302682
            },
            surface = {
                h = -2.1719457013575,
                l = 3.921568627451,
                s = 0.84541062801932
            }
        },
        text = {
            muted = {
                h = 3.1168831168831,
                l = -43.137254901961,
                s = 11.879128945437
            },
            subtle = {
                h = 2.5454545454545,
                l = -29.019607843137,
                s = 8.6306653809064
            }
        }
    },
    moon = {
        base = {
            _nc = {
                h = 0.60150375939853,
                l = -2.3529411764706,
                s = 0.69444444444444
            },
            highlight_high = {
                h = 2.8571428571429,
                l = 21.960784313725,
                s = -13.434343434343
            },
            highlight_low = {
                h = -0.25974025974025,
                l = 3.1372549019608,
                s = -3.4050179211469
            },
            highlight_med = {
                h = 1.4857142857143,
                l = 14.117647058824,
                s = -11.111111111111
            },
            overlay = {
                h = 2.5615763546798,
                l = 10.980392156863,
                s = -3.5230352303523
            },
            surface = {
                h = 1.7857142857143,
                l = 3.5294117647059,
                s = -0.79365079365079
            }
        },
        text = {
            muted = {
                h = 3.1168831168831,
                l = -43.137254901961,
                s = 11.879128945437
            },
            subtle = {
                h = 2.5454545454545,
                l = -29.019607843137,
                s = 8.6306653809064
            }
        }
    }
}


return M
