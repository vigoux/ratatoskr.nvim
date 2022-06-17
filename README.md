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

# Acknowledgements

Thanks @runiq for the name
