local generated = require "bearded.palettes.generated"

local M = {}

function M.all()
  return generated
end

function M.names()
  local names = {}
  for slug, _ in pairs(generated) do
    table.insert(names, slug)
  end
  table.sort(names)
  return names
end

function M.get(slug)
  return generated[slug]
end

return M
