" 设置runner，可以使用floaterm或者外部的terminal等
" https://github.com/skywind3000/asyncrun.vim/wiki/Customize-Runner
" https://github.com/voldikss/vim-floaterm#asynctasksvim
"告诉 asyncrun 运行时自动打开高度为 6 的 quickfix 窗口，不然你看不到任何输出，除非你自己手动用 :copen 打开它。
let g:asyncrun_open = 10

" ring the bell to notify you job finished
let g:asyncrun_bell = 1

" F10 to toggle quickfix window
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']

let g:asynctasks_system = 'macos'
