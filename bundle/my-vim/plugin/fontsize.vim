
if !exists('g:CurrentFontSize')
    let g:CurrentFontSize=10
endif

function! s:Increase()
    let &guifont = substitute(
     \ &guifont,
     \ ':h\zs\d\+',
     \ '\=eval(submatch(0)+1)',
     \ '')
endfunction

function! s:Decrease()
    let &guifont = substitute(
     \ &guifont,
     \ ':h\zs\d\+',
     \ '\=eval(submatch(0)-1)',
     \ '')
endfunction

function! s:Reset()
    let &guifont = substitute(
     \ &guifont,
     \ ':h\zs\d\+',
     \ '\=eval(g:CurrentFontSize)',
     \ '')
endfunction

map <silent> <A-=> :call <SID>Increase()<CR>
map <silent> <A--> :call <SID>Decrease()<CR>
map <silent> <A-`> :call <SID>Reset()<CR>

"nnoremap <A-=> :silent! let &guifont = substitute(
 "\ &guifont,
 "\ ':h\zs\d\+',
 "\ '\=eval(submatch(0)+1)',
 "\ '')<CR>

"nnoremap <A--> :silent! let &guifont = substitute(
 "\ &guifont,
 "\ ':h\zs\d\+',
 "\ '\=eval(submatch(0)-1)',
 "\ '')<CR>

nnoremap <A-0> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(g:CurrentFontSize)',
 \ '')<CR>


