set number        "Show line numbers
set ruler         "Show cursor position
set paste         "Paste from other places 
syntax enable     "Enable syntax highlighting
set ignorecase    "Use case insensitive search
set smartcase     "Except when using capital letters
set nowrap        "Disable word wraping
set sidescroll=1  "Scroll one character at a time
set laststatus=2  "Always show statusline


" Colorscheme and highlighting 
colorscheme monokai
hi! Search cterm=NONE,reverse gui=NONE,reverse ctermfg=3 guifg=#b58900 ctermbg=NONE guibg=NONE
hi! link Todo YellowR

" Powerline
set rtp+=$HOME/.local/lib/python2.6/site-packages/powerline/bindings/vim/

" New tab
nmap <C-t> :tabnew<CR>

" Move to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>

" Move to the next tab
nnoremap <silent> <C-m> :tabnext<CR>
inoremap <silent> <C-m> :tabnext<CR>
vnoremap <silent> <C-m> :tabnext<CR>

" Move to the previous tab
nnoremap <silent> <C-n> :tabprevious<CR>
inoremap <silent> <C-n> :tabprevious<CR>
vnoremap <silent> <C-n> :tabprevious<CR>

" Turn off highlight search
nnoremap  <C-h> :nohlsearch<CR>
inoremap  <C-h> :nohlsearch<CR>
vnoremap  <C-h> :nohlsearch<CR>

" Set and unset line numbers
noremap <C-N><C-N> :set invnumber<CR>
inoremap <C-N><C-N> :set invnumber<CR>

" Save with Ctrl-S
noremap <silent> <C-S>  :update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>gv






