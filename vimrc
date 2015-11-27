
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" execute pathogen#infect()
" filetype plugin indent on

au BufRead *access.log* setf httplog


" Save swap files in tmp directories, not current directory:
set directory=~/Private/tmp//,.,/var/tmp//,/tmp//

set number
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set hlsearch

" GVIM settings:
"color slate
"set guifont=-b&h-monospace-medium-r-normal-*-*-140-*-*-m-*-iso8859-15

set background=dark "light "dark
syntax on
au BufRead,BufNewFile *.ic set filetype=scheme
au BufRead,BufNewFile *.pde set filetype=java
au BufRead,BufNewFile *.blog set filetype=blog
au BufRead,BufNewFile *.cup set filetype=cup
au BufRead,BufNewFile *.hs set filetype=haskell
au BufRead,BufNewFile makefile.rules set filetype=make
au BufRead,BufNewFile vimrc set filetype=vimrc
autocmd FileType make setlocal noexpandtab

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

