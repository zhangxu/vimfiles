"function! s:RsyncToRemote()
    "if exists('g:rsync') && g:rsync == 1
        "exec "silent ! sync-to.bat"
    "endif
"endfunction


"autocmd BufWritePost,filewritePost * :call s:RsyncToRemote()

