local M = {}

function M.common(palette)
  local ui = palette.ui or {}
  local colors = palette.colors or {}
  local bg = ui.uibackgroundalt or ui.uibackground or "#1c1c1c"
  local fg = ui.default or ui.defaultMain or "#ffffff"
  local accent = ui.primary or colors.blue or colors.purple or fg
  local dim = ui.defaultalt or "#666666"

  return {
    bg = bg,
    fg = fg,
    accent = accent,
    dim = dim,
    section_bg = ui.primaryalt or bg,
    warning = palette.levels and palette.levels.warning or colors.yellow,
    error = palette.levels and palette.levels.danger or colors.red,
    info = palette.levels and palette.levels.info or colors.blue,
  }
end

function M.colors(palette)
  local c = M.common(palette)
  return {
    bg = c.bg,
    fg = c.fg,
    accent = c.accent,
    dim = c.dim,
    section_bg = c.section_bg,
    warn = c.warning,
    error = c.error,
    info = c.info,
  }
end

return M
