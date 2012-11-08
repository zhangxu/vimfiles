set nocompatible

"example of disable a specific plugin
"let g:pathogen_disabled = ['supertab']

call pathogen#infect()
syntax on
filetype plugin indent on
colorscheme molokai

"show line number
set number

"disable menu bar
set go-=m go-=r

"disable backup
set nobackup

"disable the ~/_viminfo file
set viminfo=""

"set font
set gfn=Inconsolata:h11:cANSI

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
"
"netrw hiding list see http://vimdoc.sourceforge.net/htmldoc/pi_netrw.html#g:netrw_list_hide
let g:netrw_list_hide=".*\.swp,.*\.git,.*\.svn,.*\.hg,target,bin,\.settings,\.class,\.pyc,\.classpath,\.project"

"key mappings

inoremap <C-S-Tab> <C-R>=delimitMate#JumpAny("\<S-Tab>")<CR>

"help
map <F1> :help<Space>

"buffer
map <c-n> :bnext<CR>
map <c-tab> :bnext<CR>
map <c-p> :bprev<CR>
map <c-S-tab> :bprev<CR>
map ,l :ls<CR>
map ,d :bd<CR>
map ,D :BD<CR>
map ,e :e<Space>
map ,x :Explore<Space>

"folding
"map ,o zo
"map ,c zc
"map ,O zO
"map ,C zC

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

nmap <F5> :call RunThis()<CR>
nmap <F6> :call DebugThis()<CR>

"clear highlights
nmap <F7> :let @/=""<CR>

"Ack searching
nmap ack :Ack<space>

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

" remove trailing spaces on save
autocmd BufWritePre,filewritepre * :call RemoveTrailingSpaces()

" To maximize the initial Vim window under Windows
autocmd GUIEnter * simalt ~x

" netrw settings {{{
:let g:netrw_liststyle = 1
augroup ADS_dirchange
   au!
   if version >= 700
      " Make automatic directory changing work with netrw
      let g:netrw_keepdir = 0
      au BufFilePost,BufEnter * if !isdirectory(expand('<afile>')) | sil! cd %:p:h | endif
   else
      au BufFilePost,BufEnter * sil! cd %:p:h
   endif
augroup END
" }}}
