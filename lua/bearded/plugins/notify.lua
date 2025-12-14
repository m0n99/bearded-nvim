local M = {}

function M.highlights(ui, colors, levels)
  local bg = ui.uibackgroundalt or ui.uibackground
  local fg = ui.default or ui.defaultMain or "#ffffff"
  local border = ui.border or ui.primaryalt or ui.defaultalt
  return {
    NotifyINFOBorder = { fg = border, bg = bg },
    NotifyWARNBorder = { fg = border, bg = bg },
    NotifyERRORBorder = { fg = border, bg = bg },
    NotifyDEBUGBorder = { fg = border, bg = bg },
    NotifyTRACEBorder = { fg = border, bg = bg },
    NotifyINFOBody = { fg = fg, bg = bg },
    NotifyWARNBody = { fg = fg, bg = bg },
    NotifyERRORBody = { fg = fg, bg = bg },
    NotifyDEBUGBody = { fg = fg, bg = bg },
    NotifyTRACEBody = { fg = fg, bg = bg },
    NotifyINFOIcon = { fg = levels.info or colors.blue },
    NotifyWARNIcon = { fg = levels.warning or colors.orange },
    NotifyERRORIcon = { fg = levels.danger or colors.red },
    NotifyDEBUGIcon = { fg = ui.defaultalt or "#777777" },
    NotifyTRACEIcon = { fg = colors.purple or colors.pink },
    NotifyINFOTitle = { fg = levels.info or colors.blue },
    NotifyWARNTitle = { fg = levels.warning or colors.orange },
    NotifyERRORTitle = { fg = levels.danger or colors.red },
    NotifyDEBUGTitle = { fg = ui.defaultalt or "#777777" },
    NotifyTRACETitle = { fg = colors.purple or colors.pink },
  }
end

return M
