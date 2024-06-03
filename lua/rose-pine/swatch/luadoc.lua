---@class RGB
---@field r integer Red
---@field g integer Green
---@field b integer Blue


---@class HSL
---@field h number Hue
---@field s number Saturation
---@field l number Luminosity


---@class Swatch.Vector.Palette
---@field love HSL Vector to transfer Dawn:Love to another palette
---@field gold HSL Vector to transfer Dawn:Gold to another palette
---@field rose HSL Vector to transfer Dawn:Rose to another palette
---@field pine HSL Vector to transfer Dawn:Pine to another palette
---@field foam HSL Vector to transfer Dawn:Foam to another palette
---@field iris HSL Vector to transfer Dawn:Iris to another palette
---@field tree HSL Vector to transfer Dawn:Tree to another palette


---@class Swatch.Vector.Base
---@field surface HSL Vector to transfer Base to Surface
---@field overlay HSL Vector to transfer Base to Overlay
---@field _nc HSL Vector to transfer Base to _nc
---@field highlight_high HSL Vector to transfer Base to hi_high
---@field highlight_med HSL Vector to transfer Base to hi_med
---@field highlight_low HSL Vector to transfer Base to hi_low


---@class Swatch.Vector.To
---@field moon Swatch.Vector.Palette
---@field main Swatch.Vector.Palette


---@class Swatch.Vector.Text
---@field muted HSL Vector to transfer Text to Muted
---@field subtle HSL Vector to transfer Text to Subtle


---@class Swatch.Palette.Dawn
---@field to Swatch.Vector.To
---@field text Swatch.Vector.Text
---@field base Swatch.Vector.Base


---@class Swatch.Palette.Main
---@field text Swatch.Vector.Text
---@field base Swatch.Vector.Base


---@class Swatch.Vector
---@field dawn Swatch.Palette.Dawn
---@field main Swatch.Palette.Main
---@field moon Swatch.Palette.Main


---@class Swatch.Skeleton
---@field paint Swatch.Skeleton.Paint
---@field dawn Swatch.Skeleton.Variant
---@field moon Swatch.Skeleton.Variant
---@field main Swatch.Skeleton.Variant


---@class Swatch.Skeleton.Paint
---@field foam string A calm cyan
---@field gold string A bright yellow
---@field iris string A muted purple
---@field love string A deep red
---@field pine string A subtle blue pine
---@field rose string A calm pink
---@field tree string A pastel green


---@class Swatch.Skeleton.Variant
---@field text string
---@field base string
