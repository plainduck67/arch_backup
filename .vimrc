syntax on
colorscheme unokai
let mapleader=" "
set number
set cursorline
set relativenumber
filetype indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set incsearch
set hlsearch
set ignorecase
set smartcase
set cindent
set wrap
set linebreak
set incsearch
set hlsearch
set clipboard=unnamedplus
set undofile
let g:netrw_winsize = 20
let g:netrw_browse_split = 3
nnoremap <leader>h :nohlsearch<CR>
nnoremap <C-q> :if &filetype == 'netrw' \| q \| else \| Vex \| endif<CR>
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap <C-h> <left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
nnoremap H gT
nnoremap L gt
