local M = {}

local function normalize_color(color)
  if type(color) ~= "string" then
    return color
  end
  if color == "NONE" then
    return color
  end
  -- Trim alpha channel if present (#RRGGBBAA) because Neovim only accepts #RRGGBB.
  if color:match "^#%x%x%x%x%x%x%x%x$" then
    return color:sub(1, 7)
  end
  return color
end

local function set(name, values)
  if values.fg then
    values.fg = normalize_color(values.fg)
  end
  if values.bg then
    values.bg = normalize_color(values.bg)
  end
  if values.sp then
    values.sp = normalize_color(values.sp)
  end
  vim.api.nvim_set_hl(0, name, values)
end

local function underline(color)
  return { sp = color, underline = true }
end

local function link(from, to)
  vim.api.nvim_set_hl(0, from, { link = to, default = false })
end

local function syntax_groups(colors, opts)
  local italic = opts.italic ~= false
  local bold = opts.bold ~= false

  return {
    Comment = { fg = colors.dim, italic = italic },
    Constant = { fg = colors.orange },
    String = { fg = colors.green },
    Character = { fg = colors.green },
    Number = { fg = colors.orange },
    Boolean = { fg = colors.orange },
    Float = { fg = colors.orange },
    Identifier = { fg = colors.fg },
    Function = { fg = colors.blue },
    Statement = { fg = colors.yellow },
    Conditional = { fg = colors.yellow },
    Repeat = { fg = colors.yellow },
    Label = { fg = colors.teal },
    Operator = { fg = colors.yellow },
    Keyword = { fg = colors.yellow, italic = italic },
    Exception = { fg = colors.red, italic = italic },
    PreProc = { fg = colors.teal },
    Include = { fg = colors.teal },
    Define = { fg = colors.teal },
    Macro = { fg = colors.teal },
    Type = { fg = colors.purple },
    StorageClass = { fg = colors.purple },
    Structure = { fg = colors.purple },
    Typedef = { fg = colors.purple },
    Special = { fg = colors.pink },
    Delimiter = { fg = colors.dim },
    SpecialComment = { fg = colors.dim, italic = italic },
    Debug = { fg = colors.red },
    ["@comment"] = { fg = colors.dim, italic = italic },
    ["@variable"] = { fg = colors.fg },
    ["@variable.member"] = { fg = colors.fg },
    ["@variable.parameter"] = { fg = colors.pink },
    ["@variable.builtin"] = { fg = colors.orange, italic = italic },
    ["@field"] = { fg = colors.pink },
    ["@property"] = { fg = colors.orange },
    ["@parameter"] = { fg = colors.pink },
    ["@constant"] = { fg = colors.orange },
    ["@constant.builtin"] = { fg = colors.orange },
    ["@number"] = { fg = colors.orange },
    ["@boolean"] = { fg = colors.orange },
    ["@string"] = { fg = colors.green },
    ["@string.escape"] = { fg = colors.orange },
    ["@string.special"] = { fg = colors.teal },
    ["@character"] = { fg = colors.green },
    ["@constructor"] = { fg = colors.purple },
    ["@type"] = { fg = colors.purple },
    ["@type.builtin"] = { fg = colors.purple },
    ["@type.definition"] = { fg = colors.purple },
    ["@keyword"] = { fg = colors.yellow, italic = italic },
    ["@keyword.function"] = { fg = colors.yellow, italic = italic },
    ["@keyword.return"] = { fg = colors.yellow, italic = italic },
    ["@keyword.operator"] = { fg = colors.yellow },
    ["@keyword.import"] = { fg = colors.yellow, italic = italic },
    ["@function"] = { fg = colors.blue },
    ["@function.builtin"] = { fg = colors.blue },
    ["@function.call"] = { fg = colors.blue },
    ["@method"] = { fg = colors.blue },
    ["@method.call"] = { fg = colors.blue },
    ["@namespace"] = { fg = colors.teal },
    ["@module"] = { fg = colors.teal },
    ["@punctuation"] = { fg = colors.dim },
    ["@punctuation.bracket"] = { fg = colors.dim },
    ["@punctuation.delimiter"] = { fg = colors.dim },
    ["@tag"] = { fg = colors.purple },
    ["@tag.attribute"] = { fg = colors.orange, italic = italic },
    ["@tag.delimiter"] = { fg = colors.dim },
    ["@markup.heading"] = { fg = colors.yellow, bold = bold },
    ["@markup.italic"] = { fg = colors.orange, italic = true },
    ["@markup.bold"] = { fg = colors.salmon, bold = true },
    ["@markup.quote"] = { fg = colors.pink, italic = italic },
    ["@markup.link"] = { fg = colors.blue, underline = true },
    ["@markup.list"] = { fg = colors.blue },
    ["@markup.raw"] = { fg = colors.purple },
  }
end

local function diagnostics(levels, colors, ui)
  return {
    DiagnosticError = { fg = levels.danger or colors.red },
    DiagnosticWarn = { fg = levels.warning or colors.orange },
    DiagnosticInfo = { fg = levels.info or colors.blue },
    DiagnosticHint = { fg = colors.purple or colors.teal },
    DiagnosticUnderlineError = underline(levels.danger or colors.red),
    DiagnosticUnderlineWarn = underline(levels.warning or colors.orange),
    DiagnosticUnderlineInfo = underline(levels.info or colors.blue),
    DiagnosticUnderlineHint = underline(colors.purple or colors.teal),
    LspInlayHint = {
      fg = ui.defaultalt or "#5a5a5a",
      bg = ui.uibackgroundmid or "NONE",
      italic = true,
    },
  }
end

local function ui_groups(ui, colors, levels, opts)
  local bg = opts.transparent and "NONE" or ui.uibackground or ui.uibackgroundmid or "NONE"
  local bg_mid = opts.transparent and "NONE" or ui.uibackgroundmid or bg
  local bg_alt = opts.transparent and "NONE" or ui.uibackgroundalt or bg
  local fg = ui.default or ui.defaultMain or "#ffffff"
  local dim = ui.defaultalt or "#666666"
  local primary = ui.primary or colors.blue or fg
  local accent = colors.purple or colors.blue or primary
  local italic = opts.italic ~= false
  local bold = opts.bold ~= false

  local groups = {
    Normal = { fg = fg, bg = bg },
    NormalNC = { fg = fg, bg = bg },
    NormalFloat = { fg = fg, bg = bg_alt },
    FloatBorder = { fg = dim, bg = bg_alt },
    FloatTitle = { fg = primary, bg = bg_alt, bold = bold },
    Comment = { fg = dim, italic = italic },
    CursorLine = { bg = bg_mid },
    CursorColumn = { bg = bg_mid },
    CursorLineNr = { fg = primary, bg = bg_mid, bold = bold },
    LineNr = { fg = dim, bg = bg_mid },
    Visual = { bg = ui.primaryalt or "#444444" },
    Search = { fg = bg, bg = levels.warning or colors.orange },
    IncSearch = { fg = bg, bg = levels.info or colors.blue, bold = bold },
    MatchParen = { fg = accent, bold = bold },
    Pmenu = { fg = fg, bg = ui.primaryalt or bg_alt },
    PmenuSel = { fg = bg, bg = primary, bold = bold },
    PmenuBorder = { fg = ui.border or ui.primaryalt or dim, bg = ui.primaryalt or bg_alt },
    StatusLine = { fg = fg, bg = ui.uibackgroundalt or bg_alt },
    StatusLineNC = { fg = dim, bg = ui.uibackgroundalt or bg_alt },
    VertSplit = { fg = ui.border or dim, bg = bg },
    WinSeparator = { fg = ui.border or dim, bg = bg },
    SignColumn = { fg = dim, bg = bg_mid },
    ColorColumn = { bg = bg_mid },
    Folded = { fg = dim, bg = bg_mid },
    FoldColumn = { fg = dim, bg = bg_mid },
    Title = { fg = primary, bold = bold },
    Directory = { fg = primary },
    Error = { fg = levels.danger or colors.red },
    WarningMsg = { fg = levels.warning or colors.orange },
    MoreMsg = { fg = primary },
    Question = { fg = primary },
    QuickFixLine = { bg = bg_mid },
    Cursor = { fg = bg, bg = levels.info or colors.blue },
    VisualNOS = { bg = ui.primaryalt or "#444444" },
    Whitespace = { fg = dim },
    NonText = { fg = dim },
    SpecialKey = { fg = dim },
    TabLine = { fg = dim, bg = bg_alt },
    TabLineSel = { fg = fg, bg = bg_mid, bold = bold },
    TabLineFill = { fg = dim, bg = bg_alt },
    DiffAdd = { bg = "#2cfc82", fg = levels.success or colors.green },
    DiffDelete = { bg = "#f44a24", fg = levels.danger or colors.red },
    DiffChange = { bg = "#69c3ff", fg = colors.blue },
    DiffText = { bg = "#69c3ff", fg = colors.blue, bold = bold },
    StatusLineTerm = { fg = fg, bg = ui.uibackgroundalt or bg_alt },
    StatusLineTermNC = { fg = dim, bg = ui.uibackgroundalt or bg_alt },
  }

  if opts.dim_inactive then
    groups.NormalNC = { fg = dim, bg = bg }
  end

  return groups
end

local function merge(a, b)
  for k, v in pairs(b) do
    a[k] = v
  end
end

local function plugin_groups(colors, ui, levels)
  local primary = ui.primary or colors.blue or colors.teal
  local neo_tree = require("bearded.plugins.neotree").highlights(ui, colors)
  local treesitter_context = require("bearded.plugins.treesitter_context").highlights(ui, colors)
  local noice = require("bearded.plugins.noice").highlights(ui, colors)
  local notify = require("bearded.plugins.notify").highlights(ui, colors, levels)

  local g = {
    -- LSP
    LspReferenceText = { bg = ui.primaryalt or ui.uibackgroundmid },
    LspReferenceRead = { bg = ui.primaryalt or ui.uibackgroundmid },
    LspReferenceWrite = { bg = ui.primaryalt or ui.uibackgroundmid },

    -- Telescope
    TelescopeNormal = { fg = ui.default or colors.blue, bg = ui.primaryalt or ui.uibackgroundmid },
    TelescopeBorder = {
      fg = ui.border or ui.primaryalt or ui.defaultalt,
      bg = ui.primaryalt or ui.uibackgroundmid,
    },
    TelescopeTitle = { fg = primary, bold = true },
    TelescopeSelection = { fg = ui.default or colors.blue, bg = ui.uibackgroundmid },
    TelescopeSelectionCaret = { fg = primary },

    -- GitSigns
    GitSignsAdd = { fg = levels.success or colors.green },
    GitSignsChange = { fg = colors.blue },
    GitSignsDelete = { fg = levels.danger or colors.red },

    -- WhichKey
    WhichKey = { fg = primary },
    WhichKeyGroup = { fg = colors.purple },
    WhichKeyDesc = { fg = ui.default or colors.blue },
    WhichKeySeparator = { fg = ui.defaultalt or "#5a5a5a" },

    -- Nvim-cmp
    CmpItemAbbr = { fg = ui.default or colors.blue },
    CmpItemAbbrDeprecated = { fg = ui.defaultalt or "#777777", strikethrough = true },
    CmpItemAbbrMatch = { fg = primary },
    CmpItemAbbrMatchFuzzy = { fg = primary },
    CmpItemKind = { fg = colors.teal },
    CmpItemMenu = { fg = ui.defaultalt or "#777777" },
    CmpItemKindFunction = { fg = colors.blue },
    CmpItemKindMethod = { fg = colors.blue },
    CmpItemKindVariable = { fg = colors.orange },
    CmpItemKindField = { fg = colors.orange },
    CmpItemKindProperty = { fg = colors.orange },
    CmpItemKindClass = { fg = colors.purple },
    CmpItemKindInterface = { fg = colors.purple },
    CmpItemKindModule = { fg = colors.teal },
  }

  merge(g, neo_tree)
  merge(g, treesitter_context)
  merge(g, noice)
  merge(g, notify)

  return g
end

local function terminal_colors(ui, colors, levels)
  vim.g.terminal_color_0 = ui.uibackground or "#000000"
  vim.g.terminal_color_8 = ui.defaultalt or "#444444"
  vim.g.terminal_color_1 = colors.red or "#ff0000"
  vim.g.terminal_color_9 = levels.danger or colors.red or "#ff0000"
  vim.g.terminal_color_2 = colors.green or "#00ff00"
  vim.g.terminal_color_10 = levels.success or colors.green or "#00ff00"
  vim.g.terminal_color_3 = colors.yellow or "#ffff00"
  vim.g.terminal_color_11 = levels.warning or colors.yellow or "#ffff00"
  vim.g.terminal_color_4 = colors.blue or "#0000ff"
  vim.g.terminal_color_12 = levels.info or colors.blue or "#0000ff"
  vim.g.terminal_color_5 = colors.pink or colors.purple or "#ff00ff"
  vim.g.terminal_color_13 = colors.salmon or colors.purple or "#ff00ff"
  vim.g.terminal_color_6 = colors.teal or "#00ffff"
  vim.g.terminal_color_14 = colors.teal or colors.green or "#00ffff"
  vim.g.terminal_color_7 = ui.default or "#ffffff"
  vim.g.terminal_color_15 = ui.defaultMain or ui.default or "#ffffff"
end

function M.apply(palette, opts)
  opts = opts or {}
  local ui = palette.ui or {}
  local colors = palette.colors or {}
  local levels = palette.levels or {}

  local base = ui_groups(ui, colors, levels, opts)
  local syntax = syntax_groups({
    fg = ui.default or ui.defaultMain or "#ffffff",
    dim = ui.defaultalt or "#666666",
    blue = colors.blue or "#61afef",
    green = colors.green or "#98c379",
    yellow = colors.yellow or "#e5c07b",
    orange = colors.orange or "#d19a66",
    pink = colors.pink or colors.salmon or "#c678dd",
    purple = colors.purple or "#c678dd",
    red = colors.red or "#e06c75",
    salmon = colors.salmon or colors.pink or "#ff8f88",
    teal = colors.turquoize or colors.turqoise or "#56b6c2",
  }, opts)

  local diag = diagnostics(levels, colors, ui)
  local plugins = plugin_groups(colors, ui, levels)

  for group, val in pairs(base) do
    set(group, val)
  end
  for group, val in pairs(syntax) do
    set(group, val)
  end
  for group, val in pairs(diag) do
    set(group, val)
  end
  for group, val in pairs(plugins) do
    set(group, val)
  end

  link("NormalSB", "Normal")
  link("NormalFloat", "Normal")

  if opts.terminal_colors ~= false then
    terminal_colors(ui, colors, levels)
  end

  if type(opts.on_highlights) == "function" then
    opts.on_highlights(function(name, values)
      set(name, values)
    end, palette, opts)
  end
end

return M
