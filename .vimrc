" leader
let mapleader = ' '

" others
set backspace=indent,eol,start  " make that backspace key work the way it should
set whichwrap+=<,>,h,l
set encoding=UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" syntax
syntax on

" history : how many lines of history VIM has to remember
set history=1000

" filetype vi
filetype off
" Enable filetype plugins
filetype plugin indent on

" base
set nocompatible                " don't bother with vi compatibility
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set shortmess=atI

set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title
set nobackup                    " do not keep a backup file

set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
set visualbell t_vb=            " turn off error beep/flash
set t_vb=
set tm=500


" show location
set cursorcolumn
set cursorline


" movement
set scrolloff=7                 " keep 3 lines when scrolling


" show
set ruler                       " show the current row and column
set relativenumber                      " show line numbers
set nowrap
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis


" search
set hlsearch                    " highlight searches
set incsearch                   " do incremental searching, search as you type
set ignorecase                  " ignore case when searching
set smartcase                   " no ignorecase if Uppercase char present


" tab
set expandtab                   " expand tabs to spaces
set smarttab
set shiftround

" indent
set autoindent smartindent shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4                " insert mode tab and backspace use 4 spaces

" select & complete
set selection=inclusive
set selectmode=mouse,key

set completeopt=longest,menu
set wildmenu                           " show a navigable menu for tab completion"
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class
" ============================ theme and status line ============================

" theme
set background=dark
colorscheme desert

" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" status line
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2   " Always show the status line - use 2 lines for the status bar

" ============================key map ============================

noremap R :source $MYVIMRC<CR>

noremap <leader><CR> :nohlsearch<CR>

noremap <C-\> :set  splitright<CR>:vsplit<CR> 

noremap <C--> :set  splitright<CR>:split<CR> 

noremap <C-I> :YcmGenerateConfig -c g++ -v -x c++ -f -b make .<CR>

noremap <F5> :call CurtineIncSw()<CR>



"--------------------------------Plugins-------------------------------------------------------------

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '~/my-prototype-plugin'
Plug 'https://github.com/ycm-core/YouCompleteMe.git'
Plug 'Raimondi/delimitMate'
Plug 'https://github.com/rhysd/vim-clang-format'
Plug 'Yggdroot/indentLine'
Plug 'wsdjeg/FlyGrep.vim'
Plug 'ericcurtin/CurtineIncSw.vim'
call plug#end()

" 在上面的vim-plug配置中，以 call plug#begin('~/.vim/plugged') 标识vim-plug配置的开始并显式指定vim插件的存放路径为 ~/.vim/plugged；

"---------------------------------------------------------------------------------------------
