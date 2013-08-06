let g:alpha=200

function! s:Increase()
    if g:alpha < 250
        let g:alpha = g:alpha + 5
    endif
    call libcallnr("vimtweak.dll", "SetAlpha", g:alpha)

endfunction

function! s:Decrease()
    if g:alpha > 5
        let g:alpha = g:alpha - 5
    endif
    call libcallnr("vimtweak.dll", "SetAlpha", g:alpha)

endfunction

map <silent> <A-Up> :call <SID>Increase()<CR>
map <silent> <A-Down> :call <SID>Decrease()<CR>
