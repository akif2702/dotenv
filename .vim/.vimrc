
let mapleader=","
set nocompatible
set number                " Show numbers on the left
set hlsearch              " Highlight search results
set ignorecase            " Search ingnoring case
set smartcase             " Do not ignore case if the search patter has uppercase
set noerrorbells          " I hate bells
set belloff=esc
set tabstop=4             " Tab size of 4 spaces
set softtabstop=4         " On insert use 4 spaces for tab
set shiftwidth=4
set expandtab             " Use apropiate number of spaces
set nowrap                " Wrapping sucks (except on markdown)
set mouse=a               " Enable mouse on all modes
set clipboard=unnamed,unnamedplus     " Use the OS clipboard
set showmatch
set termguicolors
set splitright splitbelow
set backspace=indent,eol,start " Backspace work like other editors
set list lcs=tab:\¦\      "(here is a space)
let &t_SI = "\e[6 q"      " Make cursor a line in insert
let &t_EI = "\e[2 q"      " Make cursor a line in insert

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

filetype plugin on
syntax on			" syntax highlight
syntax enable
set hlsearch		" search highlighting
set clipboard=unnamed	" yank to the system register (*) by default
set showmatch		" Cursor shows matching ) and }
set showmode		" Show current mode
set autoindent		" auto indentation
set incsearch		" incremental search
colorscheme monokai


"--------------------------------------------------------------------------- 
" ENCODING SETTINGS
"--------------------------------------------------------------------------- 
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,big5,latin1



" Install vim-plug for vim and neovim
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Ctags
set tags=tags

" Enable omni for all types and auto set it
" [Recomended]
set omnifunc=syntaxcomplete#Complete

" Plugins
call plug#begin('~/.vim/plugged')
" Plugins here !!!!
Plug 'Townk/vim-autoclose'
Plug 'preservim/tagbar'
Plug 'preservim/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'sickill/vim-monokai'
call plug#end()


"Keymap
nmap <C-H> :NERDTreeToggle<CR>
nmap <C-N> :NERDTreeClose<CR>
nmap <C-P> :TagbarToggle<CR>
nmap <C-S> :TagbarClose<CR>
nnoremap <leader>o <C-]>
nnoremap <leader>b <C-t>
