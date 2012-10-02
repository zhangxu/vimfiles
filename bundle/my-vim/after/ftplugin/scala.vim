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

"organize imports
nmap <C-S-o> :call OrganizeImps()<CR>

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

function! OrganizeImps()
    norm! G$
    let end=line(".")
    let imps=filter(getline(1, end), 'v:val =~ "^import"')
    let packs = {}
    for i in range(0, len(imps)-1)
        let sections = split(substitute(imps[i][len('import'):], "^\\s\\+\\|\\s\\+$","","g"), "\\.")
        let pack = join(sections[:len(sections) - 2], ".")
        let obj = sections[len(sections) - 1]
        let objs = get(packs, pack, [])
        let objs = sort(add(objs, substitute(obj, "^{|}$", "", "g")))
        let objs=filter(copy(objs), 'index(objs, v:val, v:key+1)==-1')
        let packs[pack] = objs
    endfor
    :echo packs
endfunction

function! RemoveDups()
endfunction
