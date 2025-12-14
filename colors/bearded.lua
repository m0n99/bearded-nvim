local ok, bearded = pcall(require, "bearded")
if not ok then
  return
end

-- Allow overriding flavor via a global before calling :colorscheme bearded
local flavor = vim.g.bearded_flavor or bearded.opts.flavor or "arc"
bearded.load(flavor)
