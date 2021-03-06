""""""""""""""""""
" General settings
""""""""""""""""""
let mapleader=","  "Leaderkey
set number         "Show line numbers
set ruler          "Show cursor position
"set paste          "Paste from other places 
syntax enable      "Enable syntax highlighting
set hidden         "Allows buffers to be hidden
set ignorecase     "Use case insensitive search
set smartcase      "Except when using capital letters
set nowrap         "Disable word wraping
set sidescroll=1   "Scroll one character at a time
set hlsearch       "Enables highlighting for searches
set splitright     "Open new splits in the right side
set splitbelow     "Open new splits below the current
set backspace=2    "Allow backspacing over everything
set laststatus=2   "Always display the statusline in all windows
set showtabline=2  "Always display the tabline, even if there is only one tab
set noshowmode     "Hide the default mode text (e.g. -- INSERT -- below the statusline)
set encoding=utf-8 "YouCompleteMe requires UTF-8 encoding
"set mouse=a         

" Colorscheme and highlighting 
colorscheme monokai
hi! Visual term=reverse cterm=reverse guibg=LightGrey
hi! Search ctermfg=235 ctermbg=186
hi! link IncSearch StatusLineTerm

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Powerline
" set rtp+=$HOME/.local/lib/python3.6/site-packages/powerline/bindings/vim/
set rtp+=/home/agarrido/.local/lib/python3.7/site-packages/powerline/bindings/vim


" Toggles highlight search
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

" clear highlighted search
noremap <leader><cr> :set hlsearch! hlsearch?<cr>

" Turn on highlight search  without moving the cursor 
nnoremap * :set hlsearch<CR>*N:%s///gn<CR>
nnoremap # :set hlsearch<CR>#N

" Search for visually selected text 
vnoremap // y/\V<C-R>"<CR>

" Save with Ctrl-S
noremap  <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>gv
inoremap <silent> <C-S> <C-O>:update<CR><Esc>

" Save and exit with Ctrl-X
noremap  <silent> <C-X> :wq!<CR>
vnoremap <silent> <C-X> <Esc>:wq!<CR>

" Insert newline without entering insert mode
nmap o o<Esc>

" Disable macro recording
"map q <Nop>

" Replace selected text with yank in visual mode
vmap r "_dP

" Suspend vim in insert mode
inoremap <c-z> <Esc><c-z>

" Comment out a block of code
vnoremap <silent> # :s/^/#/<cr>:noh<cr>
vnoremap <silent> -# :s/^#//<cr>:noh<cr>

""""""""""""""""""
" F-keys
""""""""""""""""""
" F1: Toggle line numbers
map <F1> :set invnumber<CR>

" F2: Autoindent toggle and visual feedback
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" F3: Toggle easily with F3
map <F3> :NERDTreeToggle<CR>

" F4: Gundo TODO 
"nnoremap <F4> :GundoToggle<CR>

" F5: Save & Compile Python
nnoremap <F5> :update<bar>!python -m py_compile %<CR>

" F6: Pylinttoogle  
map <F6> :PymodeLint<CR>

" F7: Clean sign column  
map <F7> :sign unplace *<CR>

" F8: Toogle word wrap
map <F8> :set wrap!<CR>

""""""""""""""""""
" Tabs
""""""""""""""""""
" New tab
nnoremap <C-t> :tabnew<CR>

" Move to the next tab
nnoremap  J gt 

" Move to the previous tab
nnoremap  K gT

""""""""""""""""""
" Splits 
""""""""""""""""""
"Map ctrl-j/k/h/l to switch between splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

""""""""""""""""""
" Buffers
""""""""""""""""""

" To open a new empty buffer
nnoremap <leader>t :enew<CR>

" Move to the next buffer
nnoremap L :bnext<CR>
"nmap <leader>l :bnext<CR>

" Move to the previous buffer
nnoremap H :bprevious<CR>
"nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
nnoremap <leader>q :bp <BAR> bd #<CR>

" Wipe the current buffer and move to the previous one
nnoremap <leader>w :bp <BAR> bw! #<CR>

" List the available buffers and prepare :b for you
nnoremap <Leader>b :ls<CR>:b<Space>

""""""""""""""""""
" Folds
""""""""""""""""""
set foldlevelstart=99
nnoremap <Space> za
"nnoremap <S-Space> zA
"vnoremap <S-Space> zA

"""""""""""""""""
" Terminal
""""""""""""""""""
if(has('terminal'))
    tnoremap <C-j> <C-w>j
    tnoremap <C-k> <C-w>k
    tnoremap <C-h> <C-w>h
    tnoremap <C-l> <C-w>l
    execute "set <M-l>=\el"
    execute "set <M-h>=\eh"
    tnoremap <M-l> <C-W>:bnext<CR>	
    tnoremap <M-h> <C-W>:bprevious<CR>	
    "tnoremap <C-Left>  :bnext<CR>	
    "tnoremap <C-Right> :bprevious<CR>	
    tnoremap <ESC><ESC> <C-\><C-N>
    tnoremap <C-w>t <C-w>:tabnext<CR>
endif

""""""""""""""""""
" Copy-Paste
""""""""""""""""""
" Using the system clipboard
map <C-y> "+y
map <C-p> "+p

" Set paste when pasting in insert mode
inoremap <silent> <Insert> <C-O>:set paste<CR>

" Make shift-insert work like in Xterm
" map <S-Insert> <MiddleMouse>
" map! <S-Insert> <MiddleMouse>

" Paste in insert mode
" inoremap <C-v> <F2><C-r>+<F2>

" paste tweak (automatically toggle paste-nopaste)
"function! WrapForTmux(s)
"  if !exists('$TMUX')
"    return a:s
"  endif
"  let tmux_start = "\<Esc>Ptmux;"
"  let tmux_end = "\<Esc>\\"
"  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
"endfunction
"let &t_SI .= WrapForTmux("\<Esc>[?2004h")
"let &t_EI .= WrapForTmux("\<Esc>[?2004l")
"function! XTermPasteBegin()
"  set pastetoggle=<Esc>[201~
"  set paste
"  return ""
"endfunction
"inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
" If editing clucontrol disable some plugings
autocmd VimEnter * if expand('%:t') == 'clucontrol.py'  | set redrawtime=10000 | endif

""""""""""""""""""
" Vim-plug
""""""""""""""""""

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

"Plug 'scrooloose/nerdtree'
Plug 'bogado/file-line'
Plug 'haya14busa/incsearch.vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-obsession'
Plug 'irrationalistic/vim-tasks'
Plug 'dhruvasagar/vim-prosession'
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] } "Loads only when opening NERDTree
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Raimondi/delimitMate'
if has('python') && (v:version >= 704 &&  @% != 'ovm/clucontrol.py')
   Plug 'tmhedberg/SimpylFold'
   Plug 'python-mode/python-mode', { 'branch': 'develop' }
   Plug 'Valloric/YouCompleteMe', { 'do': function('hooks#YCMInstall') }
   "Plug '~/.vim/plugged/YouCompleteMe'
   "Plug 'Valloric/YouCompleteMe', { 'do' : '/bin/python2 ~/.vim/plugged/YouCompleteMe/install.py ' }
endif
"themes
Plug 'reewr/vim-monokai-phoenix'
"Plug 'jnurmine/Zenburn'

" Initialize plugin system
call plug#end()

""""""""""""""""""
" Plugin settings
""""""""""""""""""

" Incsearch mappings 
map /  <Plug>(incsearch-forward)

" ycm
" let g:ycm_key_invoke_completion = '<C-b>'
let g:ycm_disable_for_files_larger_than_kb = 700

" nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$']

" pymode (python 2 syntax checking)
let g:pymode_python = 'python'
"let g:pymode_indent = 1
"let g:pymode_rope = 0
"let g:pymode_doc_bind = '<leader>d'
nnoremap <leader>l :PyLint<cr> 
" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = '<C-]>'
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_run_bind = '<leader>r'
let g:pymode_lint_on_write = 0
let g:pymode_lint_message = 1
let g:pymode_lint_ignore = ["E501", "W",]
let g:pymode_lint_checkers = ['pep8']
"let g:pymode_options_colorcolumn = 0
" Pylint configuration file
"let g:pymode_lint_config = '$HOME/.pylint.rc'
"let g:pymode_options_max_line_length=120

" symplyfold
let g:SimpylFold_fold_import = 0
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0
