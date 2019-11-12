"--------------------------------------------key map--------------------------------------------

"leader
let mapleader = ' '

noremap <leader>\ :set splitright<CR>:vsplit<CR>
noremap <leader>- :set splitbelow<CR>:split<CR>
noremap <leader>wh <C-w>h
noremap <leader>wl <C-w>l
noremap <leader>wj <C-w>j
noremap <leader>wk <C-w>k

noremap R :w<CR>:source $MYVIMRC<CR>

map <leader><leader> <Esc>/>anchor<<CR><leader><CR>cf<

map { c{<Esc>p
map [ c[<Esc>p
map < c<<Esc>p

noremap gd <C-]>
"-----------------------------------vim-Plug--------------------------------------------

call plug#begin('~/.vim/plugged')
if has('nvim')
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'kristijanhusak/defx-icons'
else
    Plug 'Shougo/defx.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'easymotion/vim-easymotion'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/vim-easy-align'
Plug 'severin-lemaignan/vim-minimap'

"Plug 'ycm-core/YouCompleteMe'
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Plug 'Raimondi/delimitMate'
Plug 'rhysd/vim-clang-format'
Plug 'Yggdroot/indentLine'
call plug#end()
"--------------------------------------theme--------------------------------------------

syntax on
colorscheme dracula

let &t_SI="\<Esc>]50;CursorShape=1\x7" " start insert mode
let &t_SR="\<Esc>]50;CursorShape=2\x7" " end insert mode
let &t_EI="\<Esc>]50;CursorShape=0\x7" " end insert mode
"-------------------------------------------------------
" defx configuration

" 使用 ;e 切换显示文件浏览，使用 ;a 查找到当前文件位置
let g:maplocalleader=';'
nnoremap <silent> <LocalLeader>e
            \ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent> <LocalLeader>a
            \ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

call defx#custom#option('_', {
            \ 'columns': 'indent:git:icons:filename',
            \ 'winwidth': 25,
            \ 'split': 'vertical',
            \ 'direction': 'topleft',
            \ 'listed': 1,
            \ 'show_ignored_files': 0,
            \ 'root_marker': '≡ ',
            \ 'ignored_files':
            \     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
            \   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc,*.swp'
            \ })

"autocmd FileType defx call s:defx_mappings()

" Avoid the white space highting issue
"autocmd FileType defx match ExtraWhitespace /^^/
" Keymap in defx
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    "IndentLinesDisable
    "setl spell
    "setl signcolumn=yes
    setl number
    nnoremap <silent><buffer><expr> <CR>
                \ defx#is_directory() ?
                \ defx#do_action('open_or_close_tree') :
                \ defx#do_action('drop',)
    nmap <silent><buffer><expr> <2-LeftMouse>
                \ defx#is_directory() ?
                \ defx#do_action('open_or_close_tree') :
                \ defx#do_action('drop',)
    "nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
    "nnoremap <silent><buffer><expr> v defx#do_action('drop', 'vsplit')
    "nnoremap <silent><buffer><expr> t defx#do_action('drop', 'tabe')
    "nnoremap <silent><buffer><expr> o defx#do_action('open_tree')
    "nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
    "nnoremap <silent><buffer><expr> C defx#do_action('copy')
    "nnoremap <silent><buffer><expr> P defx#do_action('paste')
    "nnoremap <silent><buffer><expr> M defx#do_action('rename')
    "nnoremap <silent><buffer><expr> D defx#do_action('remove_trash')
    "nnoremap <silent><buffer><expr> A defx#do_action('new_multiple_files')
    "nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
    "nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
    "nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
    "nnoremap <silent><buffer><expr> R defx#do_action('redraw')
endfunction

" Defx icons
" Requires nerd-font, install at https://github.com/ryanoasis/nerd-fonts or
" brew cask install font-hack-nerd-font
" Then set non-ascii font to Driod sans mono for powerline in iTerm2
" disbale syntax highlighting to prevent performence issue
"let g:defx_icons_enable_syntax_highlight = 1
""-----------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>a <Plug>(EasyAlign)
""-----------------------------------------------------
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
""-----------------------------------------------------

function! HeaderToggle() " bang for overwrite when saving vimrc
    let file_path = expand("%")
    let file_name = expand("%<")
    let extension = split(file_path, '\.')[-1] " '\.' is how you really split on dot
    let err_msg = "There is no file "

    if extension == "cpp"
        let next_file = join([file_name, ".h"], "")

        if filereadable(next_file)
            <CR>F %<.h
        else
            echo join([err_msg, next_file], "")
        endif
    elseif extension == "h"
        let next_file = join([file_name, ".c"], "")

        if filereadable(next_file)
            <CR>F %<.c
        else
            echo join([err_msg, next_file], "")
        endif
    endif
endfunction
nnoremap <Leader>o :call HeaderToggle()<CR>
""-----------------------------------------------------

" 使用 ss 启用
nmap ss <Plug>(easymotion-s2)
""-----------------------------------------------------

" vim mini map configuration
let g:minimap_toggle='<leader>mm'
""-----------------------------------------------------
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

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

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
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

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
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"------------------------------------others------------------------------------

set backspace=indent,eol,start  " make that backspace key work the way it should
set whichwrap+=<,>,h,l
set encoding=UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1


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
"set visualbell t_vb=            " turn off error beep/flash
"set t_vb=
"set tm=500

" show location
set cursorcolumn
set cursorline

" show
set ruler                       " show the current row and column

set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

set scrolloff=25
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
"set autoindent smartindent shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4                " insert mode tab and backspace use 4 spaces

"set completeopt=longest,menu
set wildmenu                           " show a navigable menu for tab completion"
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class


