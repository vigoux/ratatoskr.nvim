(fn ts_query [lang query]
  (assert (sequence? query) "treesitter query should be a sequence")
  (var acc "")
  (each [_ value (ipairs query)]
    (set acc (string.format "%s %s" acc (tostring value))))
  `((. (require "vim.treesitter.query") :parse_query) ,lang ,acc))

(fn code_trans_at [ m query get_fn ... ]
  "Replaces every occurence of @{capt} in a tree by calls like (get_fn m query {capt})
  this is used to extract capture names from a query"
  (var out_code (list))
  (each [_ outer (ipairs [ ... ])]
    (each [index item (ipairs outer)]

      (let [item_txt (tostring item)
            inner_txt (tostring (. item 1))
            gen_call (fn [capt] `(,get_fn ,m ,query ,(string.sub capt 2)))]

        (table.insert
          out_code
          (if
            ;; (@foo:bar baz) -> (: (,call) "bar" baz)
            (and (list? item) (sym? (. item 1))
                 (string.find inner_txt "^@.*:"))
            (let [ (left right) (string.match inner_txt "(.-):(.*)" )]
              (list `: (gen_call left) right (unpack item 2)))

            (and (sym? item) (= (string.sub item_txt 1 1) "@"))
            ;; @foo alone
            (gen_call item_txt)

            (and (multi-sym? item)
                 (= (string.sub item_txt 1 1) "@"))
            ;; @foo.bar
            (gen_call item_txt)

            ;; Go down the tree
            (or (list? item) (table? item) (sequence? item))
            (code_trans_at m query get_fn item)

            ;; Terminals : numbers, strings, ...
            item)))))
  out_code)

(fn matches [ node bufnr start end query ... ]
  (let [match_sym (sym "tsmatch")
        q_name (gensym)
        get_fn_name (gensym)]

    (var get_fn `(fn ,get_fn_name [m# q# a#] (. m# (. (. q# :captures) a#))))

    `(let [,q_name ,query]
       (pcall vim.tbl_add_reverse_lookup (. ,q_name "captures"))
       ,get_fn
       (each [pattern# ,match_sym (: ,q_name "iter_matches" ,node ,bufnr ,start ,end)]
         ,(code_trans_at match_sym q_name get_fn_name ...)))))

(fn edit [ bufnr query ... ]
    (let [parser_sym (gensym)
          root_sym (gensym)
          lang_sym (gensym)
          lcount_sym (gensym)
          query_sym (gensym)
          replace_sym (sym "replace")
          text_sym (sym "text")
          edits_sym (gensym)]

      (var replace_fn
        `(fn ,replace_sym [node# replacement#]
            (let [(nsl# nsc# nel# nec#) (: node# :range)]
              (table.insert ,edits_sym
                {:range {:start { :line nsl# :character nsc# }
                         :end   { :line nel# :character nec# }}
                 :newText replacement#}))))

      (var text_fn
           `(fn ,text_sym [node#]
                (vim.treesitter.query.get_node_text node# ,bufnr)))

      `(let [,parser_sym (vim.treesitter.get_parser ,bufnr)
             ,root_sym (-> ,parser_sym (: :parse) (. 1) (: :root))
             ,lang_sym (: ,parser_sym "lang")
             ,lcount_sym (vim.api.nvim_buf_line_count ,bufnr)
             ,query_sym ,(ts_query lang_sym query)
             ,edits_sym []]
         ,text_fn
         ,replace_fn
         ,(matches root_sym bufnr 0 lcount_sym query_sym ...)
        (vim.lsp.util.apply_text_edits ,edits_sym ,bufnr "utf-8"))))

{:ts ts_query
 :matches matches
 :edit edit}
