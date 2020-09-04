
" delete plugs which not on plug list{{{
function! s:uninstall_unused_coc_extensions() abort
  for e in keys(json_decode(join(readfile(expand(g:coc_data_home . '/extensions/package.json')), "\n"))['dependencies'])
    if index(g:coc_global_extensions, e) < 0
      execute 'CocUninstall ' . e
    endif
  endfor
endfunction
autocmd User CocNvimInit call s:uninstall_unused_coc_extensions()
"}}}

" tab选择下一个补全{{{
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" 回车选中或者扩展选中的补全内容
if exists('*complete_info')
  " 如果您的（Neo）Vim版本支持，则使用`complete_info`
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
"}}}

" diagnostic 跳转
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" 跳转到定义{{{

nmap <silent> gd <plug>(coc-definition)
" 跳转到类型定义
nmap <silent> gy <plug>(coc-type-definition)
" 跳转到实现
nmap <silent> gi <plug>(coc-implementation)
" 跳转到引用
nmap <silent> gr <plug>(coc-references)

"}}}

" 使用K悬浮显示定义{{{

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" 函数文档
nnoremap <silent> K :call <SID>show_documentation()<CR>
" 函数参数的文档
nnoremap <silent> <leader>k :call CocActionAsync('showSignatureHelp')<CR>

"}}}

"{{{
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" 格式化代码
nmap <leader>fm :call CocAction('format')<CR>
"}}}

au CursorHoldI * sil call CocActionAsync('showSignatureHelp')

"""""""""""""""""""""""
" coc-plug config
"""""""""""""""""""""""

" 变量重命名
" nmap <leader>rn <Plug>(coc-rename)
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>

" grep word{{{
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>
" Keymapping for grep word under cursor with interactive mode
function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

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
"}}}

" popup
nmap <Leader>tl <Plug>(coc-translator-p)


"{{{
if g:HasPlug('coc-fzf')
  nnoremap <silent> <leader>A  :<C-u>CocFzfList diagnostics<CR>
  nnoremap <silent> <leader>a  :<C-u>CocFzfList diagnostics --current-buf<CR>
  " nnoremap <silent> <leader>c  :<C-u>CocFzfList commands<CR>
  nnoremap <silent> <leader>e  :<C-u>CocFzfList extensions<CR>
  nnoremap <silent> <leader>l  :<C-u>CocFzfList<CR>
  " nnoremap <silent> <leader>l  :<C-u>CocFzfList location<CR>
  " nnoremap <silent> <leader>o  :<C-u>CocFzfList outline<CR>
  " nnoremap <silent> <leader>O  :<C-u>CocFzfList symbols<CR>
  nnoremap <silent> <leader>s  :<C-u>CocFzfList services<CR>
  " nnoremap <silent> <leader>pl  :<C-u>CocFzfListResume<CR>
  nnoremap <silent> <leader>pl  :<C-u>CocListResume<CR>

  if g:HasCocPlug('coc-yank')
    nnoremap <silent> <leader>y  :<C-u>CocFzfList yank<CR>
  endif
else
  " Show all diagnostics
  if g:HasPlug('fzf-preview.vim')
    nnoremap <silent> <leader>a  :<C-u>CocCommand fzf-preview.CocCurrentDiagnostics<cr>
    nnoremap <silent> <leader>A  :<C-u>CocCommand fzf-preview.CocDiagnostics<cr>
  else
    nnoremap <silent> <leader>a  :<C-u>CocList --normal diagnostics<cr>
  endif
  " Manage extensions
  " nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
  " nnoremap <silent> <leader>o  :<C-u>CocList --auto-preview outline<cr>
  " nnoremap <silent> <leader>O  :<C-u>CocList --auto-preview --interactive symbols<cr>
  " Show commands
  " nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
  " Resume latest coc list
  nnoremap <silent> <leader>pl  :<C-u>CocListResume<CR>
  " nnoremap <silent> <leader>s  :<C-u>CocList services<CR>
  " show coclist 早晚要放进去的
  " nnoremap <silent> <leader>l  :<C-u>CocList<CR>
endif
"}}}
"{{{
if !g:HasPlug("vim-visual-multi")
  " ctrl n下一个，ctrl p上一个
  " ctrl c 添加一个光标再按一次取消，
  nmap <silent> <C-c> <Plug>(coc-cursors-position)
  nmap <expr> <silent> <C-n> <SID>select_current_word()
  function! s:select_current_word()
    if !get(g:, 'coc_cursors_activated', 0)
      return "\<Plug>(coc-cursors-word)"
    endif
    return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
  endfunc

  xmap <silent> <C-n> y/\V<C-r>=escape(@",'/\')<CR><CR>gN<Plug>(coc-cursors-range)gn
  " nmap <silent> <C-a> :CocCommand document.renameCurrentWord<cr>

  " use normal command like `<leader>xi(`
  nmap <leader>x  <Plug>(coc-cursors-operator)
endif
"}}}
"{{{
if g:HasCocPlug('coc-highlight')
  " 高亮当前光标下的所有单词
  au CursorHold * silent call CocActionAsync('highlight')
endif
"}}}
"{{{
if !has('nvim') || !g:HasPlug('fzf.vim') && !g:HasPlug('LeaderF') && !g:HasPlug('vim-clap')
  if g:HasCocPlug('coc-lists')
    nnoremap <silent> <M-b> :CocList buffers<CR>
    nnoremap <silent> <M-c> :CocList vimcommands<CR>
    " tags, 需要先generate tags
    nnoremap <silent> <M-t> :CocList tags<cr>
    nnoremap <silent> <M-s> :CocList --auto-preview --interactive grep<cr>
    nnoremap <silent> ? :CocList --auto-preview --interactive lines<cr>
    nnoremap <silent> <M-r> :CocList mru -A<CR>
    nnoremap <silent> <M-m> :CocList marks<CR>
    nnoremap <silent> <M-M> :CocList maps<CR>
    nnoremap <silent> <M-w> :CocList windows<CR>

  endif

  if g:HasCocPlug('coc-git')
    nnoremap <silent> <leader>gm :CocList bcommits<CR>
    nnoremap <silent> <leader>gM :CocList commits<CR>
  endif
endif
"}}}
"{{{
if g:HasCocPlug('coc-snippets')
  " alt j k 用于补全块的跳转
  let g:coc_snippet_next = '<m-j>'
  let g:coc_snippet_prev = '<m-k>'
endif
"}}}
"{{{
if g:HasCocPlug('coc-yank')
  " nnoremap <silent> <leader>y  :<C-u>CocList yank<cr>
  if !g:HasPlug('vim-clap') && !g:HasPlug('fzf')
    nnoremap <silent> <M-y>  :<C-u>CocList yank<cr>
  endif
  call coc#config('yank.highlight.duration', 200)
  call coc#config('yank.enableCompletion', v:false)
endif
"}}}
"{{{
if g:HasCocPlug('coc-translator')
  nmap  <M-e> <Plug>(coc-translator-e)
  nmap  <M-d> <Plug>(coc-translator-p)
endif
"}}}
"{{{
if g:HasCocPlug('coc-bookmark')
  if !g:HasPlug('vim-bookmarks')
    call coc#config("bookmark.sign", "♥")
    nmap <silent> ma <Plug>(coc-bookmark-annotate)
    nmap <silent> mm <Plug>(coc-bookmark-toggle)
    nmap <silent> mj <Plug>(coc-bookmark-next)
    nmap <silent> mk <Plug>(coc-bookmark-prev)
    nmap <silent> mc :CocCommand bookmark.clearForCurrentFile<cr>
    nmap <silent> ml :CocList bookmark<cr>
  endif
endif
"}}}
"{{{
if g:HasCocPlug('coc-todolist')
  nmap <silent> <leader>tl :<C-u>CocList todolist<cr>
  nmap <silent> <leader>ta :<C-u>CocCommand todolist.create<cr>
endif
"}}}
"{{{
if g:HasCocPlug('coc-git')
  " 导航到修改块
  nmap <leader>gk <Plug>(coc-git-prevchunk)
  nmap <leader>gj <Plug>(coc-git-nextchunk)
  " 显示光标处的修改信息
  nmap <leader>gp <Plug>(coc-git-chunkinfo)
  nmap <leader>gu <esc>:CocCommand git.chunkUndo<cr>
endif
"}}}
" Using CocList Show all diagnostics{{{
" Find symbol of current document
"}}}

" coc-lists{{{
if g:HasCocPlug("coc-lists")
  " session 保存目录
  call coc#config('session.directory', g:session_dir)
  if !g:HasPlug('dashboard-nvim')
    " 退出时自动保存session
    call coc#config('session.saveOnVimLeave', v:true)
  endif

  call coc#config('list.maxHeight', 10)
  call coc#config('list.maxPreviewHeight', 8)
  call coc#config('list.autoResize', v:false)
  call coc#config('list.source.grep.command', 'rg')
  call coc#config('list.source.grep.defaultArgs', [
        \ '--column',
        \ '--line-number',
        \ '--no-heading',
        \ '--color=always',
        \ '--smart-case'
        \ ])
  call coc#config('list.source.lines.defaultArgs', ['-e'])
  call coc#config('list.source.words.defaultArgs', ['-e'])
  call coc#config('list.source.files.command', 'rg')
  call coc#config('list.source.files.args', ['--files'])
  call coc#config('list.source.files.excludePatterns', ['.git'])
endif
"}}}
" coc-clangd{{{
if g:HasCocPlug('coc-clangd')
  " 配合插件vim-lsp-cxx-highlight实现高亮
  call coc#config('clangd.semanticHighlighting', v:true)
endif
"}}}
" coc-kite{{{
if g:HasCocPlug('coc-kite')
  call coc#config('kite.pollingInterval', 1000)
endif
"}}}
" coc-xml{{{
if g:HasCocPlug('coc-xml')
  call coc#config('xml.java.home', '/usr/lib/jvm/default/')
endif
"}}}
" coc-prettier{{{
if g:HasCocPlug('coc-prettier')
  call coc#config('prettier.tabWidth', 4)
endif
"}}}
" coc-git{{{
if g:HasCocPlug('coc-git')
  call coc#config('git.addGBlameToBufferVar', v:true)
  call coc#config('git.addGBlameToVirtualText', v:true)
  call coc#config('git.virtualTextPrefix', '  ➤  ')
  call coc#config('git.addedSign.hlGroup', 'GitGutterAdd')
  call coc#config('git.changedSign.hlGroup', 'GitGutterChange')
  call coc#config('git.removedSign.hlGroup', 'GitGutterDelete')
  call coc#config('git.topRemovedSign.hlGroup', 'GitGutterDelete')
  call coc#config('git.changeRemovedSign.hlGroup', 'GitGutterChangeDelete')
  call coc#config('git.addedSign.text', '▎')
  call coc#config('git.changedSign.text', '▎')
  call coc#config('git.removedSign.text', '▎')
  call coc#config('git.topRemovedSign.text', '▔')
  call coc#config('git.changeRemovedSign.text', '▋')
endif
"}}}
" coc-snippets{{{
if g:HasCocPlug('coc-snippets')
  call coc#config("snippets.ultisnips.enable", v:true)
  call coc#config("snippets.ultisnips.directories", [
        \ 'UltiSnips',
        \ 'gosnippets/UltiSnips'
        \ ])
  call coc#config("snippets.extends", {
        \ 'cpp': ['c'],
        \ 'typescript': ['javascript']
        \ })
endif
"}}}
" coc-highlight{{{
if g:HasCocPlug('coc-highlight')
  call coc#config("highlight.disableLanguages", ["csv"])
endif
"}}}
" coc-python{{{
if g:HasCocPlug('coc-python')
  call coc#config("python.jediEnabled", v:true)
  call coc#config("python.linting.enabled", v:true)
  call coc#config("python.linting.pylintEnabled", v:true)
endif
"}}}
" coc-rainbow-fart{{{
if g:HasCocPlug('coc-rainbow-fart')
  call coc#config("rainbow-fart.ffplay", "ffplay")
endif
"}}}
" coc-explorer{{{
if g:HasCocPlug('coc-explorer')
  let g:coc_explorer_global_presets = {
        \   '.vim': {
        \      'root-uri': '~/.vim',
        \   },
        \   'floating': {
        \      'position': 'floating',
        \      'floating-position': 'center',
        \      'floating-width': 100,
        \      'open-action-strategy': 'sourceWindow',
        \      'file-child-template': '[git | 2] [selection | clip | 1] [indent] [icon | 1] [diagnosticError & 1] [filename omitCenter 1][modified][readonly] [linkIcon & 1][link growRight 1] [timeCreated | 8] [size]'
        \   },
        \   'floatingTop': {
        \     'position': 'floating',
        \     'floating-position': 'center-top',
        \     'open-action-strategy': 'sourceWindow',
        \   },
        \   'floatingLeftside': {
        \      'position': 'floating',
        \      'floating-position': 'left-center',
        \      'floating-width': 100,
        \      'open-action-strategy': 'sourceWindow',
        \   },
        \   'floatingRightside': {
        \      'position': 'floating',
        \      'floating-position': 'right-center',
        \      'floating-width': 100,
        \      'open-action-strategy': 'sourceWindow',
        \   },
        \   'simplify': {
        \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
        \   }
        \ }

  " Use preset argument to open it
  " nmap <leader>rd :CocCommand explorer --preset .vim<CR>
  nmap ;a :CocCommand explorer<CR>
  if !g:HasPlug('ranger.vim')
    nmap <leader>f :CocCommand explorer --preset floating<CR>
  endif

  " config
  call coc#config("explorer.icon.enableNerdfont", v:true)
  call coc#config("explorer.bookmark.child.template", "[selection | 1] [filename] [position] - [annotation]")
  " call coc#config("explorer.file.autoReveal", v:true)
  " call coc#config("explorer.keyMappingMode", "none")
  " "\ 'a': v:false,
  call coc#config("explorer.keyMappings", {
        \ 'k': 'nodePrev',
        \ 'j': 'nodeNext',
        \ 'h': 'collapse',
        \ 'l': ['expandable?', 'expand', 'open'],
        \ 'L': 'expand:recursive',
        \ 'H': 'collapse:recursive',
        \ 'K': 'expandablePrev',
        \ 'J': 'expandableNext',
        \ '<bs>': 'gotoParent',
        \ '<cr>': ['expandable?', 'cd', 'open'],
        \ 'r': 'refresh',
        \ 't': ['toggleSelection', 'normal:j'],
        \ 'T': ['toggleSelection', 'normal:k'],
        \ '*': 'toggleSelection',
        \ 'os': 'open:split',
        \ 'ov': 'open:vsplit',
        \ 'ot': 'open:tab',
        \ 'dd': 'cutFile',
        \ 'Y': 'copyFile',
        \ 'D': 'delete',
        \ 'P': 'pasteFile',
        \ 'R': 'rename',
        \ 'N': 'addFile',
        \ 'yp': 'copyFilepath',
        \ 'yn': 'copyFilename',
        \ 'gp': 'preview:labeling',
        \ 'x': 'systemExecute',
        \ 'f': 'search',
        \ 'F': 'searchRecursive',
        \ '<tab>': 'actionMenu',
        \ '?': 'help',
        \ 'q': 'quit',
        \ '<esc>': 'esc',
        \ 'gf': 'gotoSource:file',
        \ 'gb': 'gotoSource:buffer',
        \ '[[': 'sourcePrev',
        \ ']]': 'sourceNext',
        \ '[d': 'diagnosticPrev',
        \ ']d': 'diagnosticNext',
        \ '[c': 'gitPrev',
        \ ']c': 'gitNext',
        \ '<<': 'gitStage',
        \ '>>': 'gitUnstage'
        \ })
endif
"}}}
