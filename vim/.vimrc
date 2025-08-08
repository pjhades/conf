call plug#begin()
Plug 'junegunn/fzf.vim'
Plug 'flazz/vim-colorschemes'
Plug 'prabirshrestha/vim-lsp'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
call plug#end()

set shell=bash
set nocompatible
set backspace=indent,eol,start
filetype off

set rtp+=/usr/local/opt/fzf

let g:rustfmt_autosave = 1

let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_highlights_delay = 200
let g:lsp_diagnostics_signs_enabled = 0
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_preview_keep_focus = 0
let g:lsp_preview_autoclose = 0
let g:lsp_preview_float = 1
let g:lsp_hover_ui = 'preview'

if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \   'name': 'Rust Language Server',
        \   'cmd': {server_info->['rust-analyzer']},
        \   'allowlist': ['rust'],
        \   'initialization_options': {
        \     'checkOnSave': v:false,
        \     'diagnostics': {
        \       'enable': v:false,
        \     },
        \   },
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    "setlocal signcolumn=yes
    nmap <C-\>h <plug>(lsp-hover)
    nmap <C-\>d <plug>(lsp-definition)
    nmap <C-\>e <plug>(lsp-next-diagnostic)
    nmap <C-\>E <plug>(lsp-previous-diagnostic)
    nmap <C-\>r <plug>(lsp-references)
    nmap <C-\>a <plug>(lsp-code-action)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

let g:fzf_preview_window = ['up:50%']
let g:fzf_layout = {'right': '100%'}

syntax enable
syntax on

set encoding=utf-8
set fileencoding=utf-8

au BufNewFile,BufReadPost *.md set filetype=markdown
au BufNewFile,BufReadPost *.rkt,*.rktl set filetype=racket
au BufNewFile,BufReadPost *.ijs set filetype=j
au filetype makefile set noexpandtab
au filetype python set indentkeys-=<:>
au filetype scheme,racket set lisp
au filetype c,cpp set cindent
au filetype go call SetVimGoKeyBindings()

set laststatus=2
set number
set ruler
set showcmd
set hlsearch
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
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>r :cs reset<CR>
endif

function! SetVimGoKeyBindings()
    nmap <C-\>d :GoDef<CR>
    nmap <C-\>c :GoCallers<CR>
    nmap <C-\>r :GoReferrers<CR>
endfunction

nnoremap tn :tabnext<CR>
nnoremap tp :tabprev<CR>

nnoremap <C-\>f :Files<CR>
nnoremap <C-\>g :Rg<CR>
nnoremap <C-\>w :Rg <C-r><C-w><CR>

inoremap <C-\>{ {<CR>}<Esc>O

set t_Co=256
colorscheme janah

" Run netrw automatically if vim is invoked with no argument
autocmd VimEnter * if argc() == 0 | Explore | endif
" Use long format display in netrw
let g:netrw_liststyle = 1
