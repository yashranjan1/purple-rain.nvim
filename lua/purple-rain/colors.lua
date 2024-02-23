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
  Orange = hsl(35, 100, 64),
  Turquoise = hsl(180, 65, 81),
  Lavender = hsl(240, 67, 94),
  Peach = hsl(28, 100, 86),
  Mint = hsl(120, 100, 80),
  Coral = hsl(0, 79, 72),
  Lilac = hsl(300, 26, 71),
  Salmon = hsl(17, 100, 74),
  SkyBlue = hsl(197, 71, 73),
  Rose = hsl(6, 100, 94),

  -- bg = hsl(253, 85, 5),
  -- bg_highlight = hsl(253, 85, 15),
  -- fg = hsl(229, 73, 70),
}
---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require("solarized-osaka.config")

  -- local style = config.is_day() and config.options.light_style or config.options.style
  local style = "default"
  local palette = M[style] or {}
  if type(palette) == "function" then
    palette = palette()
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

  util.bg = colors.bg
  util.day_brightness = config.options.day_brightness

  colors.black = util.darken(colors.bg, 0.8, "#000000")
  colors.border = colors.black

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.base04
  colors.bg_statusline = colors.base03

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
    or config.options.styles.sidebars == "dark" and colors.base04
    or colors.bg

  colors.bg_float = config.options.styles.floats == "transparent" and colors.none
    or config.options.styles.floats == "dark" and colors.base04
    or colors.bg

  -- colors.fg_float = config.options.styles.floats == "dark" and colors.base01 or colors.fg
  colors.fg_float = colors.fg

  colors.error = colors.red500
  colors.warning = colors.yellow500
  colors.info = colors.blue500
  colors.hint = colors.cyan500

  config.options.on_colors(colors)
  if opts.transform and config.is_day() then
    util.invert_colors(colors)
  end

  return colors
end

return M
