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
			\ ])
" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("Toggl&e", [
			\ ['Toggle &wrapper', 'se wrap!'],
			\ ['Toggle &function list', 'Vista coc'],
			\ ['Toggle &git gutters', 'CocCommand git.toggleGutters' ],
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

