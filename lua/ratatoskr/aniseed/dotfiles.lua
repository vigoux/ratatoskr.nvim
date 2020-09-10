local _0_0 = nil
do
  local name_0_ = "ratatoskr.aniseed.dotfiles"
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
  _0_0["aniseed/local-fns"] = {require = {compile = "ratatoskr.aniseed.compile", nvim = "ratatoskr.aniseed.nvim"}}
  return {require("ratatoskr.aniseed.compile"), require("ratatoskr.aniseed.nvim")}
end
local _2_ = _1_(...)
local compile = _2_[1]
local nvim = _2_[2]
do local _ = ({nil, _0_0, {{}, nil}})[2] end
local config_dir = nil
do
  local v_0_ = nvim.fn.stdpath("config")
  _0_0["aniseed/locals"]["config-dir"] = v_0_
  config_dir = v_0_
end
compile.glob("**/*.fnl", (config_dir .. "/fnl"), (config_dir .. "/lua"))
return require("dotfiles.init")
