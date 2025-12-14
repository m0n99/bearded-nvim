local M = {}

function M.highlights(ui, colors)
  return {
    TreesitterContext = { bg = ui.uibackgroundmid or ui.uibackground or "NONE" },
    TreesitterContextLineNumber = { fg = ui.defaultalt or colors.blue },
  }
end

return M
