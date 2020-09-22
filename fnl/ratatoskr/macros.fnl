(fn ts_query [lang ...]
  (var acc "")
  (each [_ value (ipairs [ ... ])]
    (set acc (string.format "%s %s" acc (tostring value))))
  `((. (require "vim.treesitter.query") :parse_query) ,lang ,acc))

{:ts ts_query}
