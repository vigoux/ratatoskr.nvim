" Last Change: 2020 Sep 22

if has("nvim")
  lua require("fennel-setup")
  command -nargs=1 Fennel call v:lua.eval_fennel(<f-args>)
endif
