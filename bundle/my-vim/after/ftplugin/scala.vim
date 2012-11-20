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
    " gather imports in dict
    norm! G$
    let end = line(".")
    let entries = filter(getline(1, end), 'v:val =~ "^import"')

    let topLvlImps = {}
    for i in range(0, len(entries)-1)
        let sections = split(substitute(entries[i][len('import'):], "^\\s\\+\\|\\s\\+$","","g"), "\\.")

        if len(sections) > 1
            let package = join(sections[:len(sections) - 2], ".")
            let topLvl = sections[0] . "." . sections[1]
        else
            let package = "_rel_"
            let topLvl = sections[0]
        endif

        let imports = get(topLvlImps, topLvl, {})

        let obj = sections[len(sections) - 1]
        let obj = substitute(obj, "^{", "", "g")
        let obj = substitute(obj, "}$", "", "g")

        let objs = get(imports, package, [])
        let objs = sort(extend(objs, map(split(obj, ','), 'substitute(v:val, "^\\s\\+\\|\\s\\+$", "", "g")')))
        let objs = filter(copy(objs), 'index(objs, v:val, v:key+1)==-1')

        let imports[package] = objs

        let topLvlImps[topLvl] = imports
    endfor

    " delete original imports
    :g/^import/d
    :w

    norm! gg

    while getline(line(".")) =~ "^package"
        +1
    endwhile

    while getline(line(".")) =~ "^$"
        norm! dd
    endwhile

    if getline(line(".")) !~ "\\s+"
        norm! O
    endif

    let topLvls = reverse(sort(keys(topLvlImps)))

    for i in range(0, len(topLvls) - 1)
        let results = GenImports(topLvlImps[topLvls[i]])
        let results = add(results, "")

        let failed = append(line("."), results)

        if failed != 1
            :w
        endif
    endfor
endfunction

function! GenImports(imports)
    " generate new imports
    let results = []
    let packages = sort(keys(a:imports))

    for i in range(0, len(packages) - 1)
        let objs = a:imports[packages[i]]
        if len(objs) > 1
            let noneAliases = GetNoneAliases(objs)
            let aliases = GetAliases(objs)

            if len(noneAliases) > 0 && len(aliases) > 0
                let import = "import" . " " . packages[i] . ".{" . aliases . ", " . noneAliases . "}"
            else
                if len(noneAliases) > 0
                    if noneAliases == '_'
                        let import = "import" . " " . packages[i] . "._"
                    else
                        let import = "import" . " " . packages[i] . ".{" . noneAliases . "}"
                    endif
                else
                    let import = "import" . " " . packages[i] . ".{" . aliases . "}"
                endif
            endif

        else
            if objs[0] =~ ".*=>.*"
                let import = "import" . " " . packages[i] . ".{" . objs[0] . "}"
            else
                if packages[i] =~ "_rel_"
                    let import = "import" . " " . objs[0]
                else
                    let import = "import" . " " . packages[i] . "." . objs[0]
                endif
            endif
        endif

        let results = add(results, import)
    endfor

    return results
endfunction

function! WildcardIn(objs)
    for i in range(0, len(a:objs) - 1)
        if a:objs[i] == '_'
            return 1
        endif
    endfor

    return 0
endfunction

function! GetAliases(objs)
    return join(filter(a:objs, 'v:val =~ ".*=>.*"'), ', ')
endfunction

function! GetNoneAliases(objs)
    if WildcardIn(a:objs)
        return '_'
    else
        let objs = filter(a:objs, 'v:val !~ ".*=>.*"')
        return join(objs, ', ')
        "if len(objs) > 3
            "return '_'
        "else
            "return join(objs, ', ')
        "endif
    endif
endfunction
