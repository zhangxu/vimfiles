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
    let end = line(".")
    let entries = filter(getline(1, end), 'v:val =~ "^import"')
    let imports = {}
    for i in range(0, len(entries)-1)
        let sections = split(substitute(entries[i][len('import'):], "^\\s\\+\\|\\s\\+$","","g"), "\\.")
        let package = join(sections[:len(sections) - 2], ".")

        let obj = sections[len(sections) - 1]
        let obj = substitute(obj, "^{", "", "g")
        let obj = substitute(obj, "}$", "", "g")

        let objs = get(imports, package, [])
        let objs = sort(add(objs, obj))
        let objs = filter(copy(objs), 'index(objs, v:val, v:key+1)==-1')

        let imports[package] = objs
    endfor

    let results = []
    let packages = sort(keys(imports))

    for i in range(0, len(packages) - 1)
        let objs = imports[packages[i]]
        if len(objs) > 1
            let import = "import" . " " . packages[i] . ".{" . join(objs, ", ") . "}"
        else
            let import = "import" . " " . packages[i] . "." . objs[0]
        endif

        let results = add(results, import)
    endfor

    :g/import/d
    :w

    norm! gg

    while getline(line(".")) =~ "^package"
        +1
    endwhile

    if getline(line(".")) !~ "\\s+"
        norm! O
    endif

    let failed = append(line("."), results)

    if failed != 1
        :w
    endif
endfunction

