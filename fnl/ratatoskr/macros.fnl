(fn ts_query [...]
 (string.gsub (tostring ...) "&" "@"))

{:ts ts_query}
