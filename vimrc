call pathogen#infect()
syntax on
filetype plugin indent on
colorscheme molokai

"show line number
set number

"disable backup
set nobackup

"disable the ~/_viminfo file
set viminfo=""

"show tabs and trailing spaces
set list
set listchars=tab:>.,trail:.,nbsp:%,eol:¶

"disable beep and enable visual blink on error
set noeb vb t_vb=

"alway insert spaces instead of tab
set tabstop=4
set shiftwidth=4
set expandtab

"<EOL> setting
set fileformats=unix,dos
set fileformat=unix

"set status line
set ruler
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set laststatus=2

"set current dir to current buffer file
set autochdir

"highlight search result
set hlsearch

"key mappings
map <c-tab> :bnext<CR>
map <c-S-tab> :bprev<CR>

"mimic windows copy/paste behavior
vmap <c-c> "+y
vmap <c-x> "+d
map <c-v> <S-Insert>

"change window size
nmap <Down> <C-W>-
nmap <Up> <C-W>+
nmap <Left> <C-W><
nmap <Right> <C-W>>

nmap <c-F5> :call RunThis()<CR>
nmap <c-F6> :call DebugThis()<CR>

"funtion definitions
function! RemoveTrailingSpaces()
    let c=col('.')
    let l=line('.')
    :%s/\s\+$//e
    call cursor(l, c)
endfunction

function! RunThis()
    let filename = expand('%:p')
    :echohl ErrorMsg
    if match(filename, "\.py$") > 0
        let cmd = '!python ' . expand('%') . ' ' . input('parameters: ')
        exec(cmd)
    elseif match(filename, "\.xml$") > 0
        let cmd = '!ant.bat -f ' . expand('%') . ' ' . input('target: ') . ' ' . input('-D parameters: ')
        exec(cmd)
    elseif match(filename, "\.scala$") > 0
        let cmd = '!scala.bat -deprecation '. expand('%')
        exec(cmd)
    elseif match(filename, "\.gradle$") > 0
        let cmd = '!gradle.bat -b ' . expand('%') . ' ' . input('task: ') . ' ' . input('-D parameters: ')
        exec(cmd)
    elseif match(filename, "\.vim$") > 0
        :so %
    else
        "let answer = confirm('Cannot run this file', "&Cannel")
        echoerr('Cannot run this type of file: ' . expand('%:p'))
    endif
    :echohl None
endfunction

function! DebugThis()
    let filename = expand('%:p')
    :echohl ErrorMsg
    if match(filename, '\.py$') > 0
        let cmd = '!python -m pdb ' . expand('%') . ' ' . input('parameters: ')
        exec(cmd)
    elseif match(filename, "\.gradle$") > 0
        let cmd = '!gradle.bat --debug --stacktrace -b ' . expand('%') . ' ' . input('task: ') . ' ' . input('-D parameters: ')
        exec(cmd)
    else
        "let answer = confirm('Cannot debug this file', "&Cannel")
        echoerr('Cannot debug this type of file: ' . expand('%:p'))
    endif
    :echohl None
endfunction

autocmd BufWritePre,filewritepre * :call RemoveTrailingSpaces()
