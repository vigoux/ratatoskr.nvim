(local api (. vim :api))
(local fennel (require "fennel"))

(fn make-template [bufnr]
    ["(import-macros m \"ratatoskr.macros\")"
     ";; Ratatoskr edit window, enter your changes below"
     (string.format "(m.edit %d [" bufnr)
     "    ;; Enter your query between those brackets"
     ""
     "    ]"
     ""
     "    ;; Enter your changes as code here"
     ")"])

(var enabled false)
(var source_buffer 0)
(var preview_buffer 0)
(var dbg_mode false)
(fn enable [dbg]
    (if (not enabled)
      (let [bufnr ((. api :nvim_get_current_buf))
            ft ((. api :nvim_buf_get_option) bufnr :filetype)
            win ((. api :nvim_get_current_win))
            edit_buffer ((. api :nvim_create_buf) false false)
            tmp_buffer ((. api :nvim_create_buf) false false)
            curr_lines ((. api :nvim_buf_get_lines) bufnr 0 -1 false)]

            (set preview_buffer tmp_buffer)
            (set source_buffer bufnr)
            (set dbg_mode dbg)
            (set enabled true)

            ;; Set the edit window up
            ((. api :nvim_command) "wincmd v")
            ((. api :nvim_buf_set_lines) edit_buffer 0 -1 false (make-template tmp_buffer))
            ((. api :nvim_buf_set_option) edit_buffer :filetype "fennel")
            ((. api :nvim_win_set_buf) 0 edit_buffer)
            ((. api :nvim_command) "autocmd CursorHold,CursorHoldI <buffer> lua require'ratatoskr'.on_hold()")

            ;; Set the preview window up
            ((. api :nvim_buf_set_lines) tmp_buffer 0 -1 false curr_lines)
            ((. api :nvim_buf_set_option) tmp_buffer :filetype ft)
            ((. api :nvim_win_set_buf) win tmp_buffer))))

(fn on_hold []
    (if enabled
      (let [orig_lines ((. api :nvim_buf_get_lines) source_buffer 0 -1 false)
            code_lines ((. api :nvim_buf_get_lines) 0 0 -1 false)
            (valid lua_code) (pcall (. fennel :compileString) (table.concat code_lines "\n"))]

        ((. api :nvim_buf_set_lines) preview_buffer 0 -1 false orig_lines)
        (if valid
          ;; Set the preview window up
          (if dbg_mode
            ((load lua_code))
            (pcall (load lua_code)))))))

{:enable enable
 :on_hold on_hold}
