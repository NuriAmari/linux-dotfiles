set shell=/bin/bash
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" change to 2 for js
autocmd FileType cpp setlocal shiftwidth=4 tabstop=4
" set wrap for markdown
autocmd FileType md setlocal wrap
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
set smartindent
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
set completeopt=menuone,noselect

" Fzf keybindings
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>m :History<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>n :Marks<CR>
nnoremap <leader>s :Rg<CR>

" use to quick refresh vim
noremap <leader>rr :source ~/.config/nvim/init.vim<CR>

" close vim if only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" install plug if not already installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
"lsp
Plug 'neovim/nvim-lspconfig'

"fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"lsp
Plug 'neovim/nvim-lspconfig'

"colour schemes
Plug 'itchyny/lightline.vim'

" quickly comment / uncomment blocks
Plug 'tpope/vim-commentary'

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

call plug#end()

set background=dark
colorscheme gruvbox
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'

" Ale configuration
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'cpp': ['clang-format'],
\   'python': ['black'],
\}

let g:ale_fix_on_save = 0
let g:ale_linters_explicit = 1

" pick up .nvimrc if present
set exrc
set secure

let NERDTreeIgnore=['$*/\.mypy_cache/*', '$*/__pycache__/*']
let NERDTreeRespectWildIgnore=1

" nvim lsp integeration
nnoremap <silent> <leader>gd <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader><c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>ga    <cmd>lua vim.lsp.buf.codeAction()<CR>
nnoremap <silent> <leader>gt <cmd> lua vim.lsp.buf.typeDefinition()<CR>
nnoremap <silent> <leader>gi <cmd> lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>gh <cmd> lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>h :ClangdSwitchSourceHeader<CR>

" lsp configuration
lua << EOF
require'lspconfig'.clangd.setup{
    root_dir = require'lspconfig'.util.root_pattern("compile_commands.json") or dirname
}
EOF

" Open files at the last location
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
