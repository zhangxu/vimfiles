"autocmd VimEnter * if !argc() | NERDTree | endif

autocmd FileType nerdtree cnoreabbrev <buffer> bd <nop>
autocmd FileType nerdtree cnoreabbrev <buffer> bnext <nop>
autocmd FileType nerdtree cnoreabbrev <buffer> bprev <nop>

"call NERDTreeAddKeyMap({
            "\ 'key': 'py',
            "\ 'callback': 'NERDTreePythonHandler',
            "\ 'scope': 'DirNode' })

"function! NERDTreePythonHandler(dirnode)
    "let path = a:dirnode.path.str()
    "call RunPython(path)
"endfunction

"call NERDTreeAddKeyMap({
            "\ 'key': 'hg',
            "\ 'callback': 'NERDTreeThgHandler',
            "\ 'scope': 'DirNode' })

"function! NERDTreeThgHandler(dirnode)
    "let path = '"'. a:dirnode.path.str() . '"'
    "call RunThg(path)
"endfunction

"call NERDTreeAddKeyMap({
            "\ 'key': 'con',
            "\ 'callback': 'NERDTreeConEmuHandler',
            "\ 'scope': 'DirNode' })

"function! NERDTreeConEmuHandler(dirnode)
    "let path = '"'. a:dirnode.path.str() . '"'
    "call RunConEmu('', path)
"endfunction

"call NERDTreeAddKeyMap({
            "\ 'key': 'git',
            "\ 'callback': 'NERDTreeGitBashHandler',
            "\ 'scope': 'DirNode' })

"function! NERDTreeGitBashHandler(dirnode)
    "let path = '"'. a:dirnode.path.str() . '"'
    "call RunConEmu('git-bash.bat', path, 'E:\\scripts\\configurations\\StExBar\\icons\\git.ico')
"endfunction

"call NERDTreeAddKeyMap({
            "\ 'key': 'sbt',
            "\ 'callback': 'NERDTreeSbtHandler',
            "\ 'scope': 'DirNode' })

"function! NERDTreeSbtHandler(dirnode)
    "let path = '"'. a:dirnode.path.str() . '"'
    "call RunConEmu('sbt', path)
"endfunction

"if !exists('g:OpenNerdtreeBookmark')
    "let g:OpenNerdtreeBookmark=0
"endif

"call NERDTreeAddKeyMap({
            "\ 'key': 'con',
            "\ 'callback': 'NERDTreeBMConEmuHandler',
            "\ 'scope': 'Bookmark' })

"function! NERDTreeBMConEmuHandler(bookmark)
    "if g:OpenNerdtreeBookmark == 1
        "call a:bookmark.open()
    "endif

    "let path = '"'. a:bookmark.path.getDir().str() . '"'
    "call RunConEmu('', path)
"endfunction

"call NERDTreeAddKeyMap({
            "\ 'key': 'py',
            "\ 'callback': 'NERDTreeBMPythonHandler',
            "\ 'scope': 'Bookmark' })

"function! NERDTreeBMPythonHandler(bookmark)
    "if g:OpenNerdtreeBookmark == 1
        "call a:bookmark.open()
    "endif

    "let path = a:bookmark.path.getDir().str()
    "call RunPython(path)
"endfunction

"call NERDTreeAddKeyMap({
            "\ 'key': 'hg',
            "\ 'callback': 'NERDTreeBMThgHandler',
            "\ 'scope': 'Bookmark' })

"function! NERDTreeBMThgHandler(bookmark)
    "if g:OpenNerdtreeBookmark == 1
        "call a:bookmark.open()
    "endif

    "let path = '"'. a:bookmark.path.getDir().str() . '"'
    "call RunThg(path)
"endfunction

"call NERDTreeAddKeyMap({
            "\ 'key': 'git',
            "\ 'callback': 'NERDTreeBMGitBashHandler',
            "\ 'scope': 'Bookmark' })

"function! NERDTreeBMGitBashHandler(bookmark)
    "if g:OpenNerdtreeBookmark == 1
        "call a:bookmark.open()
    "endif

    "let path = '"'. a:bookmark.path.getDir().str() . '"'
    "call RunConEmu('git-bash.bat', path, 'E:\\scripts\\configurations\\StExBar\\icons\\git.ico', 'xxx')
"endfunction

"call NERDTreeAddKeyMap({
            "\ 'key': 'sbt',
            "\ 'callback': 'NERDTreeBMSbtHandler',
            "\ 'scope': 'Bookmark' })

"function! NERDTreeBMSbtHandler(bookmark)
    "if g:OpenNerdtreeBookmark == 1
        "call a:bookmark.open()
    "endif

    "let path = '"'. a:bookmark.path.getDir().str() . '"'
    "call RunConEmu('sbt', path)
"endfunction

"call NERDTreeAddKeyMap({
            "\ 'key': 'o',
            "\ 'callback': 'NERDTreeBMOpenHandler',
            "\ 'scope': 'Bookmark' })

"function! NERDTreeBMOpenHandler(bookmark)
    "call a:bookmark.open()
    "call a:bookmark.path.getDir().changeToDir()
"endfunction

"function! RunConEmu(cmd, wdir, ...)
    "if a:0 > 0
        "let icon = a:1
    "else
        "let icon = ""
    "endif

    "if icon == ""
        "exec "silent !start ConEmu /Dir " . a:wdir . " /cmd " . a:cmd
    "else
        "exec "silent !start ConEmu" . " /Icon " . icon . " /Dir " . a:wdir . " /cmd " . a:cmd
    "endif

"endfunction

"function! RunThg(wdir)
    "exec "silent ! start thgw.exe -R " . a:wdir
"endfunction

"call NERDTreeAddMenuItem({
            "\ 'text': '(C)reate folders',
            "\ 'shortcut': 'C',
            "\ 'callback': 'Mkdirs' })

"function! Mkdirs()
    "let curDirNode = g:NERDTreeDirNode.GetSelected()

    "let newNodeName = input("Add a childnode\n".
                          "\ "==========================================================\n".
                          "\ "", curDirNode.path.str() . g:NERDTreePath.Slash(), "file")

    "if newNodeName ==# ''
        "call s:echo("Node Creation Aborted.")
        "return
    "endif

    "let oldPath = curDirNode.path.str()

    "let cwd = g:NERDTreePath

    "for name in split(newNodeName, "/")
        "if isdirectory(name)
            "let cwd = cwd.New(name)
        "else
            "call mkdir(name)
            "let cwd = cwd.New(name)
            "let newTreeNode = g:NERDTreeFileNode.New(cwd)
            "let parentNode = b:NERDTreeRoot.findNode(cwd.getParent())
            "call parentNode.addChild(newTreeNode, 1)
        "endif

        "call cwd.changeToDir()
    "endfor

    "echo curDirNode.reveal(cwd)

    "call NERDTreeRender()

    "let cwd = cwd.New(oldPath)

    "call cwd.changeToDir()
"endfunction

"function! s:echo(msg)
    "redraw
    "echomsg "NERDTree: " . a:msg
"endfunction

"function! s:echoWarning(msg)
    "echohl warningmsg
    "call s:echo(a:msg)
    "echohl normal
"endfunction

"call NERDTreeAddMenuSeparator()

"let hgsubmenu = NERDTreeAddSubmenu({
                "\ 'text': '(h)g operations',
                "\ 'shortcut': 'h' })

"call NERDTreeAddMenuItem({
                "\ 'text': '(a)dd',
                "\ 'shortcut': 'a',
                "\ 'callback': 'HgAdd',
                "\ 'parent': hgsubmenu })

"function! HgAdd()
    "let curPath = g:NERDTreeFileNode.GetSelected().path.str()

    "exec "! hg add " . curPath
"endfunction

"call NERDTreeAddMenuItem({
                "\ 'text': '(d)elete',
                "\ 'shortcut': 'd',
                "\ 'callback': 'HgDelete',
                "\ 'parent': hgsubmenu })

"function! HgDelete()
    "let curPath = g:NERDTreeFileNode.GetSelected().path.str()
    "exec "! hg remove " . curPath
"endfunction

"call NERDTreeAddMenuItem({
                "\ 'text': '(m)ove',
                "\ 'shortcut': 'm',
                "\ 'callback': 'HgMove',
                "\ 'parent': hgsubmenu })

"function! HgMove()
    "echo "Hg Move"
"endfunction

"call NERDTreeAddMenuItem({
                "\ 'text': '(r)evert',
                "\ 'shortcut': 'r',
                "\ 'callback': 'HgRevert',
                "\ 'parent': hgsubmenu })

"function! HgRevert()
    "let curPath = g:NERDTreeFileNode.GetSelected().path.str()
    "exec "! hg revert -C " . curPath
"endfunction

"call NERDTreeAddMenuSeparator()

"let vesubmenu = NERDTreeAddSubmenu({
                "\ 'text': 'virtual(e)nv operations',
                "\ 'shortcut': 'e' })

"call NERDTreeAddMenuItem({
                "\ 'text': '(a)ctivate',
                "\ 'shortcut': 'a',
                "\ 'callback': 'VeActivate',
                "\ 'parent': vesubmenu })

"function! VeActivate()
    "let curPath = g:NERDTreeFileNode.GetSelected().path.str()

"endfunction

"function! RunPython(path)
    "if filereadable(a:path . "/.ve")
        "let envpath = readfile(a:path . "/.ve")[0]

        "if has("win32")
            "let cmd = envpath . "\\Scripts\\activate.bat"

            "exec "silent ! start ConEmu /Icon E:\\scripts\\configurations\\StExBar\\icons\\python.ico /Dir " . a:path . " /cmd \"Cmd.exe /k " . cmd . "\""
        "endif
    "else
        "call RunConEmu('python', a:path, 'E:\\scripts\\configurations\\StExBar\\icons\\python.ico')
    "endif
"endfunction

