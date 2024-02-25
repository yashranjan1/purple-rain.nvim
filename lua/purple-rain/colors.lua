local util = require("purple-rain.util")
local hslutil = require("purple-rain.hsl")
local hsl = hslutil.hslToHex

local M = {}
---@class Palette
M.default = {
    none = "NONE",

    --pink colors
    Pink50 = hsl(346, 100, 95),
    Pink100 = hsl(346, 100, 91),
    Pink200 = hsl(346, 100, 83),
    Pink300 = hsl(346, 100, 75),
    Pink400 = hsl(346, 100, 69),

    --blue colors
    Blue50 = hsl(196, 26, 80),
    Blue100 = hsl(196, 26, 75),
    Blue200 = hsl(196, 38, 65),
    Blue300 = hsl(196, 40, 55),
    Blue400 = hsl(196, 55, 45),

    --green colors
    Green50 = hsl(90, 72, 89),
    Green100 = hsl(90, 67, 80),
    Green200 = hsl(90, 67, 69),
    Green300 = hsl(95, 65, 59),
    Green400 = hsl(113, 60, 47),

    --yellow colors
    Yellow50 = hsl(54, 100, 90),
    Yellow100 = hsl(54, 100, 85),
    Yellow200 = hsl(59, 89, 80),
    Yellow300 = hsl(59, 85, 58),
    Yellow400 = hsl(60, 79, 49),

    --purple color
    Purple50 = hsl(261, 42, 92),
    Purple100 = hsl(261, 45, 85),
    Purple200 = hsl(261, 45, 72),
    Purple300 = hsl(261, 60, 70),
    Purple400 = hsl(262, 68, 64),

    --orange colors
    Orange50 = hsl(35, 100, 85),
    Orange100 = hsl(35, 100, 75),
    Orange200 = hsl(35, 100, 64),
    Orange300 = hsl(35, 92, 57),
    Orange400 = hsl(35, 92, 45),

    --turqiouse colors
    Turquoise50 = hsl(180, 65, 92),
    Turquoise100 = hsl(180, 65, 84),
    Turquoise200 = hsl(180, 82, 76),
    Turquoise300 = hsl(180, 89, 65),
    Turquoise400 = hsl(185, 100, 40),

    --lavender colors
    Lavender50 = hsl(240, 67, 94),
    Lavender100 = hsl(240, 67, 89),
    Lavender200 = hsl(240, 67, 84),
    Lavender300 = hsl(240, 50, 76),
    Lavender400 = hsl(240, 67, 76),

    --peach colors
    Peach50 = hsl(28, 100, 92),
    Peach100 = hsl(28, 100, 86),
    Peach200 = hsl(28, 90, 80),
    Peach300 = hsl(28, 90, 75),
    Peach400 = hsl(30, 100, 65),

    --mint colors
    Mint50 = hsl(120, 100, 92),
    Mint100 = hsl(120, 100, 87),
    Mint200 = hsl(120, 100, 80),
    Mint300 = hsl(125, 100, 70),
    Mint400 = hsl(130, 100, 50),

    --coral colors
    Coral50 = hsl(0, 79, 85),
    Coral100 = hsl(0, 79, 80),
    Coral200 = hsl(0, 79, 75),
    Coral300 = hsl(0, 85, 70),
    Coral400 = hsl(0, 85, 65),

    --lilac colors
    Lilac50 = hsl(300, 26, 85),
    Lilac100 = hsl(300, 26, 78),
    Lilac200 = hsl(300, 26, 71),
    Lilac300 = hsl(300, 30, 66),
    Lilac400 = hsl(300, 32, 60),

    --salman colors
    Salmon50 = hsl(17, 100, 85),
    Salmon100 = hsl(17, 100, 79),
    Salmon200 = hsl(17, 100, 73),
    Salmon300 = hsl(20, 100, 68),
    Salmon400 = hsl(20, 90, 63),

    --skyblue colors
    SkyBlue50 = hsl(197, 71, 85),
    SkyBlue100 = hsl(197, 75, 77),
    SkyBlue200 = hsl(197, 75, 70),
    SkyBlue300 = hsl(197, 75, 65),
    SkyBlue400 = hsl(200, 78, 58),

    --violet colors
    Violet50 = hsl(253, 90, 35),
    Violet100 = hsl(253, 90, 26),
    Violet200 = hsl(253, 90, 20),
    Violet300 = hsl(253, 85, 15),
    Violet400 = hsl(253, 85, 5),

    --Terminal colors, these are written in hex for ease
    terminalForeground = "#c0caf5",
    terminalBackground = "#070219",

    terminalBlack = "#626483",
    terminalBlackBright = "#626483",

    terminalRed = "#fb007a",
    terminalRedBright = "#fb007a",

    terminalGreen = "#a6e22e",
    terminalGreenBright = "#a6e22e",

    terminalYellow = "#f3e430",
    terminalYellowBright = "#f3e430",

    terminalBlue = "#58AFC2",
    terminalBlueBright = "#58AFC2",

    terminalMagenta = "#583794",
    terminalMagentaBright = "#472575",

    terminalCyan = "#926BCA",
    terminalCyanBright = "#926BCA",

    terminalWhite = "#d9d9d9",
    terminalWhiteBright = "#f1f1f1",

    commentGray = hsl(148, 0, 67),
}
---@return ColorScheme
function M.setup(opts)
    opts = opts or {}
    local config = require("purple-rain.config")

    local style = "default"
    local palette = M[style] or {}
    if type(palette) == "function" then
        palette = palette()
    end

    -- Color Palette
    ---@class ColorScheme: Palette
    local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

    util.bg = colors.Violet400
    util.day_brightness = config.options.day_brightness

    colors.black = util.darken(colors.Violet400, 0.8, "#000000")
    colors.border = colors.black

    config.options.on_colors(colors)
    if opts.transform and config.is_day() then
        util.invert_colors(colors)
    end

    return colors
end

return M
