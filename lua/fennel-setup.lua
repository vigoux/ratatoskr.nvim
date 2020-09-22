
-- Setup the fennel compiler and so on
local fennel = require("fennel")
fennel.path = package.path:gsub('/lua/', '/fnl/'):gsub('%.lua', '.fnl')
table.insert(package.loaders or package.searchers, fennel.searcher)
