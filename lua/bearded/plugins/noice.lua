local M = {}

function M.highlights(ui, colors)
  local bg = ui.uibackgroundalt or ui.uibackground
  local fg = ui.default or ui.defaultMain or "#ffffff"
  local dim = ui.defaultalt or "#777777"
  local accent = ui.primary or colors.blue or colors.purple or fg
  return {
    NoicePopup = { bg = bg, fg = fg },
    NoicePopupBorder = { bg = bg, fg = ui.border or dim },
    NoiceCmdlinePopup = { bg = bg, fg = fg },
    NoiceCmdlinePopupBorder = { bg = bg, fg = ui.border or dim },
    NoiceCmdlineIcon = { fg = accent },
    NoiceCmdlinePrompt = { fg = accent },
    NoiceCmdline = { bg = bg, fg = fg },
    NoiceConfirm = { bg = bg, fg = fg },
    NoiceConfirmBorder = { bg = bg, fg = ui.border or dim },
    NoiceMini = { bg = bg, fg = fg },
  }
end

return M
