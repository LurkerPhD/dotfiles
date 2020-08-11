" Plugins
" ===
" vim-Plug{{{
" 
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jackguo380/vim-lsp-cxx-highlight'

if has('nvim')
	Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'kristijanhusak/defx-icons'
else
	Plug 'Shougo/defx.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/defx-git'

"Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'w0ng/vim-hybrid'
Plug 'morhetz/gruvbox'

Plug 'junegunn/vim-easy-align'

Plug 'Yggdroot/indentLine' "indent line可视

Plug 'tpope/vim-surround' "surround神器
Plug 'tpope/vim-commentary' "自动注释

Plug 'honza/vim-snippets' " 内置了一堆语言的自动补全片段

Plug 'vim-scripts/DoxygenToolkit.vim' "doxygen 自动注释

Plug 'brooth/far.vim' "far搜索

Plug 'tpope/vim-repeat'

Plug 'terryma/vim-multiple-cursors' "多cursor，一般不用

Plug 'neoclide/vim-easygit'

" Plug 'sillybun/vim-repl'

" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() } ,'for':['markdown','vim-plug']}

Plug 'skywind3000/vim-quickui' "菜单栏

Plug 'derekwyatt/vim-fswitch' "h文件cpp文件切换
Plug 'derekwyatt/vim-protodef' "def

Plug 'liuchengxu/vista.vim' "函数列表

Plug 'tpope/vim-fugitive' "git神器

Plug 'tpope/vim-dispatch'
Plug 'ilyachur/cmake4vim'

" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'

Plug 'mhinz/vim-startify' "fancy start screen

Plug 'luochen1990/rainbow' "彩色括号

Plug 'puremourning/vimspector' "debug神器

Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

call plug#end()

"}}}

" general Settings
" ===
" General{{{
"
" Initialize startup settings
if has('vim_starting')
	" Use spacebar as leader and ; as secondary-leader
	" Required before loading plugins!
	let g:mapleader="\<Space>"
	let g:maplocalleader=';'
	" Release keymappings prefixes, evict entirely for use of plug-ins.
	nnoremap <Space>  <Nop>
	xnoremap <Space>  <Nop>
	nnoremap ,        <Nop>
	xnoremap ,        <Nop>
	nnoremap ;        <Nop>
	xnoremap ;        <Nop>
	" Vim only, Linux terminal settings
	if ! has('nvim') && ! has('gui_running') && ! has('win32') && ! has('win64')
		" call s:source_file('config/terminal.vim')
	endif
endif

set autoread

autocmd BufWritePost $MYVIMRC source $MYVIMRC " vimrc自动生效
set mouse=nv                 " Disable mouse in command-line mode
set modeline                 " automatically setting options from modelines
set report=0                 " Don't report on line changes
set errorbells               " Trigger bell on error
set visualbell               " Use visual bell instead of beeping
set signcolumn=yes           " Always show signs column
set hidden                   " hide buffers when abandoned instead of unload
set fileformats=unix,dos,mac " Use Unix as the standard file type
set magic                    " For regular expressions turn magic on
set path=.,**                " Directories to search when using gf
set virtualedit=block        " Position cursor anywhere in visual block
set synmaxcol=1000           " Don't syntax highlight long lines
set formatoptions+=1         " Don't break lines after a one-letter word
set formatoptions-=t         " Don't auto-wrap text
set cursorline
" set cursorcolumn
if has('patch-7.3.541')
	set formatoptions+=j       " Remove comment leader when joining lines
endif

if has('vim_starting')
	set encoding=utf-8
	scriptencoding utf-8
endif

" Enables 24-bit RGB color in the TUI
if has('termguicolors')
	set termguicolors
endif

" What to save for views and sessions:
set viewoptions=folds,cursor,curdir,slash,unix
set sessionoptions=curdir,help,tabpages,winsize

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

" }}}
" Wildmenu {{{
" --------
if has('wildmenu')
	set nowildmenu
	set wildmode=list:longest,full
	set wildoptions=tagfile
	set wildignorecase
	set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
	set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
	set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
	set wildignore+=application/vendor/**,**/vendor/ckeditor/**,media/vendor/**
	set wildignore+=__pycache__,*.egg-info,.pytest_cache
endif

" }}}
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

" }}}
" Tabs and Indents {{{
" ----------------
set textwidth=80    " Text width maximum chars before wrapping
set noexpandtab     " Don't expand tabs to spaces.
set tabstop=2       " The number of spaces a tab is
set softtabstop=2   " While performing editing operations
set shiftwidth=2    " Number of spaces to use in auto(indent)
set smarttab        " Tab insert blanks according to 'shiftwidth'
set autoindent      " Use same indenting on new lines
set smartindent     " Smart autoindenting on new lines
set shiftround      " Round indent to multiple of 'shiftwidth'

" }}}
" Timing {{{
" ------
set timeout ttimeout
set timeoutlen=750  " Time out on mappings
set updatetime=400  " Idle time to write swap and trigger CursorHold
set ttimeoutlen=10  " Time out on key codes

" }}}
" Searching {{{
" ---------
set ignorecase      " Search ignoring case
set smartcase       " Keep case when searching with *
set infercase       " Adjust case in insert completion mode
set incsearch       " Incremental search
set wrapscan        " Searches wrap around the end of the file
set showmatch       " Jump to matching bracket
set matchpairs+=<:> " Add HTML brackets to pair matching
set matchtime=1     " Tenths of a second to show the matching paren
set cpoptions-=m    " showmatch will wait 0.5s or until a char is typed
set showfulltag     " Show tag and tidy search in completion
"set complete=.      " No wins, buffs, tags, include scanning

if exists('+inccommand')
	set inccommand=nosplit
endif

if executable('rg')
	set grepformat=%f:%l:%m
	let &grepprg = 'rg --vimgrep' . (&smartcase ? ' --smart-case' : '')
elseif executable('ag')
	set grepformat=%f:%l:%m
	let &grepprg = 'ag --vimgrep' . (&smartcase ? ' --smart-case' : '')
endif

" 替换函数。参数说明：
" confirm：是否替换前逐一确认
" wholeword：是否整词匹配
" replace：被替换字符串
function! Replace(confirm, wholeword, replace)
	wa!
	let flag = ''
	if a:confirm
		let flag .= 'gec'
	else
		let flag .= 'ge'
	endif
	let search = ''
	if a:wholeword
		let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
	else
		let search .= expand('<cword>')
	endif
	let replace = escape(a:replace, '/\&~')
	execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
" 不确认、非整词
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 不确认、整词
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、非整词
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、整词
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" }}}
" Behavior {{{
" --------
set nowrap                      " No wrap by default
set linebreak                   " Break long lines at 'breakat'
set breakat=\ \	;:,!?           " Long lines break chars
set nostartofline               " Cursor in same column for few commands
set whichwrap+=h,l,<,>,[,],~    " Move to following line on certain keys
set splitbelow splitright       " Splits open bottom right
set switchbuf=useopen,usetab    " Jump to the first open window in any tab
set switchbuf+=vsplit           " Switch buffer behavior to vsplit
set backspace=indent,eol,start  " Intuitive backspacing in insert mode
set diffopt=filler,iwhite       " Diff mode: show fillers, ignore whitespace
set completeopt=menuone         " Always show menu, even for one item
set completeopt+=noselect       " Do not select a match in the menu

if has('patch-7.4.775')
	" Do not insert any text for a match until the user selects from menu
	set completeopt+=noinsert
endif

if has('patch-8.1.0360') || has('nvim-0.4')
	" set diffopt+=internal,algorithm:patience
	" set diffopt=indent-heuristic,algorithm:patience
endif

" }}}
" Editor UI {{{
" --------------------
set noshowmode          " Don't show mode in cmd window
set shortmess=aoOTI     " Shorten messages and don't show intro
set scrolloff=25         " Keep at least 2 lines above/below
set sidescrolloff=5       " Keep at least 5 lines left/right
set ruler                       " show the current row and column
set number relativenumber
" augroup numbertoggle
" 	autocmd!
" 	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
" 	autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
" augroup END
set list                " Show hidden characters

set winwidth=30         " Minimum width for active window
set winminwidth=10      " Minimum width for inactive windows
set winheight=4         " Minimum height for active window
set winminheight=1      " Minimum height for inactive window
set pumheight=15        " Pop-up menu's line height
set helpheight=12       " Minimum help window height
set previewheight=12    " Completion preview height

set showcmd             " Show command in status line
set cmdheight=2         " Height of the command line
set cmdwinheight=5      " Command-line lines
set equalalways         " Resize windows on split or close
set display=lastline

set colorcolumn=80      " Highlight the 80th character limit
autocmd FileType json set colorcolumn=160      " Highlight the 80th character limit

if has('folding')
	set foldenable
	set foldmethod=marker
	autocmd FileType c,cpp set foldmethod=marker
	autocmd FileType json set foldmethod=syntax
	autocmd FileType py set foldmethod=indent
	set foldlevelstart=99
endif

" UI Symbols
" icons:  ▏│ ¦ ╎ ┆ ⋮ ⦙ ┊ 
set showbreak=↪
set listchars=tab:\▏\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·
"set fillchars=vert:▉,fold:─

if has('patch-7.4.314')
	" Do not display completion messages
	set shortmess+=c
endif

if has('patch-7.4.1570')
	" Do not display message when editing files
	set shortmess+=F
endif

if has('conceal') && v:version >= 703
	" For snippet_complete marker
	set conceallevel=2 concealcursor=niv
endif

if exists('&pumblend')
	" pseudo-transparency for completion menu
	set pumblend=20
endif

"if exists('&winblend')
"	" pseudo-transparency for floating window
"	set winblend=20
"endif

" }}}
"auto mark when quit{{{

silent! autocmd QuitPre mM
"}}}
" add/update head comment in cpp file{{{

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
"python related{{{
let g:python_host_prog = '/System/Library/Frameworks/Python.framework/Versions/2.7/bin/python'
let g:python3_host_prog='/usr/local/bin/python3'
"}}}

" key-mappings
" ===
" Non-standard {{{
" ---
"

inoremap jk <esc>

" Disable arrow movement, resize splits instead.
" if get(g:, 'elite_mode')
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
" endif

" Change current word in a repeatable manner
nnoremap <leader>cn *``cgn
nnoremap <leader>cN *``cgN

" Change selected word in a repeatable manner
vnoremap <expr> <leader>cn "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"
vnoremap <expr> <leader>cN "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"

nnoremap <leader>cp yap<S-}>p

" Toggle fold
" nnoremap <CR> za

" Focus the current fold by closing all others
nnoremap <leader>zc zMzvzt

" Use backspace key for matchit.vim
nmap <BS> %
xmap <BS> %

"}}}
" Global niceties {{{
" ---------------

" Start an external command with a single bang
nnoremap ! :!

" Allow misspellings
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd

nnoremap zl z5l
nnoremap zh z5h

" Improve scroll, credits: https://github.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
			\ 'zt' : (winline() == 1) ? 'zb' : 'zz'
noremap <expr> <C-f> max([winheight(0) - 2, 1])
			\ ."\<C-d>".(line('w$') >= line('$') ? "L" : "M")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
			\ ."\<C-u>".(line('w0') <= 1 ? "H" : "M")
noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "3\<C-e>")
noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "3\<C-y>")

" Window control
nnoremap <silent><C-w>z :vert resize<CR>:resize<CR>:normal! ze<CR>
nnoremap <leader>\ :set splitright<CR>:vsplit<CR>
nnoremap <leader>- :set splitbelow<CR>:split<CR>
nnoremap H ^
nnoremap L $
nnoremap <leader>wh <C-w>h
nnoremap <leader>wl <C-w>l
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wo <C-w>o
nnoremap <leader>wc <C-w>c
nnoremap <leader>wn <C-w>n
nnoremap <leader>wx <C-w>x<C-w>w

" imap hhh <Esc>
" imap jjj <Esc>
" imap kkk <Esc>
" imap lll <Esc>
imap <C-h> <left>
imap <C-j> <up>
imap <C-k> <down>
imap <C-l> <right>

" map <leader><leader> <Esc>/<CR><leader><CR>cf<


" Select blocks after indenting
" xnoremap < <gv
" xnoremap > >gv|

" Use tab for indenting
xnoremap <Tab> >gv|
xnoremap <S-Tab> <gv
" nmap >>  >>_
" nmap <<  <<_

" Select last paste
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

" Switch history search pairs, matching my bash shell
cnoremap <C-p>  <Up>
cnoremap <C-n>  <Down>
cnoremap <Up>   <C-p>
cnoremap <Down> <C-n>

" }}}
" File operations {{{
" ---------------

" Switch to the directory of the opened buffer
map <Leader>cd :lcd %:p:h<CR>:pwd<CR>

" Fast saving
" nnoremap <silent><Leader>w :write<CR>
" vnoremap <silent><Leader>w <Esc>:write<CR>
" nnoremap <silent><C-s> :<C-u>write<CR>
" vnoremap <silent><C-s> :<C-u>write<CR>
" cnoremap <silent><C-s> <C-u>write<CR>

" }}}
" Editor UI {{{
" ---------

"Show vim syntax highlight groups for character under cursor
"nmap <silent> gh :echo 'hi<'.synIDattr(synID(line('.'), col('.'), 1), 'name')
"  \.'> trans<'.synIDattr(synID(line('.'), col('.'), 0), 'name').'> lo<'
"  \.synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name').'>'<CR>

" Toggle editor visuals
nmap <silent> <Leader>ts :setlocal spell!<cr>
nmap <silent> <Leader>tn :setlocal nonumber!<CR>
nmap <silent> <Leader>tl :setlocal nolist!<CR>
nmap <silent> <Leader><CR> :nohlsearch<CR>
nmap <silent> <Leader>tw :setlocal wrap! breakindent!<CR>

" Tabs
nnoremap <silent> g0 :<C-u>tabfirst<CR>
nnoremap <silent> g$ :<C-u>tablast<CR>
nnoremap <silent> g5 :<C-u>tabprevious<CR>
nnoremap <silent> <A-j> :<C-U>tabnext<CR>
nnoremap <silent> <A-k> :<C-U>tabprevious<CR>
nnoremap <silent> <C-Tab> :<C-U>tabnext<CR>
nnoremap <silent> <C-S-Tab> :<C-U>tabprevious<CR>

" }}}
" Totally Custom {{{
" --------------

" Remove spaces at the end of lines
nnoremap <silent> <Leader>cw :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" C-r: Easier search and replace
xnoremap <C-r> :<C-u>call <SID>get_selection('/')<CR>:%s/\V<C-R>=@/<CR>//gc<Left><Left><Left>

" Quick substitute within selected area
xnoremap sg :s//gc<Left><Left><Left>
" Returns visually selected text
function! s:get_selection(cmdtype) "{{{

	let temp = @s
	normal! gv"sy
	let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
	let @s = temp
endfunction "}}}

" Location/quickfix list movement
nmap ]c :lnext<CR>
nmap [c :lprev<CR>
nmap ]q :cnext<CR>
nmap [q :cprev<CR>

" Duplicate lines
" nnoremap <Leader>d m`YP``
" vnoremap <Leader>d YPgv

" Source line and selection in vim
" vnoremap <Leader>S y:execute @@<CR>:echo 'Sourced selection.'<CR>
" nnoremap <leader>d m`yp``
" vnoremap <leader>d ypgv

" source line and selection in vim
" vnoremap <leader>s y:execute @@<cr>:echo 'sourced selection.'<cr>
" nnoremap <Leader>S ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>

" Yank buffer's absolute path to clipboard
nnoremap <Leader>yp :let @+=expand("%")<CR>:echo 'Yanked relative path'<CR>
nnoremap <Leader>Yp :let @+=expand("%:p")<CR>:echo 'Yanked absolute path'<CR>

" Context-aware action-menu, neovim only (see plugin/actionmenu.vim)
if has('nvim')
	nmap <silent> <LocalLeader>c :<C-u>ActionMenu<CR>
endif

" Whitespace jump (see plugin/whitespace.vim)
nnoremap ]w :<C-u>WhitespaceNext<CR>
nnoremap [w :<C-u>WhitespacePrev<CR>

" Session management shortcuts (see plugin/sessions.vim)
" nmap <silent> <Leader>se :<C-u>SessionSave<CR>
" nmap <silent> <Leader>os :<C-u>SessionLoad<CR>
"
" nmap <silent> <Leader>o :<C-u>OpenSCM<CR>
" vmap <silent> <Leader>o :OpenSCM<CR>

if has('mac')
	" Open the macOS dictionary on current word
	nmap <Leader>? :!open dict://<cword><CR><CR>
endif

" }}}
" Append modeline to EOF {{{
nnoremap <silent> <Leader>ml :call <SID>append_modeline()<CR>

" Append modeline after last line in buffer
" See: http://vim.wikia.com/wiki/Modeline_magic
function! s:append_modeline() "{{{
	let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
				\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
	call append(line('$'), l:modeline)
endfunction "}}}

" }}}

" Plugins settings
" ===
" color theme configuration{{{

let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme gruvbox 
"Show vim syntax highlight groups for character under cursor
" nmap <silent> gh :echo 'hi<'.synIDattr(synID(line('.'), col('.'), 1), 'name')
"   \.'> trans<'.synIDattr(synID(line('.'), col('.'), 0), 'name').'> lo<'
"   \.synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name').'>'<CR>
set background=dark
"}}}
" coc configuration{{{

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
	autocmd!
	" setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>aap  <Plug>(coc-codeaction-selected)
nmap <leader>aap <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
" command! -nargs=0 Format :call CocAction('format')
nmap <leader>fm :call CocAction('format')<CR>

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList files<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>pl  :<C-u>CocListResume<CR>

" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args> "

function! s:GrepArgs(...)
	let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
				\ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
	return join(list, "\n")
endfunction

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <Leader>cf :exe 'CocList -I -A --input='.expand('<cword>').' grep'<CR>

vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

function! s:GrepFromSelected(type)
	let saved_unnamed_register = @@
	if a:type ==# 'v'
		normal! `<v`>y
	elseif a:type ==# 'char'
		normal! `[v`]y
	else
		return
	endif
	let word = substitute(@@, '\n$', '', 'g')
	let word = escape(word, '| ')
	let @@ = saved_unnamed_register
	execute 'CocList -A --normal grep '.word
endfunction

" nnoremap <silent> <space>w  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>

" popup
nmap <Leader>tl <Plug>(coc-translator-p)

nmap gs <Plug>(coc-git-chunkinfo)
" nmap [g <Plug>(coc-git-prevchunk)
" nmap ]g <Plug>(coc-git-nextchunk)
" show commit contains current position
nmap gC <Plug>(coc-git-commit)
"}}}
" defx configration {{{

" :h defx
" ---
" Problems? https://github.com/Shougo/defx.nvim/issues

call defx#custom#option('_', {
			\ 'winwidth': 25,
			\ 'split': 'vertical',
			\ 'direction': 'topleft',
			\ 'show_ignored_files': 0,
			\ 'columns': 'indent:git:icons:filename',
			\ 'root_marker': ' ',
			\ 'ignored_files':
			\     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
			\   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc',
			\ 'toggle': 1,
			\ 'resume': 1
			\ })
			"\ 'listed': 1,

call defx#custom#column('git', {
			\   'indicators': {
			\     'Modified'  : '•',
			\     'Staged'    : '✚',
			\     'Untracked' : 'ᵁ',
			\     'Renamed'   : '≫',
			\     'Unmerged'  : '≠',
			\     'Ignored'   : 'ⁱ',
			\     'Deleted'   : '✖',
			\     'Unknown'   : '⁇'
			\   }
			\ })

call defx#custom#column('mark', { 'readonly_icon': '', 'selected_icon': '' })

" defx-icons plugin
let g:defx_icons_column_length = 1
let g:defx_icons_mark_icon = ''

" Internal use
let s:original_width = get(get(defx#custom#_get().option, '_'), 'winwidth')

" Events
" ---

augroup user_plugin_defx
	autocmd!

	" Delete defx if it's the only buffer left in the window
	autocmd WinEnter * if &filetype == 'defx' && winnr('$') == 1 | bdel | endif

	" Move focus to the next window if current buffer is defx
	autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif

	" Clean Defx window once a tab-page is closed
	" autocmd TabClosed * call <SID>defx_close_tab(expand('<afile>'))

	" Automatically refresh opened Defx windows when changing working-directory
	" autocmd DirChanged * call <SID>defx_handle_dirchanged(v:event)

	" Define defx window mappings
	autocmd FileType defx call <SID>defx_mappings()

augroup END

" Internal functions
" ---

" Deprecated after disabling defx's (buf)listed
" function! s:defx_close_tab(tabnr)
" 	" When a tab is closed, find and delete any associated defx buffers
" 	for l:nr in tabpagebuflist()
" 		if getbufvar(l:nr, '&filetype') ==# 'defx'
" 			silent! execute 'bdelete '.l:nr
" 			break
" 		endif
" 	endfor
" endfunction

function! s:defx_toggle_tree() abort
	" Open current file, or toggle directory expand/collapse
	if defx#is_directory()
		return defx#do_action('open_or_close_tree')
	endif
	return defx#do_action('multi', ['drop', 'quit'])
endfunction

function! s:defx_handle_dirchanged(event)
	" Refresh opened Defx windows when changing working-directory
	let l:cwd = get(a:event, 'cwd', '')
	let l:scope = get(a:event, 'scope', '')   " global, tab, window
	let l:current_win = winnr()
	if &filetype ==# 'defx' || empty(l:cwd) || empty(l:scope)
		return
	endif

	" Find tab-page's defx window
	for l:nr in tabpagebuflist()
		if getbufvar(l:nr, '&filetype') ==# 'defx'
			let l:winnr = bufwinnr(l:nr)
			if l:winnr != -1
				" Change defx's window directory location
				if l:scope ==# 'window'
					execute 'noautocmd' l:winnr . 'windo' 'lcd' l:cwd
				else
					execute 'noautocmd' l:winnr . 'wincmd' 'w'
				endif
				call defx#call_action('cd', [ l:cwd ])
				execute 'noautocmd' l:current_win . 'wincmd' 'w'
				break
			endif
		endif
	endfor
endfunction

function! s:jump_dirty(dir) abort
	" Jump to the next position with defx-git dirty symbols
	let l:icons = get(g:, 'defx_git_indicators', {})
	let l:icons_pattern = join(values(l:icons), '\|')

	if ! empty(l:icons_pattern)
		let l:direction = a:dir > 0 ? 'w' : 'bw'
		return search(printf('\(%s\)', l:icons_pattern), l:direction)
	endif
endfunction

function! s:defx_mappings() abort
	" Defx window keyboard mappings
	setlocal signcolumn=no expandtab

	nnoremap <silent><buffer><expr> <CR>  <SID>defx_toggle_tree()
	nnoremap <silent><buffer><expr> e     <SID>defx_toggle_tree()
	nnoremap <silent><buffer><expr> l     <SID>defx_toggle_tree()
	nnoremap <silent><buffer><expr> h     defx#do_action('close_tree')
	nnoremap <silent><buffer><expr> t     defx#do_action('open_tree_recursive')
	nnoremap <silent><buffer><expr> st    defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
	nnoremap <silent><buffer><expr> sg    defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
	nnoremap <silent><buffer><expr> sv    defx#do_action('multi', [['drop', 'split'], 'quit'])
	nnoremap <silent><buffer><expr> P     defx#do_action('open', 'pedit')
	nnoremap <silent><buffer><expr> y     defx#do_action('yank_path')
	nnoremap <silent><buffer><expr> x     defx#do_action('execute_system')
	nnoremap <silent><buffer><expr> gx    defx#do_action('execute_system')
	nnoremap <silent><buffer><expr> .     defx#do_action('toggle_ignored_files')

	" Defx's buffer management
	nnoremap <silent><buffer><expr> q      defx#do_action('quit')
	nnoremap <silent><buffer><expr> se     defx#do_action('save_session')
	nnoremap <silent><buffer><expr> <C-r>  defx#do_action('redraw')
	nnoremap <silent><buffer><expr> <C-g>  defx#do_action('print')

	" File/dir management
	nnoremap <silent><buffer><expr><nowait> c  defx#do_action('copy')
	nnoremap <silent><buffer><expr><nowait> m  defx#do_action('move')
	nnoremap <silent><buffer><expr><nowait> p  defx#do_action('paste')
	nnoremap <silent><buffer><expr><nowait> r  defx#do_action('rename')
	nnoremap <silent><buffer><expr><nowait> d  defx#do_action('remove_trash')
	nnoremap <silent><buffer><expr> K  defx#do_action('new_directory')
	nnoremap <silent><buffer><expr> N  defx#do_action('new_multiple_files')

	" Jump
	nnoremap <silent><buffer>  [g :<C-u>call <SID>jump_dirty(-1)<CR>
	nnoremap <silent><buffer>  ]g :<C-u>call <SID>jump_dirty(1)<CR>

	" Change directory
	nnoremap <silent><buffer><expr><nowait> \  defx#do_action('cd', getcwd())
	nnoremap <silent><buffer><expr><nowait> &  defx#do_action('cd', getcwd())
	nnoremap <silent><buffer><expr> <BS>  defx#async_action('cd', ['..'])
	nnoremap <silent><buffer><expr> ~     defx#async_action('cd')
	nnoremap <silent><buffer><expr> u   defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> 2u  defx#do_action('cd', ['../..'])
	nnoremap <silent><buffer><expr> 3u  defx#do_action('cd', ['../../..'])
	nnoremap <silent><buffer><expr> 4u  defx#do_action('cd', ['../../../..'])

	" Selection
	nnoremap <silent><buffer><expr> *  defx#do_action('toggle_select_all')
	nnoremap <silent><buffer><expr><nowait> <space> defx#do_action('toggle_select') . 'j'

	nnoremap <silent><buffer><expr> S  defx#do_action('toggle_sort', 'Time')
	nnoremap <silent><buffer><expr> C
				\ defx#do_action('toggle_columns', 'indent:mark:filename:type:size:time')

	" Tools
	nnoremap <silent><buffer><expr> w   defx#do_action('call', '<SID>toggle_width')
	nnoremap <silent><buffer><expr> gd  defx#async_action('multi', ['drop', ['call', '<SID>git_diff']])
	if exists('$TMUX')
		nnoremap <silent><buffer><expr> gl  defx#async_action('call', '<SID>explorer')
	endif
endfunction

" TOOLS
" ---

function! s:git_diff(context) abort
	execute 'GdiffThis'
endfunction

function! s:toggle_width(context) abort
	" Toggle between defx window width and longest line
	let l:max = 0
	for l:line in range(1, line('$'))
		let l:len = len(getline(l:line))
		let l:max = max([l:len, l:max])
	endfor
	let l:new = l:max == winwidth(0) ? s:original_width : l:max
	call defx#call_action('resize', l:new)
endfunction

function! s:explorer(context) abort
	" Open file-explorer split with tmux
	let l:explorer = s:find_file_explorer()
	if empty('$TMUX') || empty(l:explorer)
		return
	endif
	let l:target = a:context['targets'][0]
	let l:parent = fnamemodify(l:target, ':h')
	let l:cmd = 'split-window -p 30 -c ' . l:parent . ' ' . l:explorer
	silent execute '!tmux ' . l:cmd
endfunction

function! s:find_file_explorer() abort
	" Detect terminal file-explorer
	let s:file_explorer = get(g:, 'terminal_file_explorer', '')
	if empty(s:file_explorer)
		for l:explorer in ['lf', 'hunter', 'ranger', 'vifm']
			if executable(l:explorer)
				let s:file_explorer = l:explorer
				break
			endif
		endfor
	endif
	return s:file_explorer
endfunction

" " 使用 ;e 切换显示文件浏览，使用 ;a 查找到当前文件位置
nnoremap <silent> <LocalLeader>e
			\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent> <LocalLeader>a
			\ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
	" IndentLinesDisable
	setl signcolumn=no
	setl number
	nnoremap <silent><buffer><expr> <CR>
				\ defx#is_directory() ?
				\ defx#do_action('open_or_close_tree') :
				\ defx#do_action('drop',)
	nmap <silent><buffer><expr> <2-LeftMouse>
				\ defx#is_directory() ?
				\ defx#do_action('open_or_close_tree') :
				\ defx#do_action('drop',)
	nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
	nnoremap <silent><buffer><expr> v defx#do_action('drop', 'vsplit')
	nnoremap <silent><buffer><expr> t defx#do_action('drop', 'tabe')
	nnoremap <silent><buffer><expr> o defx#do_action('open_tree')
	nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
	nnoremap <silent><buffer><expr> C defx#do_action('copy')
	nnoremap <silent><buffer><expr> P defx#do_action('paste')
	nnoremap <silent><buffer><expr> M defx#do_action('rename')
	nnoremap <silent><buffer><expr> D defx#do_action('remove_trash')
	nnoremap <silent><buffer><expr> A defx#do_action('new_multiple_files')
	nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
	nnoremap <silent><buffer><expr> R defx#do_action('redraw')
endfunction

" " " defx git configration 
" let g:defx_git#indicators = {
" 	\ 'Modified'  : '•',
" 	\ 'Staged'    : '✚',
" 	\ 'Untracked' : 'ᵁ',
" 	\ 'Renamed'   : '≫',
" 	\ 'Unmerged'  : '≠',
" 	\ 'Ignored'   : 'ⁱ',
" 	\ 'Deleted'   : '✖',
" 	\ 'Unknown'   : '⁇'
" 	\ }
" let g:defx_git#column_length = 0
"
hi def link Defx_filename_directory NERDTreeDirSlash
hi def link Defx_git_Modified Special
hi def link Defx_git_Staged Function
hi def link Defx_git_Renamed Title
hi def link Defx_git_Unmerged Label
hi def link Defx_git_Untracked Tag
hi def link Defx_git_Ignored Comment
"}}}
" indentLine configration {{{

let g:indentLine_setColors = 0
"}}}
" doxygen configration {{{

nnoremap dox <Esc>:Dox<Cr>

let g:DoxygenToolkit_briefTag_funcName = "yes"

" for C++ style, change the '@' to '\'
"let g:DoxygenToolkit_commentType = "C++"
"let g:DoxygenToolkit_briefTag_pre = "\\brief "
"let g:DoxygenToolkit_templateParamTag_pre = "\\tparam "
"let g:DoxygenToolkit_paramTag_pre = "\\param "
"let g:DoxygenToolkit_returnTag = "\\return "
"let g:DoxygenToolkit_throwTag_pre = "\\throw " " @exception is also valid
"let g:DoxygenToolkit_fileTag = "\\file "
"let g:DoxygenToolkit_dateTag = "\\date "
"let g:DoxygenToolkit_authorTag = "\\author "
"let g:DoxygenToolkit_versionTag = "\\version "
"let g:DoxygenToolkit_blockTag = "\\name "
"let g:DoxygenToolkit_classTag = "\\class "
"let g:DoxygenToolkit_authorName = "Qian Gu, guqian110@gmail.com"
"let g:doxygen_enhanced_color = 1
""let g:load_doxygen_syntax = 1
"let g:DoxygenToolKit_startCommentBlock = "/// "
"let g:DoxygenToolKit_interCommentBlock = "/// "
"}}}
" far.vim configration {{{

let g:far#file_mask_favorites= ['%', '**/*.*', '**/*.cpp **/*.h', '**/*.cpp', '**/*.h','**/*.html', '**/*.js', '**/*.css'] 

let g:far#default_file_mask='**/*.h **/*.cpp'
"}}}
" vim repl configration {{{

let g:repl_program = {
			\   'python': 'ipython',
			\   'default': 'zsh',
			\   'r': 'R',
			\   'lua': 'lua',
			\   }
let g:repl_predefine_python = {
			\   'numpy': 'import numpy as np',
			\   'matplotlib': 'from matplotlib import pyplot as plt'
			\   }
let g:repl_cursor_down = 1
let g:repl_python_automerge = 1
let g:repl_ipython_version = '7'
nnoremap <leader>r :REPLToggle<Cr>
autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<Cr>
autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<Cr>
autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<Cr>
let g:repl_position = 3

" let g:repl_width = None                           "窗口宽度
" let g:repl_height = None                          "窗口高度
" let g:sendtorepl_invoke_key = "<leader>w"          "传送代码快捷键，默认为<leader>w
" let g:repl_position = 0                             "0表示出现在下方，1表示出现在上方，2在左边，3在右边
" let g:repl_stayatrepl_when_open = 0         "打开REPL时是回到原文件（1）还是停留在REPL窗口中（0）
" tnoremap <C-h> <C-w><C-h>
" tnoremap <C-j> <C-w><C-j>
" tnoremap <C-k> <C-w><C-k>
" tnoremap <C-l> <C-w><C-l>
"}}}
" git configuration{{{
let g:easygit_enable_command = 1
"}}}
" markdown preview configuration{{{
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
let g:mkdp_preview_options = {
			\ 'mkit': {},
			\ 'katex': {},
			\ 'uml': {},
			\ 'maid': {},
			\ 'disable_sync_scroll': 0,
			\ 'sync_scroll_type': 'middle',
			\ 'hide_yaml_meta': 1,
			\ 'sequence_diagrams': {}
			\ }

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'


autocmd FileType markdown inoremap <leader>
" }}}
"quick gui configuration{{{

" clear all the menus
call quickui#menu#reset()

" install a 'File' menu, use [text, command] to represent an item.
call quickui#menu#install('&File', [
			\ [ "&Close", 'close' ],
			\ [ "--", '' ],
			\ [ "&Save\tw!", 'w!'],
			\ [ "Save &All\tq!", 'wa!' ],
			\ [ "--", '' ],
			\ [ "E&xit\tAlt+x", 'q!' ],
			\ ])

" install a 'File' menu, use [text, command] to represent an item.
call quickui#menu#install('Fol&d', [
			\ [ "&marker fold", 'se fdm=marker' ],
			\ [ "&syntax fold", 'se fdm=syntax' ],
			\ [ "&indent fold", 'se fdm=indent' ],
			\ ])
" items containing tips, tips will display in the cmdline
call quickui#menu#install('&Git', [
			\ [ 'git &status', 'CocList gstatus' ],
			\ [ 'git &diff', 'GdiffThis' ],
			\ [ 'git &chunkinfo', 'CocCommand git.chunkInfo' ],
			\ [ 'git &toggleGutters', 'CocCommand git.toggleGutters' ],
			\ ])
" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("Toggl&e", [
			\ ['Toggle &wrapper', 'se wrap!'],
			\ ['Toggle &function list', 'Vista coc'],
			\ ])

" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("Li&st", [
			\ [ "list &buffers", 'CocList buffers' ],
			\ ['list &functions', 'echo 0'],
			\ ['list &yanks', 'CocList yanks'],
			\ ])

" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("&Option", [
			\ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
			\ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorlie!'],
			\ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
			\ ])

" enable to display tips in the cmdline
let g:quickui_show_tip = 1

" hit space twice to open menu
noremap <leader>mn :call quickui#menu#open()<cr>

"}}}
"switch between cpp and h{{{
" map <leader>pp :call CurtineIncSw()<CR>
" - Switch to the file and load it into the current window >
nmap <silent> <Leader>pp :FSHere<cr>
" < - Switch to the file and load it into the window on the right >
nmap <silent> <Leader>Pl :FSRight<cr>
" < - Switch to the file and load it into a new window split on the right >
nmap <silent> <Leader>PL :FSSplitRight<cr>
" < - Switch to the file and load it into the window on the left >
nmap <silent> <Leader>Ph :FSLeft<cr>
" < - Switch to the file and load it into a new window split on the left >
nmap <silent> <Leader>PH :FSSplitLeft<cr>
" < - Switch to the file and load it into the window above >
nmap <silent> <Leader>Pk :FSAbove<cr>
" < - Switch to the file and load it into a new window split above >
nmap <silent> <Leader>PK :FSSplitAbove<cr>
" < - Switch to the file and load it into the window below >
nmap <silent> <Leader>Pj :FSBelow<cr>
" < - Switch to the file and load it into a new window split below >
nmap <silent> <Leader>PJ :FSSplitBelow<cr>

"}}}
"tagbar configuration{{{
" 设置 tagbar 子窗口的位置出现在主编辑区的左边 
let tagbar_left=1 
" 设置显示／隐藏标签列表子窗口的快捷键。速记：identifier list by tag
nnoremap <Leader>ilt :TagbarToggle<CR> 
" 设置标签子窗口的宽度 
let tagbar_width=32 
" tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=1
" 设置 ctags 对哪些代码标识符生成标签
let g:tagbar_type_cpp = {
			\ 'kinds' : [
			\ 'c:classes:0:1',
			\ 'd:macros:0:1',
			\ 'e:enumerators:0:0', 
			\ 'f:functions:0:1',
			\ 'g:enumeration:0:1',
			\ 'l:local:0:1',
			\ 'm:members:0:1',
			\ 'n:namespaces:0:1',
			\ 'p:functions_prototypes:0:1',
			\ 's:structs:0:1',
			\ 't:typedefs:0:1',
			\ 'u:unions:0:1',
			\ 'v:global:0:1',
			\ 'x:external:0:1'
			\ ],
			\ 'sro'        : '::',
			\ 'kind2scope' : {
			\ 'g' : 'enum',
			\ 'n' : 'namespace',
			\ 'c' : 'class',
			\ 's' : 'struct',
			\ 'u' : 'union'
			\ },
			\ 'scope2kind' : {
			\ 'enum'      : 'g',
			\ 'namespace' : 'n',
			\ 'class'     : 'c',
			\ 'struct'    : 's',
			\ 'union'     : 'u'
			\ }
			\ }
"}}}
"lldb related{{{

" hi LLBreakpointSign ctermfg=cyan guifg=red guibg=cyan
" hi LLSelectedPCLine ctermbg=DarkGrey guibg=DarkGrey

" nmap <leader>bp <Plug>LLBreakSwitch
" function! s:run_to_cursor()
" 	LLBreakSwitch
" 	LL continue
" 	LLBreakSwitch
" endfunction
" nmap <leader>rtc :call <SID>run_to_cursor()<CR>
" vmap <F2> <Plug>LLStdInSelected
" nnoremap <F4> :LLstdin<CR>
" nnoremap <F5> :LLmode debug<CR>
" nnoremap <S-F5> :LLmode code<CR>
" nnoremap <F8> :LL continue<CR>
" nnoremap <S-F8> :LL process interrupt<CR>
" nnoremap <F9> :LL print <C-R>=expand('<cword>')<CR>
" vnoremap <F9> :<C-U>LL print <C-R>=lldb#util#get_selection()<CR><CR>
"}}}
"easy align{{{
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
"}}}
" Statusline{{{

set laststatus=2        " Always show a status line
function! Buf_total_num()
	return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction
function! File_size(f)
	let l:size = getfsize(expand(a:f))
	if l:size == 0 || l:size == -1 || l:size == -2
		return ''
	endif
	if l:size < 1024
		return l:size.' bytes'
	elseif l:size < 1024*1024
		return printf('%.1f', l:size/1024.0).'k'
	elseif l:size < 1024*1024*1024
		return printf('%.1f', l:size/1024.0/1024.0) . 'm'
	else
		return printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g'
	endif
endfunction

function! StatuslineModeColor()
	let s:StatuslineMode=mode()
	if s:StatuslineMode == 'n'
		hi Statusline guibg=blue
	elseif s:StatuslineMode == 'i'
		hi Statusline guibg=red
	endif
endfunc
let &stl.='%{StatuslineModeColor()}'

let g:currentmode={
			\ 'n'  : 'Normal',
			\ 'no' : 'N·Operator Pending',
			\ 'v'  : 'Visual',
			\ 'V'  : 'V·Line',
			\ '' : 'V·Block',
			\ 's'  : 'Select',
			\ 'S'  : 'S·Line',
			\ '' : 'S·Block',
			\ 'i'  : 'Insert',
			\ 'R'  : 'Replace',
			\ 'Rv' : 'V·Replace',
			\ 'c'  : 'Command',
			\ 'cv' : 'Vim Ex',
			\ 'ce' : 'Ex',
			\ 'r'  : 'Prompt',
			\ 'rm' : 'More',
			\ 'r?' : 'Confirm',
			\ '!'  : 'Shell',
			\'t':'fzf'
			\}
" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor() "{{{
	if (g:colors_name == 'solarized' && exists('g:solarized_vars'))
		let s:vars=g:solarized_vars

		if (mode() =~# '\v(n|no)')
			exe 'hi! StatusLine '.s:vars['fmt_none'].s:vars['fg_base1'].s:vars['bg_base02'].s:vars['fmt_revbb']
		elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block')
			exe 'hi! StatusLine'.s:vars['fmt_none'].s:vars['fg_green'].s:vars['bg_base02'].s:vars['fmt_revbb']
		elseif (mode() ==# 'i')
			exe 'hi! StatusLine'.s:vars['fmt_none'].s:vars['fg_red'].s:vars['bg_base02'].s:vars['fmt_revbb']
		else
			exe 'hi! StatusLine '.s:vars['fmt_none'].s:vars['fg_base1'].s:vars['bg_base02'].s:vars['fmt_revbb']
		endif
	endif

	return ''
endfunction "}}}

set statusline=
set statusline+=%*%{ChangeStatuslineColor()}%*
set statusline^=%9*\ %{toupper(g:currentmode[mode()])}\ %*
set statusline+=%1*%m%r%h%w%*
set statusline+=%2*[%t:\ Buf\ %3*%n-%{Buf_total_num()}%2*]%*
set statusline+=%3*\ %{File_size(@%)}\ %*
set statusline+=%4*%{exists('g:loaded_fugitive')?fugitive#statusline():''}%*
set statusline+=%6*[Col=%6*%v%6*]%*
set statusline+=%6*[Row=%6*%l%6*/%7*%L(%p%%)%6*]%*

set statusline+=\ %=                        " align left
set statusline+=%{coc#status()}
set statusline+=[%b:0x%B]
set statusline+=%4*[TYPE=%5*%Y%4*]%*
set statusline+=%4*[FORMAT=%5*%{&ff}:%{&fenc!=''?&fenc:&enc}%4*]%*

hi User1 guibg=gray guifg=red
hi User2 guibg=#ffff5f guifg=black
hi User3 guibg=#ffff5f guifg=red

hi User6 guifg=white
hi User7 guifg=red

hi User4 guibg=#00ff00 guifg=black
hi User5 guibg=#00ff00 guifg=red

hi User9 guibg=#005fff guifg=yellow
"}}}
"Tabline {{{

set showtabline=2       " Always show the tabs line
set tabline+=%6*%F

"}}}
"vista{{{

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
  \ 'cpp': 'vim_lsp',
  \ 'php': 'vim_lsp',
  \ }

" Declare the command including the executable and options used to generate ctags output
" for some certain filetypes.The file path will be appened to your custom command.
" For example:
let g:vista_ctags_cmd = {
      \ 'haskell': 'hasktags -x -o - -c',
      \ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
"}}}
"rainbow{{{
let g:rainbow_active = 1"
let g:rainbow_conf = {
\   'guifgs': ['darkorange3', 'seagreen3', 'royalblue3', 'firebrick'],
\   'ctermfgs': ['lightyellow', 'lightcyan','lightblue', 'lightmagenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['darkorange3', 'seagreen3', 'royalblue3', 'firebrick'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}"}}}
"additional vim c++ syntax highlighting{{{


" Highlighting of class scope is disabled by default. To enable set
let g:cpp_class_scope_highlight = 1

" Highlighting of member variables is disabled by default. To enable set
let g:cpp_member_variable_highlight = 1

" Highlighting of class names in declarations is disabled by default. To enable set
let g:cpp_class_decl_highlight = 1

" Highlighting of POSIX functions is disabled by default. To enable set
let g:cpp_posix_standard = 1

" There are two ways to highlight template functions. Either
let g:cpp_experimental_simple_template_highlight = 1
" which works in most cases, but can be a little slow on large files. Alternatively set
" let g:cpp_experimental_template_highlight = 1
" which is a faster implementation but has some corner cases where it doesn't work.

" Note: C++ template syntax is notoriously difficult to parse, so don't expect this feature to be perfect.

" Highlighting of library concepts is enabled by
let g:cpp_concepts_highlight = 1

" This will highlight the keywords concept and requires as well as all named requirements (like DefaultConstructible) in the standard library.
" Highlighting of user defined functions can be disabled by
" let g:cpp_no_function_highlight = 1

"}}}
"vimspector{{{

let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" packadd! vimspector

nmap <silent> <leader>dd :call vimspector#Launch()<CR>
nmap <silent> <Leader>db :call vimspector#ToggleBreakpoint()<CR>
nmap <silent> <Leader>dc :call vimspector#Continue()<CR>
nmap <silent> <Leader>dx :call vimspector#Reset()<CR>
command -nargs=? Bpc call vimspector#ToggleBreakpoint([ { 'condition': '<f-args>' } ])

"}}}
"async task{{{

"告诉 asyncrun 运行时自动打开高度为 6 的 quickfix 窗口，不然你看不到任何输出，除非你自己手动用 :copen 打开它。
let g:asyncrun_open = 10

" ring the bell to notify you job finished
let g:asyncrun_bell = 1

" F10 to toggle quickfix window
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']

let g:asynctasks_system = 'macos'
"}}}
