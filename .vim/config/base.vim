" basic configuration{{{
set nocompatible                                            " 不要兼容vi
syntax on                                           " vimwiki 和 anyfold需要 pyplot也要
filetype plugin indent on

set encoding=utf-8                                          " 编码
set fileencodings=ucs-bom,utf-8,gb18030,cp936,latin1        " 编码猜测
set number
set relativenumber                                          " 设置相对行号
set incsearch                                               " 搜索时即高亮
set hlsearch                                                " 高亮匹配内容
set wrap
set smartindent                                             " 智能缩进
set autoindent                                              " 自动换行缩进
set linebreak                                               " 软折行
set noswapfile                                              " 禁止生成swap文件
set hidden                                                  " 终端隐藏后不结束
set ignorecase                                              " 忽略大小写
" set smartcase
set infercase                                               " Adjust case in insert completion mode
set history=500                                             " 历史命令
set splitbelow                                              " 在下方分割
set autoindent                                              " 使用空格进行缩进
set expandtab                                               " tab扩展为空格
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set smartindent
set shiftround

set list                                                    " 只有setlist后面的才会起作用
set listchars=tab:\|\→·,nbsp:⣿,extends:»,precedes:«
set listchars+=eol:¬
set listchars+=trail:·                                      " 尾部空白
" set listchars+=space:\                                     " 空白
set pumheight=20                                            " 设置弹出框大小, 0 则有多少显示多少

set nobackup                                                " coc
set nowritebackup                                           " coc
set shortmess+=c                                            " coc
set signcolumn=yes                                          " coc
set sessionoptions+=globals                                 " coc
set noswapfile
set autoread                                                " 文件在外部被修改过，重新读入
set autowrite                                               " 自动写回
set confirm                                                 " 显示确认对话框
set noshowmode
set timeout ttimeout
set timeoutlen=500
set ttimeoutlen=10
set updatetime=300                                  " 更新时间100ms 默认4000ms 写入swap的时间
set shortmess+=c

set mouse=nv                                        " 允许使用鼠标, normal生效，a则是全模式生效
set cmdheight=1
set conceallevel=0                                  " json文件不显示引号
set laststatus=2                                    " 状态栏, lightline中更改了
set showtabline=2                                   " 总是显示tab标签栏
set re=1
set cursorline                                      " 高亮当前行
set cursorcolumn                                    " 高亮当前列
set guicursor=
set textwidth=80
set colorcolumn=+1                      " 高亮textwidth后的列

set scrolloff=15         " Keep at least 2 lines above/below
set sidescrolloff=5       " Keep at least 5 lines left/right

if has('nvim') == 0 && has('patch-8.1.2020')
    set cursorlineopt=number cursorline
endif

if has('nvim')
    " set signcolumn=auto:2
    set signcolumn=yes
else
    set scl=yes
endif

" 定位到退出位置并移动到屏幕中央
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz
endif

" auto mark when quit
silent! autocmd QuitPre mM
"}}}
" clipboard configuration{{{
if has('mac')
	let g:clipboard = {
				\   'name': 'macOS-clipboard',
				\   'copy': {
				\      '+': 'pbcopy',
				\      '*': 'pbcopy',
				\    },
				\   'paste': {
				\      '+': 'pbpaste',
				\      '*': 'pbpaste',
				\   },
				\   'cache_enabled': 0,
				\ }
endif
if has('clipboard')
	set clipboard& clipboard+=unnamedplus
endif
"}}}
" fold configuration{{{
if has('folding')
	set foldenable
	set foldmethod=marker
	autocmd FileType c,cpp set foldmethod=marker
	autocmd FileType json set foldmethod=syntax
	autocmd FileType py set foldmethod=indent
	set foldlevelstart=99
endif
"}}}
" Vim Directories {{{
" ---------------
set undofile swapfile nobackup
set directory=$DATA_PATH/swap//,$DATA_PATH,~/tmp,/var/tmp,/tmp
set undodir=$DATA_PATH/undo//,$DATA_PATH,~/tmp,/var/tmp,/tmp
set backupdir=$DATA_PATH/backup/,$DATA_PATH,~/tmp,/var/tmp,/tmp
set viewdir=$DATA_PATH/view/
set nospell spellfile=$VIM_PATH/spell/en.utf-8.add

" hi MatchParen cterm=none ctermbg=red ctermfg=blue
hi MatchParen guibg=NONE guifg=blue gui=bold

" History saving
set history=1000
if has('nvim')
	set shada='300,<50,@100,s10,h
else
	set viminfo='300,<10,@50,h,n$DATA_PATH/viminfo
endif

" If sudo, disable vim swap/backup/undo/shada/viminfo writing
if $SUDO_USER !=# '' && $USER !=# $SUDO_USER
			\ && $HOME !=# expand('~'.$USER)
			\ && $HOME ==# expand('~'.$SUDO_USER)

	set noswapfile
	set nobackup
	set nowritebackup
	set noundofile
	if has('nvim')
		set shada="NONE"
	else
		set viminfo="NONE"
	endif
endif

" Secure sensitive information, disable backup files in temp directories
if exists('&backupskip')
	set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*
	set backupskip+=.vault.vim
endif

" Disable swap/undo/viminfo/shada files in temp directories or shm
augroup user_secure
	autocmd!
	silent! autocmd BufNewFile,BufReadPre
				\ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim
				\ setlocal noswapfile noundofile nobackup nowritebackup viminfo= shada=
augroup END

let g:python_host_prog = '/System/Library/Frameworks/Python.framework/Versions/2.7/bin/python'
let g:python3_host_prog='/usr/local/bin/python3'
" }}}
"  add/update head comment in cpp file{{{

silent! autocmd BufNewFile,BufWritePre *.c,*.h,*.cxx,*.cpp,*.hpp :silent! call TitleDet()
function AddTitle()
	call append(0,"/*=============================================================================")
	call append(1,"*")
	call append(2,"*   Copyright (C) ".strftime("%Y")." All rights reserved.")
	call append(3,"*")
	call append(4,"*   Filename: ".expand("%:t"))
	call append(5,"*")
	call append(6,"*   Author: Wang Zhecheng - wangzhecheng@yeah.net")
	call append(7,"*")
	call append(8,"*   Date: ".strftime("%Y-%m-%d %H:%M"))
	call append(9,"*")
	call append(10,"*   Last Editors: Wang Zhecheng - wangzhecheng@yeah.net")
	call append(11,"*")
	call append(12,"*   Last modified: ".strftime("%Y-%m-%d %H:%M"))
	call append(13,"*")
	call append(14,"*   Description: ")
	call append(15,"*")
	call append(16,"=============================================================================*/")
	echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf
"更新最近修改时间和文件名
function UpdateTitle()
	normal m'
	execute '/* *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
	normal ''
	normal mk
	execute '/* *Filename:/s@:.*$@\=":\t\t".expand("%:t")@'
	execute "noh"
	normal 'k
	echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction
"判断前10行代码里面，是否有Last modified这个单词，
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function TitleDet()
	normal mv
	normal gg
	let n=1
	"默认为添加
	while n < 20
		let line = getline(n)
		if line =~ '^\*\s*\S*Last\smodified:\S*.*$'
			call UpdateTitle()
			normal 'v
			return
		endif
		let n = n + 1
	endwhile
	normal O
	call AddTitle()
	normal dd
	normal 'v
endfunction
"}}}
"
