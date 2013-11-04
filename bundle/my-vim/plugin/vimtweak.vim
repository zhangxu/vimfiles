if !exists('g:alpha')
    let g:alpha=220
endif

let s:original_alpha = g:alpha

if !exists('g:ToggleFullScreen')
    let g:ToggleFullScreen = 0
endif

function! s:Increase()
    if g:alpha < 250
        let g:alpha = g:alpha + 5
    endif

    call libcallnr("vimtweak.dll", "SetAlpha", g:alpha)

    echo "Current Alpha is " . g:alpha
endfunction

function! s:Decrease()
    if g:alpha > 5
        let g:alpha = g:alpha - 5
    endif
    call libcallnr("vimtweak.dll", "SetAlpha", g:alpha)

    echo "Current Alpha is " . g:alpha
endfunction

function! s:Reset()
    let g:alpha = s:original_alpha

    call libcallnr("vimtweak.dll", "SetAlpha", g:alpha)

    echo "Current Alpha is " . g:alpha
endfunction

map <silent> <A-Up> :call <SID>Increase()<CR>
map <silent> <A-Down> :call <SID>Decrease()<CR>
map <silent> <A-0> :call <SID>Reset()<CR>

function! s:ToggleFullScreen()
    let g:ToggleFullScreen = 1 - g:ToggleFullScreen

    call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", g:ToggleFullScreen)

    "call libcallnr("vimtweak.dll", "EnableMaximize", g:ToggleFullScreen)
    "call libcallnr("vimtweak.dll", "EnableCaption", 1 - g:ToggleFullScreen)

    "if g:ToggleFullScreen != 1
        "simalt ~x
    "endif
endfunction

nmap <F11> :call <SID>ToggleFullScreen()<CR>

