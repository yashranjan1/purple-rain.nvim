local colors = require("purple-rain.colors").setup({ transform = true })

local purple_rain = {}

purple_rain.normal = {
  left = { { colors.black, colors.blue }, { colors.blue, colors.fg_gutter } },
  middle = { { colors.fg, colors.bg_statusline } },
  right = { { colors.black, colors.blue }, { colors.blue, colors.fg_gutter } },
  error = { { colors.black, colors.error } },
  warning = { { colors.black, colors.warning } },
}

purple_rain.insert = {
  left = { { colors.black, colors.green }, { colors.blue, colors.bg } },
}

purple_rain.visual = {
  left = { { colors.black, colors.magenta }, { colors.blue, colors.bg } },
}

purple_rain.replace = {
  left = { { colors.black, colors.red }, { colors.blue, colors.bg } },
}

purple_rain.inactive = {
  left = { { colors.blue, colors.bg_statusline }, { colors.dark3, colors.bg } },
  middle = { { colors.fg_gutter, colors.bg_statusline } },
  right = { { colors.fg_gutter, colors.bg_statusline }, { colors.dark3, colors.bg } },
}

purple_rain.tabline = {
  left = { { colors.dark3, colors.bg_highlight }, { colors.dark3, colors.bg } },
  middle = { { colors.fg_gutter, colors.bg_statusline } },
  right = { { colors.fg_gutter, colors.bg_statusline }, { colors.dark3, colors.bg } },
  tabsel = { { colors.blue, colors.fg_gutter }, { colors.dark3, colors.bg } },
}

return purple_rain
