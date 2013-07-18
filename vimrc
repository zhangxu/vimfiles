set nocompatible

"example of disable a specific plugin
"let g:pathogen_disabled = ['supertab']

call pathogen#infect()
syntax on
filetype plugin indent on
colorscheme molokai
hi Comment guifg=#008000

"show line number
set number

"highlight current line
set cursorline

"disable menu bar
"set go-=m go-=r
set guioptions=

"disable backup
set nobackup

"disable swap file
"set noswapfile
if has("win32")
    set directory=$TMP
endif

"disable the ~/_viminfo file
set viminfo=""

"set font
set gfn=Lucida\ Console:h10:cANSI
"set gfn=ProggySquareTTSZ:h14:cANSI
"set gfn=ProggyCleanTTSZ:h14:cANSI

"show tabs and trailing spaces
set list
set listchars=tab:>.,trail:.,nbsp:%,eol:�

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
set laststatus=2
set statusline=%t[%P][%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %{buftabs#statusline()}

"show buftabs in statusline
:let g:buftabs_in_statusline=1

"highlight search result
set hlsearch

"key mappings

inoremap <C-S-Tab> <C-R>=delimitMate#JumpAny("\<S-Tab>")<CR>

"help
"map <F1> :help<Space>

"buffer
map <c-tab> :bnext<CR>
map <c-n> :tabn<CR>
map <c-S-tab> :bprev<CR>
map <c-p> :tabp<CR>
map ,l :ls<CR>
map ,d :bd<CR>
map ,c :tabc<CR>
map ,D :BD<CR>
map ,e :e<Space>
map ,E :tabe<Space>
map ,x :Explore<Space>

"folding
map ff zo
map cc zc
map FF zO
map CC zC

"mimic windows copy/paste behavior
vmap <c-c> "+y
vmap <c-x> "+d
nmap <c-v> "+p
imap <c-v> <S-Insert>

"change window size
nmap <Down> <C-W>-
nmap <Up> <C-W>+
nmap <Left> <C-W><
nmap <Right> <C-W>>

"clear highlights
nmap <F7> :let @/=""<CR>

"bubble line(s)
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

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
        let cmd = '!scala.bat -unchecked -deprecation '. expand('%')
        exec(cmd)
    elseif match(filename, "\.gradle$") > 0
        let cmd = '!gradle.bat -b ' . expand('%') . ' ' . input('task: ') . ' ' . input('-D parameters: ')
        exec(cmd)
    elseif match(filename, "\.bat$") > 0
        let cmd = '!' . expand('%') . ' ' . input('parameters: ')
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

" remove trailing spaces on save
autocmd BufWritePre,filewritepre * :call RemoveTrailingSpaces()

" To maximize the initial Vim window under Windows
autocmd GUIEnter * simalt ~x

" http://www.vim.org/scripts/script.php?script_id=687
autocmd GUIEnter * :call libcallnr("vimtweak.dll", "SetAlpha", 200)

" netrw settings {{{
let g:netrw_liststyle=3
let g:netrw_alto=1
let g:netrw_browse_split=4
"let g:netrw_list_hide=".*\.swp,.*\.git,.*\.svn,.*\.hg,target,bin,.*\.settings,.*\.class,.*\.pyc,\.classpath,\.project"
let g:netrw_list_hide='.*\.swp,.*\.pyc,.*\.class,^\.svn'
let g:netrw_sort_by="name"
let g:netrw_silent = 1
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_winsize=50

" }}}

" Convert slashes to backslashes for Windows.
if has('win32')
  nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nmap ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nmap ,cs :let @*=expand("%")<CR>
  nmap ,cl :let @*=expand("%:p")<CR>
endif

nnoremap <A-=> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)+1)',
 \ '')<CR>
nnoremap <A--> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)-1)',
 \ '')<CR>

let g:cursize=10

nnoremap <A-0> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(g:cursize)',
 \ '')<CR>

