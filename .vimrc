" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'vifm/vifm.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'scrooloose/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'ap/vim-css-color'
Plugin 'ptzz/lf.vim'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'voldikss/vim-floaterm'
Plugub 'catppuccin/vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin on    " required
filetype indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on
"

" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" Turn on syntax highlighting
syntax on

" let mapleader = ","

" Security
set modelines=0

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap!
set textwidth=0
"set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip
map <leader>c :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>

" ino " ""<left>
" ino ' ''<left>
" ino ( ()<left>
" ino [ []<left>
" ino { {}<left>
ino {<CR> {<CR>}<ESC>O

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
set termiinalgui
colorscheme catppuccin

" Save folds
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent loadview
augroup END

" => Vifm
"map <Leader>vv  :Vifm<CR>
"map <Leader>vs  :VsplitVifm<CR>
"map <Leader>sp  :SplitVifm<CR>
"map <Leader>dv  :DiffVifm<CR>
"map <Leader>tv  :TabVifm<CR>

" NERDTree Settings
nmap <C-t>  :NERDTreeToggle<CR>

" Floaterm hotkey
map <leader>t :FloatermNew<CR>

" open NERDTree automatically
"autocmd VimEnter * NERDTree
autocmd BufEnter * set number relativenumber

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" map F2 to set pastetoggle
set pastetoggle=<F2>

"set directory=~/.vim/view/
"set backupdir=~/.vim/backup/
