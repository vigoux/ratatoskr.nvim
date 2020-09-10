(module ratatoskr.init
  {require {a ratatoskr.aniseed.core}
   require {v ratatoskr.aniseed.view}
   require {q vim.treesitter.query}
   require {p vim.treesitter}
   require-macros [fnl.ratatoskr.macros]})

(defn add [a b]
  (+ a b))

(defn captures [root buf start end lang query]
  (: (q.parse_query lang query) "iter_captures" root buf start end))

(defn iter-nodes [buf lang]
  (do
    (var parser (p.get_parser buf))
    (var root (: (: parser :parse) :root))
    (each [capture node (captures root buf (: root :start) (: root :end_) lang (ts (identifier)))]
      (print (node:type)))))
