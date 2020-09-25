(fn ts_query [lang query]
  (assert (sequence? query) "treesitter query should be a sequence")
  (var acc "")
  (each [_ value (ipairs query)]
    (set acc (string.format "%s %s" acc (tostring value))))
  `((. (require "vim.treesitter.query") :parse_query) ,lang ,acc))

(fn code_trans_at [ m query get_fn ... ]
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
  (let [capture_names {}
        match_sym (sym "tsmatch")
        q_name (gensym)
        get_fn_name (gensym)]

    (var get_fn `(fn ,get_fn_name [m# q# a#] (. m# (. (. q# :captures) a#))))

    `(let [,q_name ,query]
       (vim.tbl_add_reverse_lookup (. ,q_name "captures"))
       ,get_fn
       (each [pattern# ,match_sym (: ,q_name "iter_matches" ,node ,bufnr ,start ,end)]
         ,(code_trans_at match_sym q_name get_fn_name ...)))))

{:ts ts_query
 :matches matches}
