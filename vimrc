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
set laststatus=2
set statusline=%t[%P][%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %{buftabs#statusline()}

"show buftabs in statusline
:let g:buftabs_in_statusline=1

"highlight search result
set hlsearch

"key mappings

inoremap <C-S-Tab> <C-R>=delimitMate#JumpAny("\<S-Tab>")<CR>

"buffer
nmap <c-tab> :bnext<CR>
nmap <Leader>d :bw<CR>
nmap <Leader>D :BW<CR>
nmap <Leader>e :e<Space>

nmap <silent> mm :wincmd w<cr>
nmap <silent> m= :wincmd =<cr>
nmap <silent> mv :wincmd v<cr>
nmap <silent> ms :wincmd s<cr>
nmap <silent> mc :wincmd c<cr>
nmap <silent> mo :wincmd o<cr>

nmap <silent> mh :wincmd h<cr>
nmap <silent> mj :wincmd j<cr>
nmap <silent> mk :wincmd k<cr>
nmap <silent> ml :wincmd l<cr>

"NERD tree
nmap <silent> <F2> :NERDTreeToggle<cr>
nmap <silent> <leader>f :NERDTreeFocus<cr>
nmap <leader>x :NERDTree<space>
nmap <silent> <leader>b :Bookmark<cr>

"Taglist
nmap <silent> <F3> :TlistToggle<cr>

"save buffer
imap <C-s> <esc>:w<CR>li

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
nmap <silent> <F7> :let @/=""<CR>

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

" remove trailing spaces on save
autocmd BufWritePre,filewritepre * :call RemoveTrailingSpaces()

" To maximize the initial Vim window under Windows
autocmd GUIEnter * simalt ~x

" http://www.vim.org/scripts/script.php?script_id=687
autocmd GUIEnter * :call libcallnr("vimtweak.dll", "SetAlpha", 200)

" NERD tree settings {{{
let NERDTreeBookmarksFile=expand("$VIM/vimfiles/.NERDTreeBookmarks")
let NERDTreeShowBookmarks=1
let NERDTreeShowLineNumbers=1
" }}}

" Taglist settings {{{
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_File_Fold_Auto_Close=1
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

