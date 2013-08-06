autocmd VimEnter * if !argc() | NERDTree | endif

call NERDTreeAddKeyMap({
            \ 'key': 'cc',
            \ 'callback': 'NERDTreeConEmuHandler',
            \ 'quickhelpText': 'Start ConEmu in this folder',
            \ 'scope': 'DirNode' })

function! NERDTreeConEmuHandler(dirnode)
    call a:dirnode.path.changeToDir()
    :silent !start ConEmu
endfunction

call NERDTreeAddKeyMap({
            \ 'key': 'cg',
            \ 'callback': 'NERDTreeGitBashHandler',
            \ 'quickhelpText': 'Start Git-Bash in this folder',
            \ 'scope': 'DirNode' })

function! NERDTreeGitBashHandler(dirnode)
    call a:dirnode.path.changeToDir()
    :silent !start ConEmu "git-bash.bat"
endfunction

call NERDTreeAddKeyMap({
            \ 'key': 'cs',
            \ 'callback': 'NERDTreeSbtHandler',
            \ 'quickhelpText': 'Start SBT in this folder',
            \ 'scope': 'DirNode' })

function! NERDTreeSbtHandler(dirnode)
    call a:dirnode.path.changeToDir()
    :silent !start ConEmu "sbt"
endfunction

call NERDTreeAddKeyMap({
            \ 'key': 'cc',
            \ 'callback': 'NERDTreeBMConEmuHandler',
            \ 'scope': 'Bookmark' })

function! NERDTreeBMConEmuHandler(bookmark)
    call a:bookmark.open()
    call a:bookmark.path.getDir().changeToDir()
    :silent !start ConEmu
endfunction

call NERDTreeAddKeyMap({
            \ 'key': 'cg',
            \ 'callback': 'NERDTreeBMGitBashHandler',
            \ 'scope': 'Bookmark' })

function! NERDTreeBMGitBashHandler(bookmark)
    call a:bookmark.open()
    call a:bookmark.path.getDir().changeToDir()
    :silent !start ConEmu "git-bash.bat"
endfunction

call NERDTreeAddKeyMap({
            \ 'key': 'cs',
            \ 'callback': 'NERDTreeBMSbtHandler',
            \ 'scope': 'Bookmark' })

function! NERDTreeBMSbtHandler(bookmark)
    call a:bookmark.open()
    call a:bookmark.path.getDir().changeToDir()
    :silent !start ConEmu "sbt"
endfunction

call NERDTreeAddKeyMap({
            \ 'key': 'o',
            \ 'callback': 'NERDTreeBMOpenHandler',
            \ 'scope': 'Bookmark' })

function! NERDTreeBMOpenHandler(bookmark)
    call a:bookmark.open()
    call a:bookmark.path.getDir().changeToDir()
endfunction

