-- Setup the fennel compiler and so on
local fennel = require("fennel")
fennel.path = package.path:gsub('/lua/', '/fnl/'):gsub('%.lua', '.fnl')
for _,p in ipairs(vim.api.nvim_get_runtime_file('fnl/', true)) do
  fennel.path = fennel.path .. ';' .. p .. '?.fnl'
  fennel.path = fennel.path .. ';' .. p .. '?/init.fnl'
end
table.insert(package.loaders or package.searchers, fennel.searcher)


-- Used by :Fennel
function eval_fennel(str)
  local code, _ = fennel.compileString(str)
  return load(code)()
end
