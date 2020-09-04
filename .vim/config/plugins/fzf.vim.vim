
if exists('g:loaded_config_fzf_vim_vim')
    finish
endif
let g:loaded_config_fzf_vim_vim = 1

" fzf文件夹
let g:fzf_dir = g:root_path . '/fzf'
" fzf history 文件
let g:fzf_history_dir = g:fzf_dir . "/fzf-history"

" 输入框在顶部
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"

if has('nvim')
    " coc-fzf也使用这个变量
    let g:fzf_layout = {
        \ 'window': {
            \ 'up': '~90%', 'width': 0.6, 'height': 0.8, 'yoffset':0.5,
            \ 'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp'
        \ }
    \ }
endif

" 配色与主题同色
" fg表示未选中行的前景色
" hl表示搜索到的文字的颜色
" fg+表示选中的行的前景色
" hl+表示选中的行的搜索文字颜色
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Directory'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'WarningMsg'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }
" 预览窗口配置
if has('nvim')
    let s:preview_window_config = 'up:40%:wrap'
else
    let s:preview_window_config = 'right:50%:wrap'
endif
" 总是开启预览
let g:fzf_preview_window = s:preview_window_config
let s:preview_window = '--preview-window=' . s:preview_window_config
" 自定义窗口预览程序
let s:preview_program = g:config_root_path . "/scripts/preview.sh"

let g:fzf_buffers_jump = 1
" [Commands] --expect expression for directly executing the command
" let g:fzf_commands_expect = 'alt-enter,ctrl-x'

au FileType fzf tnoremap <buffer> <C-j> <Down>
au FileType fzf tnoremap <buffer> <C-k> <Up>
au FileType fzf tnoremap <buffer> <Esc> <c-g>

" ref https://github.com/junegunn/fzf.vim/issues/379
" 使用系统应用打开文件
function! s:SystemExecute(lines)
    for line in a:lines
        exec 'silent !xdg-open ' . fnameescape(line) . ' > /dev/null'
    endfor
endfunction

function! s:DeleteBuffer(lines)
    for l:line in a:lines
        " exec 'bd ' . line
    endfor
endfunction

let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit',
    \ 'alt-o': function('s:SystemExecute'),
\ }

" 内容检索
function! s:RipgrepFzfWithWiki(query, fullscreen) abort
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s %s || true'

    " 这个是在安装了vimwiki插件后使用的功能，需要配置一下g:vimwiki_path路径
    if &ft ==? 'vimwiki' && match(expand('%:p'), expand(g:vimwiki_path)) > -1 | let wiki_path = g:vimwiki_path
    else | let wiki_path = "" | endif

    let initial_command = printf(command_fmt, shellescape(a:query), wiki_path)
    let reload_command = printf(command_fmt, '{q}', wiki_path)
    let spec = {'options': [
                \ '--phony',
                \ '--query', a:query,
                \ '--bind', 'change:reload:'.reload_command,
                \ '--preview', s:preview_program . ' {}',
                \ s:preview_window
                \ ]}

    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction
function! s:RipgrepFzfWithWikiVisual(fullscreen) abort range
    call s:RipgrepFzfWithWiki(s:get_visual_selection(), a:fullscreen)
endfunction
command! -nargs=* -bang GrepWithWiki call s:RipgrepFzfWithWiki(<q-args>, <bang>0)
" TODO 还需要优化，尽量合并成一个函数，通过参数来操作
command! -range=% -bang  GrepWithWikiVisual <line1>,<line2>call s:RipgrepFzfWithWikiVisual(<bang>0)

" 文件检索
function! s:FilesWithWiki(query, fullscreen)
    let spec = {'options': [
                \ '--info=inline',
                \ '--preview', s:preview_program . ' {}',
                \ s:preview_window
                \ ]}

    if empty(a:query) && &ft ==? 'vimwiki' && match(expand('%:p'), expand(g:vimwiki_path)) > -1
        call fzf#vim#files(g:vimwiki_path, spec, a:fullscreen)
    else
        call fzf#vim#files(a:query, spec, a:fullscreen)
    endif
endfunction
command! -bang -nargs=? -complete=dir FWW call s:FilesWithWiki(<q-args>, <bang>0)

" quickfix 与 locallist
" copied from fzf_quickfix
function! s:error_type(type, nr) abort
    if a:type ==? 'W' | let l:msg = ' warning'
    elseif a:type ==? 'I' | let l:msg = ' info'
    elseif a:type ==? 'E' || (a:type ==# "\0" && a:nr > 0) | let l:msg = ' error'
    elseif a:type ==# "\0" || a:type ==# "\1" | let l:msg = ''
    else | let l:msg = ' ' . a:type | endif

    if a:nr <= 0 | return l:msg | endif

    return printf('%s %3d', l:msg, a:nr)
endfunction

function! s:format_error(item) abort
    return (a:item.bufnr ? bufname(a:item.bufnr) : '')
            \ . ':' . (a:item.lnum  ? a:item.lnum : '')
            \ . ':' . (a:item.col ? ' col ' . a:item.col : '')
            \ . ' | ' . s:error_type(a:item.type, a:item.nr)
            \ . ' | ' . substitute(a:item.text, '\v^\s*', ' ', '')
endfunction

function! s:quickfix_syntax() abort
    if has('syntax') && exists('g:syntax_on')
        " syntax match fzfQfFileName '^[^|]*' nextgroup=fzfQfSeparator
        " syntax match fzfQfSeparator '|' nextgroup=fzfQfLineNr contained
        " syntax match fzfQfLineNr '[^|]*' contained contains=fzfQfError,fzfQfWarning
        syntax match fzfQfError 'error' contained
        syntax match fzfQfWarning 'warning' contained

        " highlight default link fzfQfFileName Directory
        " highlight default link fzfQfLineNr LineNr
        highlight default link fzfQfError Error
        highlight default link fzfQfWarning WarningMsg
    endif
endfunction

function! s:quickfix_handler(err) abort
    let l:err_list = split(a:err, '|')
    let l:fn_ln = split(l:err_list[0], ':')
    let l:file_name = l:fn_ln[0]
    let l:line = ""
    let l:col = 0
    if len(l:fn_ln) == 2
        let l:line = l:fn_ln[1]
    elseif len(l:fn_ln) == 3
        let l:line = l:fn_ln[1]
        let l:col  = l:fn_ln[2]
    endif

    if bufnr(l:file_name) != bufnr("%")
        execute 'buffer'.bufnr(l:file_name)
    endif

    if !empty(l:line) && str2nr(l:line) > -1
        call cursor(str2nr(l:line), str2nr(l:col))
    else | return | endif
    normal! zvzz
    return
endfunction

" TODO 编写高亮
function! s:FzfQuickfix(...) abort
    call fzf#run(fzf#wrap({
            \ 'source': map(a:1 ? getloclist(0) : getqflist(), 's:format_error(v:val)'),
            \ 'sink': function('s:quickfix_handler'),
            \ 'options': [
                \ (a:1 ? '--prompt=LocList' : '--prompt=QfList'),
                \ '--info=inline',
                \ '--preview', s:preview_program . ' {1}',
                \ s:preview_window
            \ ],
            \ }))
    " if !exists('g:fzf_quickfix_syntax_on') | call s:quickfix_syntax() | endif
endfunction
command! FzfQuickfix  call s:FzfQuickfix(0)
command! FzfLocationList  call s:FzfQuickfix(1)

" jumps
" TODO 增加颜色
" TODO 定位当前所在的位置而不是总是置顶
" 当前jump所在的位置
" let s:jump_current_line = 0
function! s:jump_list_format(val) abort
    let l:file_name = bufname('%')
    let l:file_name = empty(l:file_name) ? 'Unknown file name' : l:file_name
    let l:curpos = getcurpos()
    let l:l = matchlist(a:val, '\(>\?\)\s*\(\d*\)\s*\(\d*\)\s*\(\d*\) \?\(.*\)')
    let [l:mark, l:jump, l:line, l:col, l:content] = l:l[1:5]
    if empty(trim(l:mark)) | let l:mark = '-' | endif

    if filereadable(expand(l:content))
        let l:file_name = expand(l:content)
        let l:bn = bufnr(l:file_name)
        if l:bn > -1 && buflisted(l:bn) > 0
            let l:content = getbufline(l:bn, l:line)
            let l:content = empty(l:content) ? "" : l:content[0]
        else
            let l:content = system("sed -n " . l:line . "p " . l:file_name)
        endif
    elseif empty(trim(l:content))
        if empty(trim(l:line))
            let [l:line, l:col] = l:curpos[1:2]
        endif
        let l:content = getline(l:line, l:line)[0]
    endif
    return l:mark . " " . l:file_name . ":" . l:line . ":" . l:col . " " . l:content
endfunction

function! s:jump_list() abort
    let l:js = execute('jumps')
    return map(reverse(split(l:js, '\n')[1:]), 's:jump_list_format(v:val)')
endfunction

function! s:jump_handler(jp)
    let l:l = matchlist(a:jp, '\(.\)\s\(.*\):\(\d\+\):\(\d\+\)\(.*\)')
    let [l:file_name, l:line, l:col, l:content] = l:l[2:5]

    if empty(l:file_name) || empty(l:line) | return | endif
    " 判断文件是否已经存在buffer中
    let l:bn = bufnr(l:file_name)
    " 未打开
    if l:bn == -1 | if filereadable(l:file_name) | execute 'e ' . 'l:file_name' | endif
    else | execute 'buffer ' . l:bn | endif
    call cursor(str2nr(l:line), str2nr(l:col))
    normal! zvzz
endfunction

function! s:FzfJumps() abort
    call fzf#run(fzf#wrap({
            \ 'source': <sid>jump_list(),
            \ 'sink': function('s:jump_handler'),
            \ 'options': [
                \ '--prompt=Jumps',
                \ '--preview', s:preview_program . ' {2}',
                \ s:preview_window
            \ ],
            \ }))
endfunction
command! -bang -nargs=* FzfJumps call s:FzfJumps()

function! s:marks_list_format(val)
    let l:l = matchlist(a:val, '\s*\(.\)\s*\(\d\+\)\s*\(\d\+\)\(.*\)')
    let [l:mark, l:line, l:col, l:content] = l:l[1:4]

    let l:file_name = bufname('%')
    if filereadable(l:content)
        echom l:content
        let l:file_name = l:content
        let l:bn = bufnr(l:file_name)
        if l:bn > -1 && buflisted(l:bn) > 0
            let l:content = getbufline(l:bn, l:line)[0]
        else
            let l:content = system("sed -n " . l:line . "p " . l:file_name)
        endif
    endif
    return l:mark . ' ' . l:file_name . ':' . l:line . ':' . l:col . ' ' . l:content
endfunction

function! s:marks_list() abort
    let l:ms = execute('marks')
    " return split(l:ms, '\n')[1:]
    return map(split(l:ms, '\n')[1:], 's:marks_list_format(v:val)')
endfunction

function! s:marks_handler(mr) abort
    let l:l = matchlist(a:mr, '\(.\)\s*\(.*\):\(\d\+\):\(\d\+\)\s*\(.*\)')
    let [l:mark, l:file_name, l:line, l:col, l:content] = l:l[1:5]

    let l:bn = bufnr(l:file_name)
    if l:bn == -1
        if filereadable(l:file_name) | execute 'e ' . l:file_name | endif
    else | execute 'buffer' . l:bn | endif
    call cursor(str2nr(l:line), str2nr(l:col))
    normal! zvzz
endfunction

function! s:FzfMarks() abort
    call fzf#run(fzf#wrap({
            \ 'source': <sid>marks_list(),
            \ 'sink': function('s:marks_handler'),
            \ 'options': [
                \ '--prompt=Marks',
                \ '--preview', s:preview_program .  ' {2}',
                \ s:preview_window
            \ ],
            \ }))
endfunction
command! -bang -nargs=* FzfMarks call s:FzfMarks()

function! s:blines_handler(lines) abort
    if len(a:lines) < 2
        return
    endif
    execute split(a:lines, '\t')[0]
    normal! zvzz
endfunction
function! s:blines_list() abort
    let fmtexpr = 'printf("%4d\t%s", v:key + 1, v:val)'
    let lines = getline(1, '$')
    return map(lines, fmtexpr)
endfunction
function! s:FzfBLines() abort
    let l:cur_buf_name = expand('%')
    if empty(l:cur_buf_name)
        let l:preview = 'echo please save first to preview'
    else
        let l:preview = s:preview_program . ' ' . l:cur_buf_name . ':{1}'
    endif
    call fzf#run(fzf#wrap({
            \ 'source': <sid>blines_list(),
            \ 'sink': function('s:blines_handler'),
            \ 'options': [
                \ '--prompt=BLines>',
                \ '--preview', l:preview,
                \ s:preview_window
            \ ],
            \ }))
endfunction
command! -bang -nargs=* FzfBLines call s:FzfBLines()

" git相关
" command! -bang -nargs=* GzgGitGrep
"\ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>),
"    \ 0,
"    \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0],
command! -bang -nargs=? -complete=dir FzfGitFiles
\ call fzf#vim#grep('git ls-files --exclude-standard',
    \ 1,
    \ {'dir': systemlist('git rev-parse --show-toplevel')[0],
    \ 'options': [
        \ '--info=inline',
        \ '--preview', s:preview_program . ' {}',
        \ s:preview_window
    \ ],
    \ 'sink': 'e'}, <bang>0)

let s:FzfGitStatusPreviewCommand =
    \ '[[ $(git diff -- {-1}) != "" ]] && git diff --color=always -- {-1} || ' .
    \ '[[ $(git diff --cached -- {-1}) != "" ]] && git diff --cached --color=always -- {-1} || '
command! -bang -nargs=? -complete=dir FzfGitStatus
\ call fzf#vim#grep('git -c color.status=always status --short --untracked-files=all',
    \ 1,
    \ {'options': [
        \ '--info=inline',
        \ '--preview', s:FzfGitStatusPreviewCommand . ' {}',
        \ s:preview_window
    \ ],
    \ 'sink': 'e'}, <bang>0)

" 自定义快捷键
nnoremap <silent> <leader>o  :<C-u>FWW<CR>
nnoremap <silent> <leader>of  :<C-u>FWW $HOME<CR>
nnoremap <silent> <leader>oh  :<C-u>History<CR>
nnoremap <silent> <leader>ob  :<C-u>Buffers<CR>

nnoremap <silent> <leader>os  :GrepWithWiki<CR>
nnoremap <silent> <leader>os  :GrepWithWikiVisual<CR>

nnoremap <silent> <leader>oj  s:FzfJumps<CR>
nnoremap <silent> <leader>oq  s:FzfQuickfix<CR>
nnoremap <silent> <leader>om  s:FzfMarks<CR>

if g:HasPlug('vista.vim')
    if has('nvim')
        let g:vista_fzf_preview = ['up:40%']
    else
        let g:vista_fzf_preview = ['right:40%']
    endif
    noremap <M-t> :Vista finder<CR>
else
    nnoremap <M-t> :BTags<CR>
    nnoremap <M-T> :Tags<CR>
endif
" 模糊搜索当前buffer
nnoremap ? :FzfBLines<CR>
"TODO *检索当前单词
" nnoremap * :BLines expand('<cword>')<CR>
" TODO 增加changes 需要自定义
nnoremap <M-c> :Commands<CR>
" 如果coc-fzf支持marks的话就用coc-fzf+coc-bookmarks
nnoremap <M-M> :Maps<CR>
nnoremap <M-w> :Windows<CR>
if g:HasPlug('coc-fzf')
    nnoremap <M-y> :<c-u>CocFzfList yank<CR>
endif
