(module ratatosk.main-test
  {require {r ratatoskr.init}
   require-macros [fnl.ratatoskr.macros]})

(deftest add
  (t.= 10 (r.add 6 4) "it adds things"))

(deftest simple_query
  (t.= "(identifier)" (ts (identifier))))

(deftest query_wildcards
  (t.= "(foo (_))" (ts (foo (_)))))

(deftest query_quants
  (t.= "(foo (id) + (id) ? (id) *)" (ts (foo (id)+ (id)? (id)*))))
