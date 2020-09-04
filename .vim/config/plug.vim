" 代码补全插件
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'junegunn/fzf.vim'
\ | Plug 'junegunn/fzf', { 'do': {-> fzf#install()} }
\ | Plug 'tpope/vim-fugitive'
\ | Plug 'antoinemadec/coc-fzf'

" 注释插件
Plug 'tpope/vim-commentary' "自动注释

" 生成注释文档
Plug 'kkoomen/vim-doge', {'on': 'DogeGenerate'}

" 主题theme类插件
Plug 'ajmwagar/vim-deus'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/forest-night'
Plug 'srcery-colors/srcery-vim'
Plug 'hardcoreplayers/oceanic-material'
Plug 'chuling/ci_dark'

" 底栏
Plug 'itchyny/lightline.vim'

" 函数列表
Plug 'liuchengxu/vista.vim', {'on': ['Vista!!', 'Vista']}

" 快速包围
Plug 'tpope/vim-surround'

" 重复上次的动作
Plug 'tpope/vim-repeat'

" 显示清除尾部空格
Plug 'ntpeters/vim-better-whitespace'

" 代码段
Plug 'honza/vim-snippets'
"
" 快速移动
Plug 'easymotion/vim-easymotion', {'on':
    \ [
    \ '<Plug>(easymotion-bd-f)', '<Plug>(easymotion-overwin-f)',
    \ '<Plug>(easymotion-overwin-f2)', '<Plug>(easymotion-bd-jk)',
    \ '<Plug>(easymotion-overwin-line)', '<Plug>(easymotion-bd-w)',
    \ '<Plug>(easymotion-overwin-w)'
    \ ]}

" 对齐
Plug 'junegunn/vim-easy-align', {'on': ['EasyAlign']}

" 对齐线
Plug 'Yggdroot/indentLine'

" csv插件
Plug 'chrisbra/csv.vim', {'for': 'csv'}

" 悬浮终端
Plug 'voldikss/vim-floaterm', {'on': ['FloatermNew', 'FloatermToggle']}

" 起始界面
Plug 'mhinz/vim-startify'

" tmux相关插件
if strlen($TMUX) && executable("tmux")
    " tmux与vim窗口间导航
    Plug 'christoomey/vim-tmux-navigator'
    " tmux.conf set -g focus-events on
    Plug 'tmux-plugins/vim-tmux-focus-events'
    " 在tmux和vim之间进行复制与粘贴
    Plug 'roxma/vim-tmux-clipboard'
    " 使用vim的主题配置tmux主题
    Plug 'edkolev/tmuxline.vim', {'on': 'Tmuxline'}
endif

" latex插件
Plug 'lervag/vimtex', {'for': 'tex'}

" 平滑滚动
Plug 'psliwka/vim-smoothie'

" vim中文文档
Plug 'yianwillis/vimcdoc'

" vim打开pdf
Plug 'makerj/vim-pdf', {'for': 'pdf'}

" debug
 Plug 'puremourning/vimspector'

" 运行代码
Plug 'skywind3000/asynctasks.vim', {'On': ['asynctask','asynctaskedit','asynctasklist','asynctaskmarco', 'asynctaskprofile']}
Plug 'skywind3000/asyncrun.vim', {'On': ['asyncrun', 'asyncstop']}
Plug 'Shatur95/vim-cmake-projects'

" 菜单栏
Plug 'skywind3000/vim-quickui'

" 总是匹配tag
Plug 'valloric/MatchTagAlways', {'for': ['html', 'css', 'xml']}

" 显示颜色
if has('nvim')
    Plug 'norcalli/nvim-colorizer.lua'
else
    Plug 'RRethy/vim-hexokinase',  { 'do': 'make hexokinase' }
endif

" json 注释
Plug 'kevinoid/vim-jsonc'
" ------------------------------------------------------------------------------
" ------------------------------------------------------------------------------
" ------------------------------------------------------------------------------

" coc插件列表，可根据需要进行删减
let g:coc_global_extensions = [
   \ 'coc-marketplace',
   \ 'coc-explorer',
   \ 'coc-lists',
   \ 'coc-yank',
   \ 'coc-clangd',
   \ 'coc-json',
   \ 'coc-cmake',
   \ 'coc-xml',
   \ 'coc-yaml',
   \ 'coc-git',
   \ 'coc-pairs',
   \ 'coc-prettier',
   \ 'coc-snippets',
   \ 'coc-tasks'
   \ ]

   " \ 'coc-tsserver',
   " \ 'coc-sh',
   " \ 'coc-word',
   " \ 'coc-bookmark',
   " \ 'coc-python',
   " \ 'coc-pyright',
   " \ 'coc-calc',

   " \ 'coc-tabnine',
   "\ 'coc-ccls',
   "\ 'coc-vimlsp',
   "\ 'coc-fzf-preview',
   "\ 'coc-rainbow-fart',
   "\ 'coc-rls',
   "\ 'coc-java',
   "\ 'coc-go',
   "\ 'coc-sql',

" Plug 'neovim/nvim-lsp'

" Plug 'nvim-treesitter/nvim-treesitter'

" 检索
" Plug 'vifm/vifm.vim' "file manager

" 笔记插件，支持markdown
" Plug 'vimwiki/vimwiki', {'on': ['VimwikiIndex', 'VimwikiTabIndex', 'VimwikiDiaryIndex']}

" 自动补全括号
" Plug 'jiangmiao/auto-pairs'

" 关闭buffer而不关闭窗口
" Plug 'rbgrouleff/bclose.vim', {'on': 'Bclose'}

" 专注阅读
" Plug 'junegunn/goyo.vim', { 'on': 'Goyo', 'for': 'markdown' }
"\ | Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
"
" 在命令行使用linux命令新建文件文件夹重命名当前buffer等
" Plug 'tpope/vim-eunuch', {'on': ['Mkdir', 'Rename', 'Unlink', 'Delete', 'Move', 'Chmod', 'Cfind', 'Clocate', 'Lfine', 'Llocate', 'SudoEdit', 'SudoWrite', 'Wall', 'W']}

" 绘图插件
" Plug 'davinche/DrawIt', {'on': 'DrawIt'}
