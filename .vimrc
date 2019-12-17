"Plug 'tpope/vim-repeat'""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KeyBoard ShortCut Mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" leader健为空格
let mapleader = " "

" vimrc自动生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC 
" hi MatchParen cterm=none ctermbg=red ctermfg=blue
hi MatchParen guibg=NONE guifg=blue gui=bold

noremap <leader>\ :set splitright<CR>:vsplit<CR>
noremap <leader>- :set splitbelow<CR>:split<CR>
noremap H ^
noremap L $
noremap <leader>wh <C-w>h
noremap <leader>wl <C-w>l
noremap <leader>wj <C-w>j
noremap <leader>wk <C-w>k
noremap <leader>wo <C-w>o
noremap <leader>wc <C-w>c
noremap <leader>wn <C-w>n

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

let &t_SI="\<Esc>]50;CursorShape=1\x7" " start insert mode
let &t_SR="\<Esc>]50;CursorShape=2\x7" " end insert mode
let &t_EI="\<Esc>]50;CursorShape=0\x7" " end insert mode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 一般设定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设定默认解码 
set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936

" 不要使用vi的键盘模式，而是vim自己的
set nocompatible

" history文件中需要记录的行数
set history=100

" 在处理未保存或只读文件的时候，弹出确认
set confirm

" 与windows共享剪贴板
set clipboard+=unnamed

" 侦测文件类型
filetype on

" 载入文件类型插件
filetype plugin on

" 为特定文件类型载入相关缩进文件
filetype indent on

" 保存全局变量
set viminfo+=!

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

" 语法高亮
syntax on

" 高亮字符，让其不受100列限制
:highlight OverLength ctermbg=red ctermfg=white guibg=redguifg=white
:match OverLength '\%101v.*'

" 状态行颜色
highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White

" 编译器设置
let g:syntastic_cpp_compiler = "g++"
let g:syntastic_cpp_compiler_options = '-std=c++17 -Wall -Wextra -Wpedantic'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文件设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 不要备份文件（根据自己需要取舍）
" set nobackup

" 不要生成swap文件，当buffer被丢弃的时候隐藏它
setlocal noswapfile
set bufhidden=hide

" 字符间插入的像素行数目
set linespace=0

" 增强模式中的命令行自动完成操作
set wildmenu

" 在状态行上显示光标所在位置的行号和列号
set ruler
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\%p%%%)

" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2

" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2

" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0

" 不让vim发出讨厌的滴滴声
set noerrorbells

" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索和匹配
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 高亮显示匹配的括号
set showmatch

" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5

" 在搜索的时候忽略大小写
set ignorecase

" 不要高亮被搜索的句子（phrases）
set hlsearch
"Fast no highlight
noremap <leader><cr> :noh<cr>

" 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set incsearch

" 输入:set list命令是应该显示些啥？
"set listchars=tab:\|\,trail:.,extends:>,precedes:<,eol:$

" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=25

" 不要闪烁
set novisualbell

" 我的状态行显示的内容（包括文件类型和解码）
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\[TYPE=%Y]\ [POS=%l,%v][%p%%]

" 总是显示状态行
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文本格式和排版
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 自动格式化
set formatoptions=tcrqn

" 继承前一行的缩进方式，特别适用于多行注释
set autoindent

" 为C程序提供自动缩进
set smartindent

" 使用C样式的缩进
set cindent

" 制表符为2
set tabstop=2

" 制表符为2
set softtabstop=2
set shiftwidth=2

" 不要用空格代替制表符
set noexpandtab

" 不要换行
set nowrap

" 在行和段开始处使用制表符
set smarttab

" 高亮显示光标
set cursorcolumn
set cursorline
" 显示行和列
set ruler                       " show the current row and column
set number relativenumber
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags的设定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 按照名称排序
let Tlist_Sort_Type = "name"

" 在右侧显示窗口
let Tlist_Use_Right_Window = 1

" 压缩方式
let Tlist_Compart_Format = 1

" 如果只有一个buffer，kill窗口也kill掉buffer
let Tlist_Exist_OnlyWindow = 1

" 不要关闭其他文件的tags
let Tlist_File_Fold_Auto_Close = 0

" 不要显示折叠树
let Tlist_Enable_Fold_Column = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" F5编译和运行C程序，F6编译和运行C++程序
" 请注意，下述代码在windows下使用会报错
" 需要去掉./这两个字符

" C的编译和运行
map <F5> :callCompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	exec "!gcc % -o %<"
	exec "! ./%<"
endfunc

" C++的编译和运行
map <F6> :callCompileRunGpp()<CR>
func! CompileRunGpp()
	exec "w"
	exec "!g++ % -o %<"
	exec "! ./%<"
endfunc

au BufReadPre *.nfo call setFileEncodings('cp437')|setambiwidth=single
au BufReadPost *.nfo call RestoreFileEncodings() 

" 用空格键来开关折叠
set foldenable
set foldmethod=indent
nnoremap <space>@=((foldclosed(line('.')) < 0) ? 'zc' :'zo')<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

Plug 'junegunn/vim-easy-align'

Plug 'Yggdroot/indentLine'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'honza/vim-snippets' " 内置了一堆语言的自动补全片段

Plug 'vim-scripts/DoxygenToolkit.vim' "doxygen 自动注释

Plug  'ericcurtin/CurtineIncSw.vim' "switch between cpp and head file

Plug 'brooth/far.vim'

Plug 'tpope/vim-repeat'

Plug 'terryma/vim-multiple-cursors'

call plug#end()

"""""""""""""""""""""""""""""""""""""
" color theme configuration
"""""""""""""""""""""""""""""""""""""

let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme gruvbox 
set background=dark
"""""""""""""""""""""""""""""""""""""
" coc configuration
"""""""""""""""""""""""""""""""""""""

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
	execute 'CocList grep '.word
endfunction

nnoremap <silent> <space>w  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>
"""""""""""""""""""""""""""""""""""""
" defx configration 
"""""""""""""""""""""""""""""""""""""

call defx#custom#option('_', {
			\ 'winwidth': 30,
			\ 'split': 'vertical',
			\ 'direction': 'topleft',
			\ 'show_ignored_files': 0,
			\ 'buffer_name': '',
			\ 'toggle': 1,
			\ 'resume': 1
			\ })

" 使用 ;e 切换显示文件浏览，使用 ;a 查找到当前文件位置
let g:maplocalleader=';'
nnoremap <silent> <LocalLeader>e
			\ :<C-u>Defx -columns=icons:indent:filename:type -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent> <LocalLeader>a
			\ :<C-u>Defx -columns=icons:indent:filename:type -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
	IndentLinesDisable
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

"""""""""""""""""""""""""""""""""""""
" defx git configration 
"""""""""""""""""""""""""""""""""""""
let g:defx_git#indicators = {
			\ 'Modified'  : '✹',
			\ 'Staged'    : '✚',
			\ 'Untracked' : '✭',
			\ 'Renamed'   : '➜',
			\ 'Unmerged'  : '═',
			\ 'Ignored'   : '☒',
			\ 'Deleted'   : '✖',
			\ 'Unknown'   : '?'
			\ }
let g:defx_git#column_length = 0

hi def link Defx_filename_directory NERDTreeDirSlash
hi def link Defx_git_Modified Special
hi def link Defx_git_Staged Function
hi def link Defx_git_Renamed Title
hi def link Defx_git_Unmerged Label
hi def link Defx_git_Untracked Tag
hi def link Defx_git_Ignored Comment

" disbale syntax highlighting to prevent performence issue
let g:defx_icons_enable_syntax_highlight = 1

"""""""""""""""""""""""""""""""""""""
" indentLine configration 
"""""""""""""""""""""""""""""""""""""

let g:indentLine_setColors = 0

"""""""""""""""""""""""""""""""""""""
" cpp-enhance-highlight configration 
"""""""""""""""""""""""""""""""""""""

let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
"""""""""""""""""""""""""""""""""""""
" doxygen configration 
"""""""""""""""""""""""""""""""""""""

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
"
" autosave delay, cursorhold trigger, default: 4000ms
setl updatetime=300

" highlight the word under cursor (CursorMoved is inperformant)
highlight WordUnderCursor cterm=reverse gui=reverse
autocmd CursorHold * call HighlightCursorWord()
function! HighlightCursorWord()
	" if hlsearch is active, don't overwrite it!
	let search = getreg('/')
	let cword = expand('<cword>')
	if match(cword, search) == -1
		exe printf('match WordUnderCursor /\V\<%s\>/', escape(cword, '/\'))
	endif
endfunction
"""""""""""""""""""""""""""""""""""""
" doxygen configration 
"""""""""""""""""""""""""""""""""""""

let g:far#file_mask_favorites= ['%', '**/*.*', '**/*.cpp **/*.h', '**/*.cpp', '**/*.h','**/*.html', '**/*.js', '**/*.css'] 

let g:far#default_file_mask='**/*.h **/*.cpp'
