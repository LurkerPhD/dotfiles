" Neo/vim Settings
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
		call s:source_file('config/terminal.vim')
	endif
endif

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
	set diffopt+=internal,algorithm:patience
	" set diffopt=indent-heuristic,algorithm:patience
endif

" }}}
" Editor UI {{{
" --------------------
set noshowmode          " Don't show mode in cmd window
set shortmess=aoOTI     " Shorten messages and don't show intro
set scrolloff=25         " Keep at least 2 lines above/below
set sidescrolloff=5       " Keep at least 5 lines left/right
" set nonumber            " Don't show line numbers
" set noruler             " Disable default status ruler
set ruler                       " show the current row and column
set number relativenumber
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	" autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END
set list                " Show hidden characters

set showtabline=2       " Always show the tabs line
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
set laststatus=2        " Always show a status line
set colorcolumn=80      " Highlight the 80th character limit
set display=lastline

if has('folding')
	set foldenable
	set foldmethod=marker
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

if exists('&winblend')
	" pseudo-transparency for floating window
	set winblend=20
endif

" }}}

" key-mappings
" ===
" Non-standard {{{
" ---

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

imap hhh <Esc>
imap jjj <Esc>
imap kkk <Esc>
imap lll <Esc>
imap <C-h> <left>
imap <C-j> <up>
imap <C-k> <down>
imap <C-l> <right>

" map <leader><leader> <Esc>/<CR><leader><CR>cf<

map <leader>pp :call CurtineIncSw()<CR>

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

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'Yggdroot/indentLine'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'honza/vim-snippets' " 内置了一堆语言的自动补全片段

Plug 'vim-scripts/DoxygenToolkit.vim' "doxygen 自动注释

Plug  'ericcurtin/CurtineIncSw.vim' "switch between cpp and head file

Plug 'tpope/vim-repeat'

Plug 'terryma/vim-multiple-cursors'

Plug 'neoclide/vim-easygit'

Plug 'sillybun/vim-repl'

Plug 'gilligan/vim-lldb'

Plug 'iamcco/mathjax-support-for-mkdp',{'do':{->mkdp#util#install()},'for':['markdown']}
Plug 'iamcco/markdown-preview.vim', {'for':['markdown']}

Plug 'lervag/vimtex' ", {'for':['latex']}

call plug#end()

"}}}

" Plugins settings
" ===
" color theme configuration{{{

let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme gruvbox 
" Show vim syntax highlight groups for character under cursor
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

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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
nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

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


" Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" let g:coc_snippet_next = '<tab>'

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
	nnoremap <silent><buffer><expr> w defx#do_action('call', '<SID>toggle_width')
	nnoremap <silent><buffer><expr> gd defx#async_action('multi', ['drop', ['call', '<SID>git_diff']])
	if exists('$TMUX')
		nnoremap <silent><buffer><expr> gl defx#async_action('call', '<SID>explorer')
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
" cpp-enhance-highlight configration {{{

let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
"}}}
" doxygen configration {{{

let g:DoxygenToolkit_briefTag_funcName = "yes"

" for C++ style, change the '@' to '\'
" let g:DoxygenToolkit_commentType = "C++"
" let g:DoxygenToolkit_briefTag_pre = "\@brief "
" let g:DoxygenToolkit_templateParamTag_pre = "\@tparam "
" let g:DoxygenToolkit_paramTag_pre = "\@param "
" let g:DoxygenToolkit_returnTag = "\@return "
" let g:DoxygenToolkit_throwTag_pre = "\@throw " " @exception is also valid
" let g:DoxygenToolkit_fileTag = "\@file "
" let g:DoxygenToolkit_dateTag = "\@date "
" let g:DoxygenToolkit_authorTag = "\@author "
" let g:DoxygenToolkit_versionTag = "\@version "
" let g:DoxygenToolkit_blockTag = "\@name "
" let g:DoxygenToolkit_classTag = "\@class "
let g:DoxygenToolkit_authorName = "Wang Zhecheng, wangzhecheng@yeah.net"
" let g:doxygen_enhanced_color = 1
" let g:load_doxygen_syntax = 1
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
" Statusline{{{
" ===

" let s:stl  = " %7*%{&paste ? '=' : ''}%*"         " Paste symbol
" let s:stl .= "%4*%{&readonly ? '' : '#'}%*"       " Modifide symbol
" let s:stl .= "%6*%{badge#mode('⚠ ', 'Z')}"        " Read-only symbol
" let s:stl .= '%*%n'                               " Buffer number
" let s:stl .= "%6*%{badge#modified('+')}%0*"       " Write symbol
" let s:stl .= ' %1*%{badge#filename()}%*'          " Filename
" let s:stl .= ' %<'                                " Truncate here
" let s:stl .= '%( %{badge#branch()} %)'           " Git branch name
" let s:stl .= '%3*%( %{badge#gitstatus()} %)%*'    " Git status
" let s:stl .= '%4*%(%{badge#syntax()} %)%*'        " syntax check
" let s:stl .= "%4*%(%{badge#trails('␣%s')} %)%*"   " Whitespace
" let s:stl .= '%3*%{badge#indexing()}%*'           " Indexing tags indicator
" let s:stl .= '%='                                 " Align to right
" let s:stl .= '%{badge#format()} %4*%*'           " File format
" let s:stl .= '%( %{&fenc} %)'                     " File encoding
" let s:stl .= '%4*%*%( %{&ft} %)'                 " File type
" let s:stl .= '%3*%2* %l/%2c%4p%% '               " Line and column

" " Non-active Statusline
" let s:stl_nc = " %{badge#mode('⚠ ', 'Z')}%n"   " Readonly & buffer
" let s:stl_nc .= "%6*%{badge#modified('+')}%*"  " Write symbol
" let s:stl_nc .= ' %{badge#filename()}'         " Relative supername
" let s:stl_nc .= '%='                           " Align to right
" let s:stl_nc .= '%{&ft} '                      " File type

" " Status-line blacklist
" let s:disable_statusline =
"   \ 'denite\|vista\|tagbar\|undotree\|diff\|peekaboo\|sidemenu'

" function! s:refresh()
"   if &filetype ==# 'defx'
"     let &l:statusline = '%y %<%=%{badge#filename()}%= %l/%L'
"   elseif &filetype ==# 'magit'
"     let &l:statusline = '%y %{badge#gitstatus()}%<%=%{badge#filename()}%= %l/%L'
"   elseif &filetype !~# s:disable_statusline
"     let &l:statusline = s:stl
"   endif
" endfunction

" function! s:refresh_inactive()
"   if &filetype ==# 'defx'
"     let &l:statusline = '%y %= %l/%L'
"   elseif &filetype ==# 'magit'
"     let &l:statusline = '%y %{badge#gitstatus()}%= %l/%L'
"   elseif &filetype !~# s:disable_statusline
"     let &l:statusline = s:stl_nc
"   endif
" endfunction

" augroup user_statusline
"   autocmd!

"   autocmd FileType,WinEnter,BufWinEnter,BufReadPost * call s:refresh()
"   autocmd WinLeave * call s:refresh_inactive()
"   autocmd BufNewFile,ShellCmdPost,BufWritePost * call s:refresh()
"   autocmd FileChangedShellPost,ColorScheme * call s:refresh()
"   " autocmd FileReadPre,ShellCmdPost,FileWritePost * call s:refresh()
"   autocmd User CocStatusChange,CocGitStatusChange call s:refresh()
"   autocmd User CocDiagnosticChange call s:refresh()
"   autocmd User GutentagsUpdating call s:refresh()
" augroup END
"}}}
" easy git configuration{{{
let g:easygit_enable_command = 1
"}}}
" markdown preview configuration{{{
let g:mkdp_path_to_chrome = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"

" 设置 chrome 浏览器的路径（或是启动 chrome（或其他现代浏览器）的命令）
" 如果设置了该参数, g:mkdp_browserfunc 将被忽略

let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
" vim 回调函数, 参数为要打开的 url

let g:mkdp_auto_start = 0
" 设置为 1 可以在打开 markdown 文件的时候自动打开浏览器预览，只在打开
" markdown 文件的时候打开一次

let g:mkdp_auto_open = 0
" 设置为 1 在编辑 markdown 的时候检查预览窗口是否已经打开，否则自动打开预
" 览窗口

let g:mkdp_auto_close = 1
" 在切换 buffer 的时候自动关闭预览窗口，设置为 0 则在切换 buffer 的时候不
" 自动关闭预览窗口

let g:mkdp_refresh_slow = 0
" 设置为 1 则只有在保存文件，或退出插入模式的时候更新预览，默认为 0，实时
" 更新预览

let g:mkdp_command_for_global = 0
" 设置为 1 则所有文件都可以使用 MarkdownPreview 进行预览，默认只有 markdown
" 文件可以使用改命令

let g:mkdp_open_to_the_world = 0
" 设置为 1, 在使用的网络中的其他计算机也能访问预览页面
" 默认只监听本地（127.0.0.1），其他计算机不能访问
" }}}
" vim-latex configuration{{{
let g:tex_flavor='latex'

if empty(v:servername) && exists('*remote_startserver')
	call remote_startserver('VIM')
endif

let g:vimtex_compiler_method='latexmk'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_view_use_temp_files=1
set conceallevel=1
let g:tex_conceal='abdmg'

" }}}

" vim-badge - Bite-size badges for tab & status lines{{{
" Maintainer: Rafael Bodill <justrafi at gmail dot com>
"-------------------------------------------------

" Configuration

"" Limit display of directories in path
"let g:badge_tab_filename_max_dirs =
"	\ get(g:, 'badge_tab_filename_max_dirs', 1)

"" Limit display of characters in each directory in path
"let g:badge_tab_dir_max_chars =
"	\ get(g:, 'badge_tab_dir_max_chars', 5)

"" Maximum number of directories in filepath
"let g:badge_status_filename_max_dirs =
"	\ get(g:, 'badge_status_filename_max_dirs', 3)

"" Maximum number of characters in each directory
"let g:badge_status_dir_max_chars =
"	\ get(g:, 'badge_status_dir_max_chars', 5)

"" Less verbosity on specific filetypes (regexp)
"let g:badge_filetype_blacklist =
"	\ get(g:, 'badge_filetype_blacklist',
"	\ 'qf\|help\|vimfiler\|gundo\|diff\|fugitive\|gitv')

"let g:badge_numeric_charset =
"	\ get(g:, 'badge_numeric_charset',
"	\ ['⁰','¹','²','³','⁴','⁵','⁶','⁷','⁸','⁹'])
"	"\ ['₀','₁','₂','₃','₄','₅','₆','₇','₈','₉'])

"let g:badge_loading_charset =
"	\ get(g:, 'badge_loading_charset',
"	\ ['⠃', '⠁', '⠉', '⠈', '⠐', '⠠', '⢠', '⣠', '⠄', '⠂'])

"let g:badge_nofile = get(g:, 'badge_nofile', 'N/A')

"let g:badge_project_separator = get(g:, 'badge_project_separator', '')

"" Clear cache on save
"augroup statusline_cache
"	autocmd!
"	autocmd BufWritePre,WinEnter,BufReadPost * call badge#clear_cache()
"	autocmd User NeomakeJobFinished call badge#clear_cache()
"	autocmd User CocDiagnosticChange call badge#clear_cache()
"	autocmd User CocStatusChange call badge#clear_cache()
"augroup END

"function! badge#clear_cache() abort
"	unlet! b:badge_cache_trails b:badge_cache_syntax
"		\ b:badge_cache_filename b:badge_cache_tab
"endfunction

"function! badge#project() abort
"	" Try to guess the project's name

"	let dir = badge#root()
"	return fnamemodify(dir ? dir : getcwd(), ':t')
"endfunction

"function! badge#gitstatus(...) abort
"	" Display git status indicators

"	let l:icons = ['₊', '∗', '₋']  " added, modified, removed
"	let l:out = ''
"	" if &filetype ==# 'magit'
"	"	let l:map = {}
"	"	for l:file in magit#git#get_status()
"	"		let l:map[l:file['unstaged']] = get(l:map, l:file['unstaged'], 0) + 1
"	"	endfor
"	"	for l:status in l:map
"	"		let l:out = values(l:map)
"	"	endfor
"	" else
"		if exists('*gitgutter#hunk#summary')
"			let l:summary = gitgutter#hunk#summary(bufnr('%'))
"			for l:idx in range(0, len(l:summary) - 1)
"				if l:summary[l:idx] > 0
"					let l:out .= ' ' . l:icons[l:idx] . l:summary[l:idx]
"				endif
"			endfor
"		endif
"	" endif
"	return trim(l:out)
"endfunction

"function! badge#filename(...) abort
"	" Provides relative path with limited characters in each directory name, and
"	" limits number of total directories. Caches the result for current buffer.
"	" Parameters:
"	"   1: Buffer number, ignored if tab number supplied
"	"   2: Tab number
"	"   3: Enable to append total window count in tab
"	"   4: Include project directory if different from current

"	" Compute buffer name
"	if a:0 > 1
"		let l:buflist = tabpagebuflist(a:2)
"		let l:bufnr = l:buflist[tabpagewinnr(a:2) - 1]
"	elseif a:0 == 1
"		let l:bufnr = a:1
"	elseif a:0 == 0
"		let l:bufnr = '%'
"	endif

"	" Use buffer's cached filepath
"	let l:cache_var_name = 'badge_cache_' . (a:0 > 1 ? 'tab' : 'filename')
"	let l:fn = getbufvar(l:bufnr, l:cache_var_name, '')
"	if len(l:fn) > 0
"		return l:fn
"	endif

"	let l:bufname = bufname(l:bufnr)
"	let l:filetype = getbufvar(l:bufnr, '&filetype')

"	if a:0 < 2 && l:filetype =~? g:badge_filetype_blacklist
"		" Empty if owned by certain plugins
"		let l:fn = ''
"	elseif a:0 < 2 && l:filetype ==# 'defx'
"		let l:defx = getbufvar(l:bufnr, 'defx')
"		let l:fn = get(get(l:defx, 'context', {}), 'buffer_name')
"		unlet! l:defx
"	elseif a:0 < 2 && l:filetype ==# 'magit'
"		let l:fn = magit#git#top_dir()
"	elseif a:0 < 2 && l:filetype ==# 'vimfiler'
"		let l:fn = vimfiler#get_status_string()
"	elseif empty(l:bufname)
"		" Placeholder for empty buffer
"		let l:fn = g:badge_nofile
"	else
"		" let l:icons = defx_icons#get()
"		" Shorten dir names
"		let l:max = a:0 > 1 ?
"			\ g:badge_tab_dir_max_chars : g:badge_status_dir_max_chars
"		let short = substitute(l:bufname,
"			\ "[^/]\\{" . l:max . "}\\zs[^/]\*\\ze/", '', 'g')

"		" Decrease dir count
"		let l:max = a:0 > 1 ?
"			\ g:badge_tab_filename_max_dirs : g:badge_status_filename_max_dirs
"		let parts = split(short, '/')
"		if len(parts) > l:max
"			let parts = parts[-l:max-1 : ]
"		endif
"		let l:fn = join(parts, '/')
"	endif

"	" Append fugitive blob type
"	let l:fugitive = getbufvar(l:bufnr, 'fugitive_type')
"	if l:fugitive ==# 'blob'
"		let l:fn .= ' (blob)'
"	endif

"	" Append window count, for tabs
"	if a:0 > 2 && a:3
"		let l:win_count = tabpagewinnr(a:2, '$')
"		if l:win_count > 1
"			let l:fn .= s:numtr(l:win_count, g:badge_numeric_charset)
"		endif
"	endif

"	" Prepend project dir, for tabs
"	if a:0 > 3 && a:4
"		" g:badge_project_separator
"		" let project_dir = getbufvar(a:n, 'project_dir')
"		" if strridx(filepath, project_dir) == 0
"		"	let filepath = strpart(filepath, len(project_dir))
"		"	let project .= fnamemodify(project_dir, ':t') . (a:0 > 0 ? a:1 : '|')
"		"	let l:fn = project . l:fn
"		"	endif
"	endif

"	" Cache and return the final result
"	call setbufvar(l:bufnr, l:cache_var_name, l:fn)
"	return l:fn
"endfunction

"function! badge#root() abort
"	" Find the root directory by searching for the version-control dir

"	let dir = getbufvar('%', 'project_dir')
"	let curr_dir = getcwd()
"	if empty(dir) || getbufvar('%', 'project_dir_last_cwd') != curr_dir
"		let patterns = ['.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']
"		for pattern in patterns
"			let is_dir = stridx(pattern, '/') != -1
"			let match = is_dir ? finddir(pattern, curr_dir.';')
"				\ : findfile(pattern, curr_dir.';')
"			if ! empty(match)
"				let dir = fnamemodify(match, is_dir ? ':p:h:h' : ':p:h')
"				call setbufvar('%', 'project_dir', dir)
"				call setbufvar('%', 'project_dir_last_cwd', curr_dir)
"				break
"			endif
"		endfor
"	endif
"	return dir
"endfunction

"function! badge#branch() abort
"	" Returns git branch name, using different plugins.

"	if &filetype !~? g:badge_filetype_blacklist
"		if exists('*gitbranch#name')
"			return gitbranch#name()
"		elseif exists('*vcs#info')
"			return vcs#info('%b')
"		elseif exists('fugitive#head')
"			return fugitive#head(8)
"		endif
"	endif
"	return ''
"endfunction

"function! badge#syntax() abort
"	" Returns syntax warnings from several plugins (Neomake and syntastic)

"	if &filetype =~? g:badge_filetype_blacklist
"		return ''
"	endif

"	let l:errors = 0
"	let l:warnings = 0
"	if ! exists('b:badge_cache_syntax') || empty(b:badge_cache_syntax)
"		let b:badge_cache_syntax = ''
"		if exists('*neomake#Make')
"			let l:counts = neomake#statusline#get_counts(bufnr('%'))
"			let l:errors = get(l:counts, 'E', '')
"			let l:warnings = get(l:counts, 'W', '')
"		elseif exists('g:loaded_ale')
"			let l:counts = ale#statusline#Count(bufnr('%'))
"			let l:errors = l:counts.error + l:counts.style_error
"			let l:warnings = l:counts.total - l:errors
"		elseif exists('*SyntasticStatuslineFlag')
"			let b:badge_cache_syntax = SyntasticStatuslineFlag()
"		endif
"		if l:errors > 0
"			let b:badge_cache_syntax .= printf(' %d ', l:errors)
"		endif
"		if l:warnings > 0
"			let b:badge_cache_syntax .= printf(' %d ', l:warnings)
"		endif
"		let b:badge_cache_syntax = substitute(b:badge_cache_syntax, '\s*$', '', '')
"	endif

"	return b:badge_cache_syntax
"endfunction

"function! badge#trails(...) abort
"	" Detect trailing whitespace and cache result per buffer
"			if trailing != 0
"				let label = a:0 == 1 ? a:1 : 'WS:%s'
"				let b:badge_cache_trails .= printf(label, trailing)
"			endif
"		endif
"	endif
"	return b:badge_cache_trails
"endfunction

"function! badge#modified(...) abort
"	" Make sure we ignore &modified when choosewin is active
"	" Parameters:
"	"   Modified symbol, default: +

"	let label = a:0 == 1 ? a:1 : '+'
"	let choosewin = exists('g:choosewin_active') && g:choosewin_active
"	return &modified && ! choosewin ? label : ''
"endfunction

"function! badge#mode(...) abort
"	" Returns file's mode: read-only and/or zoomed
"	" Parameters:
"	"   Read-only symbol, default: R
"	"   Zoomed buffer symbol, default: Z

"	let s:modes = ''
"	if &filetype !~? g:badge_filetype_blacklist && &readonly
"		let s:modes .= a:0 > 0 ? a:1 : 'R'
"	endif
"	if exists('t:zoomed') && bufnr('%') == t:zoomed.nr
"		let s:modes .= a:0 > 1 ? a:2 : 'Z'
"	endif

"	return s:modes
"endfunction

"function! badge#format() abort
"	" Returns file format

"	return &filetype =~? g:badge_filetype_blacklist ? '' : &fileformat
"endfunction

"function! badge#session(...) abort
"	" Returns an indicator for active session
"	" Parameters:
"	"   Active session symbol, default: [S]

"	return empty(v:this_session) ? '' : a:0 == 1 ? a:1 : '[S]'
"endfunction

"function! badge#indexing() abort
"	let l:out = ''

"	if exists('*gutentags#statusline')
"		let l:tags = gutentags#statusline('[', ']')
"		if ! empty(l:tags)
"			if exists('*reltime')
"				let s:wait = split(reltimestr(reltime()), '\.')[1] / 100000
"			else
"				let s:wait = get(s:, 'wait', 9) == 9 ? 0 : s:wait + 1
"			endif
"			let l:out .= get(g:badge_loading_charset, s:wait, '') . ' ' . l:tags
"		endif
"	endif
"	if exists('*coc#status')
"		let l:out .= coc#status()
"	endif
"	if exists('g:SessionLoad') && g:SessionLoad == 1
"		let l:out .= '[s]'
"	endif
"	return l:out
"endfunction

"function! s:numtr(number, charset) abort
"	let l:result = ''
"	for l:char in split(a:number, '\zs')
"		let l:result .= a:charset[l:char]
"	endfor
"	return l:result
"endfunction

" vim: set ts=2 sw=2 tw=80 noet :}}}
