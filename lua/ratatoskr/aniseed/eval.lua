local _0_0 = nil
do
  local name_0_ = "ratatoskr.aniseed.eval"
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
  _0_0["aniseed/local-fns"] = {require = {compile = "ratatoskr.aniseed.compile", fennel = "ratatoskr.aniseed.fennel", fs = "ratatoskr.aniseed.fs", nvim = "ratatoskr.aniseed.nvim"}}
  return {require("ratatoskr.aniseed.compile"), require("ratatoskr.aniseed.fennel"), require("ratatoskr.aniseed.fs"), require("ratatoskr.aniseed.nvim")}
end
local _2_ = _1_(...)
local compile = _2_[1]
local fennel = _2_[2]
local fs = _2_[3]
local nvim = _2_[4]
do local _ = ({nil, _0_0, {{}, nil}})[2] end
local str = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function str0(code, opts)
      local function _3_()
        return fennel.eval(compile["macros-prefix"](code), opts)
      end
      return xpcall(_3_, fennel.traceback)
    end
    v_0_0 = str0
    _0_0["str"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["str"] = v_0_
  str = v_0_
end
return nil
