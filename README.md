# ratatoskr.nvim

An experiment to use fennel to generate queries in neovim.

# Installation

Install this as a regular plugin with your plugin manager.
This plugin does not have any dependency, but it is tested only
against latest neovim master.

# Usage

To start the plugin, run:
```vim
lua require"ratatoskr".enable()
```

This will enable ratatoskr in you current buffer, and allow you to
edit the buffer using tree-sitter.

You should a window opened with an explanation on what to do next.
Here is for example a code replacing all identifiers with the text
`foo`:

```fennel
(import-macros m "ratatoskr.macros")
;; Ratatoskr edit window, enter your changes below
(m.edit 3 [
    ;; Enter your query between those brackets
    (identifier) @id
    ]

    ;; Enter your changes as code here

    (when (not= nil @id)
      (replace @id "foo")))
```

As you can see, the code and the edition are seemlessly integrated.
Within the `edit` call, the following function are provided:
- `(replace node text)` replaces `node` with `text`
- `(text node)` gets the text corresponding to the current node

Please not that all `@...` are replaced by the node they point to, and
that, because of how queries work, some may be `nil`. It is thus
considered a good practice to always check whether a node is `nil`
before using it.

# TODOs

## Templating for queries.

One neat thing would be to have query templates, something like the
following:

```fennel
;; Declares a query
(query lang
  (if foo
    (t [ (identifier) @bar ])
    (t [ (identifier) @foo ]))

  ;; Some better templating ?
  (each [_ v [ "a" "b" "c" ]]
    (t [ (identifier) @%s ] v)))
```

# Acknowledgements

Thanks @runiq for the name
