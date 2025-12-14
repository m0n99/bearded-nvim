local palettes = require "bearded.palettes"
local highlights = require "bearded.highlights"

local defaults = {
  flavor = "arc",
  transparent = false,
  bold = true,
  italic = true,
  terminal_colors = true,
  on_highlights = nil,
}

local M = {
  opts = vim.deepcopy(defaults),
}

vim.api.nvim_create_user_command("BeardedReload", function(cmd)
  local slug = cmd.args ~= "" and cmd.args or M.opts.flavor
  M.load(slug)
end, {
  nargs = "?",
  complete = function()
    return palettes.names()
  end,
})

local function reset()
  if vim.g.colors_name then
    vim.cmd "highlight clear"
  end
  vim.o.termguicolors = true
end

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
  M.load(M.opts.flavor)
end

function M.load(flavor)
  local palette = palettes.get(flavor)
  if not palette then
    error("Bearded theme: unknown flavor " .. tostring(flavor))
  end

  reset()
  highlights.apply(palette, M.opts)
  vim.g.colors_name = "bearded"
end

function M.available_flavors()
  return palettes.names()
end

function M.palette(flavor)
  return palettes.get(flavor or M.opts.flavor)
end

return M
