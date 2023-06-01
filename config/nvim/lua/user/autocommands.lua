vim.cmd [[
  augroup _general_settings
    autocmd FileType py,cmake,xml setlocal foldmethod=indent
  augroup end

  augroup _numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]]
