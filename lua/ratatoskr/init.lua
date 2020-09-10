local _0_0 = nil
do
  local name_0_ = "ratatoskr.init"
  local loaded_0_ = package.loaded[name_0_]
  local module_0_ = nil
  if ("table" == type(loaded_0_)) then
    module_0_ = loaded_0_
  else
    module_0_ = {}
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = (module_0_["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = (module_0_["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local function _1_(...)
  _0_0["aniseed/local-fns"] = {["require-macros"] = {["fnl.ratatoskr.macros"] = true}, require = {a = "ratatoskr.aniseed.core", p = "vim.treesitter", q = "vim.treesitter.query", v = "ratatoskr.aniseed.view"}}
  return {require("ratatoskr.aniseed.core"), require("vim.treesitter"), require("vim.treesitter.query"), require("ratatoskr.aniseed.view")}
end
local _2_ = _1_(...)
local a = _2_[1]
local p = _2_[2]
local q = _2_[3]
local v = _2_[4]
do local _ = ({nil, _0_0, {{nil}, nil}})[2] end
local add = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function add0(a0, b)
      return (a0 + b)
    end
    v_0_0 = add0
    _0_0["add"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["add"] = v_0_
  add = v_0_
end
local captures = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function captures0(root, buf, start, _end, lang, query)
      return q.parse_query(lang, query):iter_captures(root, buf, start, _end)
    end
    v_0_0 = captures0
    _0_0["captures"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["captures"] = v_0_
  captures = v_0_
end
local iter_nodes = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function iter_nodes0(buf, lang)
      local parser = p.get_parser(buf)
      local root = parser:parse():root()
      for capture, node in captures(root, buf, root:start(), root:end_(), lang, "(identifier)") do
        print(node:type())
      end
      return nil
    end
    v_0_0 = iter_nodes0
    _0_0["iter-nodes"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["iter-nodes"] = v_0_
  iter_nodes = v_0_
end
return nil