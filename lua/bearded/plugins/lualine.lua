local M = {}

function M.highlights(palette)
  local ui = palette.ui or {}
  local colors = palette.colors or {}

  local bg = ui.uibackgroundalt or ui.uibackground or "#1c1c1c"
  local fg = ui.default or ui.defaultMain or "#ffffff"
  local accent = ui.primary or colors.blue or colors.purple or fg
  local dim = ui.defaultalt or "#666666"

  return {
    normal = {
      a = { bg = accent, fg = bg, gui = "bold" },
      b = { bg = ui.primaryalt or bg, fg = accent },
      c = { bg = bg, fg = fg },
    },
    insert = {
      a = { bg = colors.green or accent, fg = bg, gui = "bold" },
      b = { bg = ui.primaryalt or bg, fg = colors.green or accent },
      c = { bg = bg, fg = fg },
    },
    visual = {
      a = { bg = colors.purple or accent, fg = bg, gui = "bold" },
      b = { bg = ui.primaryalt or bg, fg = colors.purple or accent },
      c = { bg = bg, fg = fg },
    },
    replace = {
      a = { bg = colors.red or accent, fg = bg, gui = "bold" },
      b = { bg = ui.primaryalt or bg, fg = colors.red or accent },
      c = { bg = bg, fg = fg },
    },
    command = {
      a = { bg = colors.yellow or accent, fg = bg, gui = "bold" },
      b = { bg = ui.primaryalt or bg, fg = colors.yellow or accent },
      c = { bg = bg, fg = fg },
    },
    inactive = {
      a = { bg = bg, fg = dim },
      b = { bg = bg, fg = dim },
      c = { bg = bg, fg = dim },
    },
  }
end

-- Alias for lualine.setup { options = { theme = require("bearded.plugins.lualine").theme() } }
function M.theme(palette)
  return M.highlights(palette)
end

return M
