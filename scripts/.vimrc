set number        "Show line numbers
set ruler         "Show cursor position
set paste         "Paste from other places 
syntax enable     "Enable syntax highlighting
set ignorecase    "Use case insensitive search
set smartcase     "Except when using capital letters
set nowrap        "Disable word wraping
set sidescroll=1  "Scroll one character at a time
set hlsearch      "Enables highlighting for searches
set laststatus=2  "Always show statusline
set backspace=2   "Allow backspacing over everything

" Colorscheme and highlighting 
colorscheme monokai
hi! Visual term=reverse cterm=reverse guibg=LightGrey

" Powerline
set rtp+=$HOME/.local/lib/python2.6/site-packages/powerline/bindings/vim/

" New tab
nmap <C-t> :tabnew<CR>

" Move to the next tab
nnoremap <silent> <C-m> :tabnext<CR>
inoremap <silent> <C-m> :tabnext<CR>
vnoremap <silent> <C-m> :tabnext<CR>

" Move to the previous tab
nnoremap <silent> <C-l> :tabprevious<CR>
inoremap <silent> <C-l> :tabprevious<CR>
vnoremap <silent> <C-l> :tabprevious<CR>

" Alt+arrow will change the window
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Toggles highlight search
nnoremap  <silent> <C-h> :silent! nohls<CR>
nnoremap * :set hlsearch<CR>*N
nnoremap # :set hlsearch<CR>#N

" Set and unset line numbers
noremap <C-N><C-N> :set invnumber<CR>
inoremap <C-N><C-N> :set invnumber<CR>

" Save with Ctrl-S
noremap <silent> <C-S>  :update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>gv

" Save and exit with Ctrl-X
noremap  <silent> <C-X>  :wq!<CR>
inoremap <silent> <C-X> <Esc>:wq!<CR>
vnoremap <silent> <C-X> <Esc>:wq!<CR>

" Settings for coding python (Minimal configuration):
set autoindent   " Do smart autoindenting when starting a new line
set shiftwidth=4  " Set number of spaces per auto indentation
set expandtab     " When using <Tab>, put spaces instead of a <tab> character

" Good to have for consistency
set tabstop=4   " Number of spaces that a <Tab> in the file counts for
set smarttab    " At <Tab> at beginning line inserts spaces set in shiftwidth

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'haya14busa/incsearch.vim'
" Plug 'osyo-manga/vim-precious'

" Initialize plugin system
call plug#end()

" F6: Toggle easily with F6
map <F6> :NERDTreeToggle<CR>

" Incsearch mappings 
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
