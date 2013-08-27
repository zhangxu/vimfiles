autocmd VimEnter * if !argc() | NERDTree | endif

autocmd FileType nerdtree cnoreabbrev <buffer> bd <nop>
autocmd FileType nerdtree cnoreabbrev <buffer> bnext <nop>
autocmd FileType nerdtree cnoreabbrev <buffer> bprev <nop>

call NERDTreeAddKeyMap({
            \ 'key': 'thg',
            \ 'callback': 'NERDTreeThgHandler',
            \ 'scope': 'DirNode' })

function! NERDTreeThgHandler(dirnode)
    let path = '"'. a:dirnode.path.str() . '"'
    call RunThg(path)
endfunction

call NERDTreeAddKeyMap({
            \ 'key': 'cc',
            \ 'callback': 'NERDTreeConEmuHandler',
            \ 'scope': 'DirNode' })

function! NERDTreeConEmuHandler(dirnode)
    let path = '"'. a:dirnode.path.str() . '"'
    call RunConEmu('', path)
endfunction

call NERDTreeAddKeyMap({
            \ 'key': 'git',
            \ 'callback': 'NERDTreeGitBashHandler',
            \ 'scope': 'DirNode' })

function! NERDTreeGitBashHandler(dirnode)
    let path = '"'. a:dirnode.path.str() . '"'
    call RunConEmu('git-bash.bat', path)
endfunction

call NERDTreeAddKeyMap({
            \ 'key': 'sbt',
            \ 'callback': 'NERDTreeSbtHandler',
            \ 'scope': 'DirNode' })

function! NERDTreeSbtHandler(dirnode)
    let path = '"'. a:dirnode.path.str() . '"'
    call RunConEmu('sbt', path)
endfunction

if !exists('g:OpenNerdtreeBookmark')
    let g:OpenNerdtreeBookmark=0
endif

call NERDTreeAddKeyMap({
            \ 'key': 'cc',
            \ 'callback': 'NERDTreeBMConEmuHandler',
            \ 'scope': 'Bookmark' })

function! NERDTreeBMConEmuHandler(bookmark)
    if g:OpenNerdtreeBookmark == 1
        call a:bookmark.open()
    endif

    let path = '"'. a:bookmark.path.getDir().str() . '"'
    call RunConEmu('', path)
endfunction

call NERDTreeAddKeyMap({
            \ 'key': 'thg',
            \ 'callback': 'NERDTreeBMThgHandler',
            \ 'scope': 'Bookmark' })

function! NERDTreeBMThgHandler(bookmark)
    if g:OpenNerdtreeBookmark == 1
        call a:bookmark.open()
    endif

    let path = '"'. a:bookmark.path.getDir().str() . '"'
    call RunThg(path)
endfunction

call NERDTreeAddKeyMap({
            \ 'key': 'git',
            \ 'callback': 'NERDTreeBMGitBashHandler',
            \ 'scope': 'Bookmark' })

function! NERDTreeBMGitBashHandler(bookmark)
    if g:OpenNerdtreeBookmark == 1
        call a:bookmark.open()
    endif

    let path = '"'. a:bookmark.path.getDir().str() . '"'
    call RunConEmu('git-bash.bat', path)
endfunction

call NERDTreeAddKeyMap({
            \ 'key': 'sbt',
            \ 'callback': 'NERDTreeBMSbtHandler',
            \ 'scope': 'Bookmark' })

function! NERDTreeBMSbtHandler(bookmark)
    if g:OpenNerdtreeBookmark == 1
        call a:bookmark.open()
    endif

    let path = '"'. a:bookmark.path.getDir().str() . '"'
    call RunConEmu('sbt', path)
endfunction

call NERDTreeAddKeyMap({
            \ 'key': 'o',
            \ 'callback': 'NERDTreeBMOpenHandler',
            \ 'scope': 'Bookmark' })

function! NERDTreeBMOpenHandler(bookmark)
    call a:bookmark.open()
    call a:bookmark.path.getDir().changeToDir()
endfunction

function! RunConEmu(cmd, wdir)
    exec "silent ! start ConEmu /Dir " . a:wdir . " /cmd " . a:cmd
endfunction

function! RunThg(wdir)
    exec "silent ! start thgw.exe -R " . a:wdir
endfunction

call NERDTreeAddMenuSeparator()

call NERDTreeAddMenuItem({
            \ 'text': '(C)reate folders',
            \ 'shortcut': 'C',
            \ 'callback': 'Mkdirs' })

function! Mkdirs()
    let curDirNode = g:NERDTreeDirNode.GetSelected()

    let newNodeName = input("Add a childnode\n".
                          \ "==========================================================\n".
                          \ "", curDirNode.path.str() . g:NERDTreePath.Slash(), "file")

    if newNodeName ==# ''
        call s:echo("Node Creation Aborted.")
        return
    endif

    let oldPath = curDirNode.path.str()

    let cwd = g:NERDTreePath

    for name in split(newNodeName, "/")
        if isdirectory(name)
            let cwd = cwd.New(name)
        else
            call mkdir(name)
            let cwd = cwd.New(name)
        endif

        call cwd.changeToDir()

        let newTreeNode = g:NERDTreeFileNode.New(cwd)
        let parentNode = b:NERDTreeRoot.findNode(cwd.getParent())
        call parentNode.addChild(newTreeNode, 1)
    endfor

    call NERDTreeRender()

    let cwd = cwd.New(oldPath)

    call cwd.changeToDir()
endfunction

function! s:echo(msg)
    redraw
    echomsg "NERDTree: " . a:msg
endfunction

function! s:echoWarning(msg)
    echohl warningmsg
    call s:echo(a:msg)
    echohl normal
endfunction

