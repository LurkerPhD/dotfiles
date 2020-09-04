
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" packadd! vimspector

nmap <silent> <leader>dl :call vimspector#Launch()<CR>
nmap <silent> <Leader>dd :call vimspector#ToggleBreakpoint()<CR>
nmap <silent> <Leader>dc :call vimspector#Continue()<CR>
nmap <silent> <Leader>dx :call vimspector#Reset()<CR>
nmap <silent> <Leader>di :call vimspector#StepInto()<CR>
nmap <silent> <Leader>du :call vimspector#StepOut()<CR>
nmap <silent> <Leader>do :call vimspector#StepOver()<CR>
command -nargs=? BreakWhen call vimspector#ToggleBreakpoint([ { 'condition': <q-args> } ])
command -nargs=? BreakAtFunction -complete=tag call vimspector#AddFunctionBreakpoint(<q-args>)

