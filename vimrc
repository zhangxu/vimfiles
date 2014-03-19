runtime bundle/vim-pathogen/autoload/pathogen.vim

set nocompatible

"set rtp+=$GOROOT/misc/vim
"example of disable a specific plugin
"let g:pathogen_disabled = ['supertab']

call pathogen#infect()
syntax on
filetype plugin indent on
colorscheme molokai
hi StatusLine guifg=#bd0d74 guibg=#dddddd guisp=#dddddd gui=bold ctermfg=5 ctermbg=253 cterm=bold
hi Comment guifg=#5a5a5a guibg=#19191d guisp=#19191d gui=NONE ctermfg=240 ctermbg=234 cterm=NONE


"show line number
"set number

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
set guifont=Ubuntu\ Mono\ 11
"let g:CurrentFontSize=8

"show tabs and trailing spaces
set list
"set listchars=tab:>.,trail:.,nbsp:%,eol:¶
set listchars=tab:>.,trail:.,nbsp:%

"disable beep and enable visual blink on error
set noeb vb t_vb=

"alway insert spaces instead of tab
set tabstop=4
set shiftwidth=4
set expandtab

"<EOL> setting
"set fileformats=unix,dos
"set fileformat=unix

"set status line
set ruler
set laststatus=2
set statusline=%t[%P][%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %{buftabs#statusline()}

"show buftabs in statusline
let g:buftabs_in_statusline=1

"highlight search result
set hlsearch

"key mappings

"inoremap <C-S-Tab> <C-R>=delimitMate#JumpAny("\<S-Tab>")<CR>

"buffer
nmap <c-tab> :bnext<CR>
nmap <c-s-tab> :bprev<CR>
nmap <Leader>d :bw<CR>
nmap <Leader>k :BW<CR>
nmap <Leader>e :e<Space>

"tabs
nmap <tab>n :tabn<cr>
nmap <tab>p :tabp<cr>
nmap <tab>c :tabc<cr>

"window
nmap <silent> <Leader>w :wincmd w<cr>
"nmap <silent> mm :wincmd w<cr>
"nmap <silent> m= :wincmd =<cr>
"nmap <silent> mv :wincmd v<cr>
"nmap <silent> ms :wincmd s<cr>
"nmap <silent> mc :wincmd c<cr>
"nmap <silent> mo :wincmd o<cr>

"nmap <silent> <Leader>h :wincmd h<cr>
"nmap <silent> <Leader>j :wincmd j<cr>
"nmap <silent> <Leader>k :wincmd k<cr>
"nmap <silent> <Leader>l :wincmd l<cr>

"NERD tree
nmap <silent> <F2> :NERDTreeToggle<cr>
nmap <silent> <leader>f :NERDTreeFocus<cr>
nmap <leader>x :NERDTree<space>

"Taglist
"nmap <silent> <F3> :TlistToggle<cr>

"save buffer
"imap <C-s> <esc>:w<CR>li

"folding
"map ff zo
"map cc zc
"map FF zO
"map CC zC

"mimic windows copy/paste behavior
vmap <c-c> "+y
vmap <c-x> "+d
nmap <c-v> "+p
imap <c-v> <S-Insert>

"change window size
"nmap <Down> <C-W>-
"nmap <Up> <C-W>+
"nmap <Left> <C-W><
"nmap <Right> <C-W>>

"clear highlights
nmap <silent> <F7> :let @/=""<CR>


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
"autocmd GUIEnter * simalt ~x

" http://www.vim.org/scripts/script.php?script_id=687
if has('win32')
autocmd GUIEnter * :call libcallnr("vimtweak.dll", "SetAlpha", 220)
"autocmd GUIEnter * :call libcallnr("vimtweak.dll", "EnableMaximize", 1)
"autocmd GUIEnter * :call libcallnr("vimtweak.dll", "EnableCaption", 0)
"autocmd GUIEnter * :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
endif

" NERD tree settings {{{
let NERDTreeBookmarksFile=expand("~/.vim/.NERDTreeBookmarks")
let NERDTreeShowBookmarks=1
let NERDTreeWinSize=41
let NERDTreeDirArrows=1
let NERDTreeIgnore=['\~$', 'target$[[dir]]', '.pyc', '.db']
" }}}

" Taglist settings {{{
"let Tlist_GainFocus_On_ToggleOpen=1
"let Tlist_Exit_OnlyWindow=1
"let Tlist_Use_Right_Window=1
"let Tlist_File_Fold_Auto_Close=1
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

let tlist_scala_settings='scala;c:class;o:objects;C:case classes;O:case objects;d:methods;t:traits;L:values;l:variables;T:types;p:packages;i:imports;I:implicits'

let g:SuperTabMappingForward = '<s-space>'
let g:SuperTabMappingBackward = '<s-c-space>'

autocmd FileType taglist cnoreabbrev <buffer> bd <nop>
autocmd FileType taglist cnoreabbrev <buffer> bnext <nop>
autocmd FileType taglist cnoreabbrev <buffer> bprev <nop>

autocmd FileType qf cnoreabbrev <buffer> bd <nop>
autocmd FileType qf cnoreabbrev <buffer> bnext <nop>
autocmd FileType qf cnoreabbrev <buffer> bprev <nop>

au FileType scala let b:delimitMate_quotes = ""
au FileType py let b:delimitMate_quotes = ""

let g:ConqueTerm_CloseOnEnd = 1

function! SetGfn()
python << EOF
import vim
import os, os.path

gfn = '/'.join([os.environ['HOME'], '.vim/.gfn'])

if os.path.isfile(gfn):
    with open(gfn) as f:
        s = f.readline()
        if s.strip() != '':
           vim.command('set gfn=%s' % s)

EOF

endfunction

call SetGfn()

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=lightgray    ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=lightgray ctermbg=4

let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

