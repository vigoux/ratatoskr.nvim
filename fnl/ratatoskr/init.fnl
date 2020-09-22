(macro ts_query [lang ...]
  (var acc "")
  (each [_ value (ipairs [ ... ])]
    (set acc (string.format "%s %s" acc (tostring value))))
  `((. (require "vim.treesitter.query") :parse_query) ,lang ,acc))

(each [id node
       (: (ts_query "fennel" (identifier) @id) "iter_captures"
        (: (parser:parse) "root") 0 0 (vim.api.nvim_buf_line_count 0))]
  (print (node:type)))
