" let g:AutoPairsMapBS =  1
" let g:AutoPairsShortcutBackInsert = "<M-b>"
" let g:AutoPairsLoaded =  1
" let g:AutoPairsShortcutToggle = "<M-p>"
" let g:AutoPairsMapCR =  1
" let g:AutoPairsMapCh =  1
" let g:AutoPairsSmartQuotes =  1
" let g:AutoPairsShortcutFastWrap = "<M-e>"
" let g:AutoPairsCenterLine =  1
" let g:AutoPairsMultilineClose =  1
" let g:AutoPairsShortcutJump = "<M-n>"
" let g:AutoPairsMapSpace =  1
" let g:AutoPairsFlyMode =  0
" let g:AutoPairsMoveCharacter = "()[]{}\"'"
" let g:AutoPairsWildClosedPair = ""

"Default: '<M-e>'
"Fast wrap the word. all pairs will be consider as a block (include <>).
"(|)'hello' after fast wrap at |, the word will be ('hello')
"(|)<hello> after fast wrap at |, the word will be (<hello>)

au FileType php  let b:AutoPairs = AutoPairsDefine({'<?' : '?>', '<?php': '?>'})
au FileType rust let b:AutoPairs = AutoPairsDefine({'\w\zs<': '>'})
" add <!-- --> pair and remove '{' for html file
" au FileType html let b:AutoPairs = AutoPairsDefine({'<!--' : '-->'}, ['{'])
au FileType md   let b:AutoPairs = AutoPairsDefine({'```:```'})
