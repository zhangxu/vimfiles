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
map <Down> <C-W>-
map <Up> <C-W>+
map <Left> <C-W><
map <Right> <C-W>>

"funtion definitions
function! RemoveTrailingSpaces()
    let c=col('.')
    let l=line('.')
    :%s/\s\+$//e
    call cursor(l, c)
endfunction

autocmd BufWritePre,filewritepre * :call RemoveTrailingSpaces()
