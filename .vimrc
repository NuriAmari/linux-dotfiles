set shell=/bin/bash
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" set wrap for markdown
autocmd FileType md setlocal wrap
" set tabwidth for c
autocmd FileType c setlocal shiftwidth=8 tabstop=8
autocmd FileType ocaml setlocal shiftwidth=2 tabstop=2
" replace tabs with spaces
set expandtab
" relative line numbers
set relativenumber
" line numbers
set number
" no linewrap
set nowrap
" always display the status bar
set laststatus=2
" syntax highlight
syntax enable
" autoindenting
set autoindent
set noshowmode
set mouse=a
" highlight search terms
set hlsearch
" show results as you type
set incsearch

" persistent undo
set undofile
set undodir=~/.vim/undo//

if exists('*mkdir')
  for s:dir in [ '/.vim/backup', '/.vim/swp', '/.vim/undo', '/.vim/tags', '/.vim/viminfo' ]
    if !isdirectory($HOME.s:dir)
      call mkdir($HOME.s:dir, 'p')
    endif
  endfor
endif

autocmd BufNewFile,BufRead * setlocal formatoptions-=r

set clipboard=unnamedplus

" set leader to space
map <Space> <Nop>
let g:mapleader="\<Space>"
let g:maplocalleader="\<Space>"

" better line navigation when linewrapping is one
nnoremap j gj
nnoremap k gk

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-w> <C-w>q
noremap <C-n> :NERDTreeToggle<CR>
noremap <C-f> :NERDTreeFind<CR>

" Better omnifunc mappings
inoremap <expr> <tab> pumvisible() ? "\<C-N>" : "\<tab>"
inoremap <expr> <S-tab> pumvisible() ? "\<C-P>" : "\<S-tab>"

" Fzf keybindings
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>m :FZFMru<CR>
nnoremap <leader>t :Tags<CR>

" use to quick refresh vim
noremap <leader>rr :source ~/.vimrc<CR>

" close vim if only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'pbogut/fzf-mru.vim'
Plug 'junegunn/fzf.vim'

"colour schemes
Plug 'itchyny/lightline.vim'

" quickly comment / uncomment blocks
Plug 'tpope/vim-commentary'

" change double quotes to single quotes fast
Plug 'tpope/vim-surround'

" git integration
Plug 'tpope/vim-fugitive'

" file tree viewer
Plug 'scrooloose/nerdtree'

" colorscheme
Plug 'morhetz/gruvbox'

" lightline colorscheme
Plug 'shinchu/lightline-gruvbox.vim'

" ale for white space fixing
Plug 'dense-analysis/ale'

" markdown syntax highlighting
Plug 'vim-pandoc/vim-pandoc-syntax'

" ts / tsx syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'
Plug 'MaxMEllon/vim-jsx-pretty'

" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Tag synchronization
Plug 'ludovicchabant/vim-gutentags'

call plug#end()

let g:gutentags_define_advanced_commands = 1
let g:gutentags_ctags_exclude = ["*.min.js", "*.min.css", "build", "vendor", ".git", "node_modules", "Debug", "test/lib", "*.mypy_cache/*", "compile_commands.json", "*.ccls-cache/*"]

set background=dark
colorscheme gruvbox
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'

" Ale configuration
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'cpp': ['clang-format'],
\   'html': ['prettier'],
\   'scss': ['prettier'],
\   'python': ['black'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'ocaml': ['ocamlformat', 'ocp-indent'],
\   'markdown': ['prettier'],
\}

let g:ale_ocaml_ocamlformat_options = '--enable-outside-detected-project'

let g:ale_linters = {
\   'cpp': ['ccls'],
\   'typescript': ['tsserver'],
\   'typescriptreact': ['tsserver'],
\   'python': ['pyls', 'mypy'],
\   'ocaml': ['merlin'],
\}

" let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

set exrc
set secure
set spell

let NERDTreeIgnore=['$*/\.mypy_cache/*', '$*/__pycache__/*']
let NERDTreeRespectWildIgnore=1

" Open files at the last location
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" ALE completion
call deoplete#custom#option('sources', {
\ '_': ['ale'],
\})

" ALE lsp mappings
nmap <silent> <leader>gd <Plug>(ale_go_to_definition)
nmap <silent> <leader>K <Plug>(ale_hover)
nmap <silent> <leader>gr <Plug>(ale_find_references)

function! ZathuraOpen()
    execute "!pandoc_convert " . expand('%:p')
    execute "!zathura " . expand('%:p')[0:-3] . 'pdf &'
endfunction

command Zathura :call ZathuraOpen()
