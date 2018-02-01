
" -----------------------------------------------------------------------------
" Vim-Latex - Sept-6-2017
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a single file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" -----------------------------------------------------------------------------
" <Leader> keys is ','
let mapleader=","

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" execute pathogen#infect()
" filetype plugin indent on

au BufRead *access.log* setf httplog

" Save swap files in tmp directories, not current directory:
"set directory=~/Private/tmp//,.,/var/tmp//,/tmp//
set directory=$HOME/tmp//

setlocal cm=blowfish2
set number

" http://vim.wikia.com/wiki/Restoring_indent_after_typing_hash :
"set smartindent
"set cindent
"set cinkeys-=0#
"set indentkeys-=0#

" ---------------------- Haskell vim proto --------------------
" http://www.stephendiehl.com/posts/vim_2016.html
set nocompatible
set nowrap
set showmode
set tw=80
set smartcase
set smarttab
set smartindent
set autoindent
set softtabstop=2
set incsearch
"set mouse=a
set clipboard=unnamedplus,autoselect
set completeopt=menuone,menu,longest

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

set t_Co=256
set cmdheight=1

execute pathogen#infect()

" == ghc-mod ==

map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" == supertab ==

let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

" == neco-ghc ==

let g:haskellmode_completion_ghc = 1
" autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" == nerd-tree ==

map <Leader>n :NERDTreeToggle<CR>

" == tabular ==

let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>
vmap a, :Tabularize /<-<CR>
vmap al :Tabularize /[\[\\|,]<CR>

" == ctrl-p ==

map <silent> <Leader>t :CtrlP()<CR>
noremap <leader>b<space> :CtrlPBuffer<cr>
let g:ctrlp_custom_ignore = '\v[\/]dist$'

" == syntastic ==
map <Leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" ---------------------- ------- -----------------------------
" Fix arrow keys in tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
" ---------------------- ------- -----------------------------

set tabstop=2
set shiftwidth=2
set expandtab

" highlight search, and colorcolor
set hlsearch
hi Search cterm=NONE ctermfg=white ctermbg=darkgreen

" GVIM settings:
"color slate
"set guifont=-b&h-monospace-medium-r-normal-*-*-140-*-*-m-*-iso8859-15

set background=dark "light "dark

syntax on
filetype plugin indent on
au BufRead,BufNewFile *.ic set filetype=scheme
au BufRead,BufNewFile *.pde set filetype=java
au BufRead,BufNewFile *.blog set filetype=blog
au BufRead,BufNewFile *.cup set filetype=cup
au BufRead,BufNewFile *.hs set filetype=haskell
au BufRead,BufNewFile makefile.rules set filetype=make
au BufRead,BufNewFile vimrc set filetype=vim
au BufRead,BufNewFile ghci set filetype=haskell
au BufRead,BufNewFile .ghci set filetype=haskell
au BufRead,BufNewFile *.job set filetype=cfg
autocmd FileType make setlocal noexpandtab

autocmd FileType python setlocal shiftwidth=2
autocmd FileType python setlocal tabstop=2

command W w
set title
"set mouse=a

"set spell spelllang=en_us

function! CommandCabbr(abbreviation, expansion)
  execute 'cabbr ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction
command! -nargs=+ CommandCabbr call CommandCabbr(<f-args>)
" Use it on itself to define a simpler abbreviation for itself.
CommandCabbr ccab CommandCabbr

match ErrorMsg '\%>180v.\+'

