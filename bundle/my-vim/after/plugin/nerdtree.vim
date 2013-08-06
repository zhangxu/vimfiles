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

