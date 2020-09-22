(fn ts_query [lang query]
  (assert (sequence? query) "treesitter query should be a sequence")
  (var acc "")
  (each [_ value (ipairs query)]
    (set acc (string.format "%s %s" acc (tostring value))))
  `((. (require "vim.treesitter.query") :parse_query) ,lang ,acc))

(fn matches [ node bufnr start end lang query ... ]
  (let [capture_names {}
        match_sym (gensym)]
    (var qstring "")
    (each [_ value (ipairs query)]
      (set qstring (.. qstring " " (tostring value))))

    ;; Extract capture names
    (var c 1)
    (each [m (qstring:gmatch "@[a-z._]+")]
      (if (not (. capture_names m))
        (do
          (tset capture_names m [(sym m) `(. ,match_sym ,c)])
          (set c (+ c 1)))))

    (var let_binds [])
    (each [_ val (pairs capture_names)]
      (do
        (table.insert let_binds (. val 1))
        (table.insert let_binds (. val 2))))

    ;; Generate each and let
    `(let [q# ,(ts_query lang query)]
       (each [pattern# ,match_sym (: q# :iter_matches ,node ,bufnr ,start ,end)]
         (let ,let_binds ,...)))))

{:ts ts_query
 :matches matches}
