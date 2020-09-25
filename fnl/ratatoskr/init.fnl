(import-macros m "ratatoskr.macros")

(let [parser (vim.treesitter.get_parser)
      root (: (parser:parse) :root)
      lang (. parser "lang")
      lcount (vim.api.nvim_buf_line_count 0)]

  (m.matches root 0 0 lcount (m.ts lang [(identifier) @id (number) @num])
             (if @num
               (print (@num:type))
               (print (@id:type)))))
