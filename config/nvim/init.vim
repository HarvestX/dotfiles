let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

call plug#begin($CONFIG . "/nvim/plugged")
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
call plug#end()


" User configurations
set fenc=utf-8
set autoread
set autoindent
set showcmd
set showmatch
set wildmode=list:longest
set hlsearch
set clipboard+=unnamedplus

" Tab settings
set number
set tabstop=2
set shiftwidth=2
set expandtab

" nmap
nmap <Esc><Esc> :nohlsearch<CR><Esc>

