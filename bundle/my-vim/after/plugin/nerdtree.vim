autocmd VimEnter * if !argc() | NERDTree | endif

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
