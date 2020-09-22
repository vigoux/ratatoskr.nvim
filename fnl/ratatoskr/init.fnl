(macro ts_query [lang ...]
  (var acc "")
  (each [_ value (ipairs [ ... ])]
    (set acc (string.format "%s %s" acc (string.gsub (tostring value) "&" "@"))))
  `((. (require "vim.treesitter.query") :parse_query) ,lang ,acc))

(print (vim.inspect (ts_query "c" (identifier) &bar (function_definition) &baz)))
