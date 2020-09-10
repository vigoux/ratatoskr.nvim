local function ts_query(...)
  return string.gsub(tostring(...), "&", "@")
end
return {ts = ts_query}