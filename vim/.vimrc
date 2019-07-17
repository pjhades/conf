set shell=bash
set nocompatible
filetype off

let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

syntax enable
syntax on

set encoding=utf-8
set fileencoding=utf-8

au BufNewFile,BufReadPost *.md set filetype=markdown
au BufNewFile,BufReadPost *.rkt,*.rktl set filetype=racket
au BufNewFile,BufReadPost *.toml set filetype=toml
au BufNewFile,BufReadPost *.ijs set filetype=j
au filetype makefile set noexpandtab
au filetype python set indentkeys-=<:>
au filetype scheme,racket set lisp

set laststatus=2
set number
set ruler
set showcmd
set incsearch
set nowrapscan
set nobackup
set nowrap
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab

if filereadable("cscope.out")
	cs add cscope.out
endif

nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>r :cs reset<CR>

nnoremap tn :tabnext<CR>
nnoremap tp :tabprev<CR>

set t_Co=256
colorscheme apprentice
