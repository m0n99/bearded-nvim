local M = {}

function M.highlights(ui, colors)
  local bg = ui.uibackground or "#1c1c1c"
  local fg = ui.default or "#ffffff"
  local dim = ui.defaultalt or "#777777"
  local accent = ui.primary or colors.blue or fg

  return {
    NeoTreeNormal = { fg = fg, bg = bg },
    NeoTreeNormalNC = { fg = fg, bg = bg },
    NeoTreeEndOfBuffer = { fg = bg, bg = bg },
    NeoTreeRootName = { fg = accent, bold = true },
    NeoTreeDirectoryName = { fg = fg },
    NeoTreeDirectoryIcon = { fg = accent },
    NeoTreeSymbolicLinkTarget = { fg = colors.purple or accent },
    NeoTreeFileName = { fg = fg },
    NeoTreeFileNameOpened = { fg = accent },
    NeoTreeIndentMarker = { fg = dim },
    NeoTreeGitAdded = { fg = colors.green },
    NeoTreeGitModified = { fg = colors.blue },
    NeoTreeGitDeleted = { fg = colors.red },
    NeoTreeGitUntracked = { fg = colors.orange },
    NeoTreeGitIgnored = { fg = dim },
  }
end

return M
