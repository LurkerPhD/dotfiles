" Disable arrow movement, resize splits instead.{{{
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
"}}}
" Change current word in a repeatable manner{{{
nnoremap <leader>cn *``cgn
nnoremap <leader>cN *``cgN
"}}}
" Change selected word in a repeatable manner{{{
vnoremap <expr> <leader>cn "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"
vnoremap <expr> <leader>cN "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"

nnoremap <leader>cp yap<S-}>p
"}}}
" Start an external command with a single bang{{{
nnoremap ! :!
"}}}
" Allow misspellings{{{
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd

nnoremap zl z5l
nnoremap zh z5h
"}}}
" Use backspace key for matchit.vim{{{
nmap <BS> %
xmap <BS> %

nmap <silent> <Leader><CR> :nohlsearch<CR>
"}}}
" window manuvar{{{
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
"}}}
" jk表示esc{{{
inoremap jk <esc>
"}}}
" Use tab for indenting{{{
xnoremap <Tab> >gv|
xnoremap <S-Tab> <gv
"}}}
" 使用esc退出终端{{{
if has('nvim')
    au TermOpen term://* tnoremap <buffer> <Esc> <c-\><c-n> | startinsert
    au BufEnter term://* startinsert
else
    au TerminalOpen term://* tnoremap <buffer> <Esc> <C-\><C-n> | startinsert
    " au BufEnter term://* startinsert
endif
"}}}
" 新建终端1{{{
nnoremap <leader>tt :terminal<cr>
"}}}
" 插入模式下的一些快捷键1{{{
imap <C-h> <left>
imap <C-j> <up>
imap <C-k> <down>
imap <C-l> <right>
"}}}
" tab相关{{{
nnoremap <silent> <leader>tn :tabnew<cr>
nnoremap <silent> <leader>tc :tabclose<cr>
nnoremap <silent> <M-L> :tabmove +1<cr>
nnoremap <silent> <M-H> :tabmove -1<cr>
tnoremap <silent> <M-L> <c-\><c-n>:tabmove +1<cr>
tnoremap <silent> <M-H> <c-\><c-n>:tabmove -1<cr>
"}}}
" TODO 改成在fzf中搜索系统应用，快捷键改成altx{{{
function! s:SystemExecuteCurrentFile(f)
    if g:isWindows | echo
    else
        exec 'silent !xdg-open ' . fnameescape(a:f) . ' > /dev/null'
    endif
endfunction
"}}}
" 使用系统应用打开当前buffer文件{{{
noremap <silent> <M-o> :call <SID>SystemExecuteCurrentFile(expand('%:p'))<cr>
"}}}
" Yank buffer's absolute path to clipboard{{{
nnoremap <Leader>yp :let @+=expand("%")<CR>:echo 'Yanked relative path'<CR>
nnoremap <Leader>Yp :let @+=expand("%:p")<CR>:echo 'Yanked absolute path'<CR>
"}}}
" Location/quickfix list movement{{{
nmap ]c :lnext<CR>
nmap [c :lprev<CR>
nmap ]q :cnext<CR>
nmap [q :cprev<CR>
"}}}
"lsp相关{{{
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
"}}}
