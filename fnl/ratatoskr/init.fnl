(import-macros m "ratatoskr.macros")

(var parser (vim.treesitter.get_parser))
(let [root (: (parser:parse) :root)
      lang (. parser "lang")
      lcount (vim.api.nvim_buf_line_count 0)]
  (m.matches root 0 0 lcount lang [(identifier) @id (number) @num]
             (if @num
               (print "BAAAR" (@num:type)))
             (if @id
               (print (@id:type)))))
