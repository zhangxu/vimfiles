"alway insert spaces instead of tab -- reset
setlocal softtabstop=0
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal textwidth=80
"folding
setlocal foldmethod=expr
setlocal foldexpr=GetScalaFold(v:lnum)
setlocal foldlevel=1

function! GetScalaFold(lnum)

    if getline(a:lnum) =~ '\v^import'
        return 2
    endif

    if getline(a:lnum) =~ '\v^\s*import'
        return '-1'
    endif

    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif


    let numspace = indent(a:lnum) % &shiftwidth

    if numspace > 0
        return (indent(a:lnum) / &shiftwidth) + 1
    else
        return indent(a:lnum) / &shiftwidth
    endif
endfunction
