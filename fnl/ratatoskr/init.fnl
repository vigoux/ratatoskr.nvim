(import-macros m "ratatoskr.macros")

(var parser (vim.treesitter.get_parser))

(each [id node
       (: (m.ts (. parser "lang") (identifier) @id) "iter_captures"
        (: (parser:parse) "root") 0 0 (vim.api.nvim_buf_line_count 0))]
  (print (node:type)))
