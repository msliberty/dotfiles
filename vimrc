set nobackup
set mouse=a

syntax on

set shiftwidth=4
set tabstop=4

set cindent

" allow backspace over anything in insert mode
set backspace=2

" use jk to exit insert mode instead of <esc>
inoremap jk <esc>
inoremap <esc> <nop>

filetype plugin indent on

colorscheme pablo
set ruler
set relativenumber
