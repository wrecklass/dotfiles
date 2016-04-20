" Vim color file
" Maintainer: Alexander Rodin <rodin.alexander@gmail.com>
"
" This theme is based on "desert256" theme by Henry So, Jr.
"
" I struggled with trying to parse the rgb.txt file to avoid the necessity of
" converting color names to #rrggbb form, but decided it was just not worth
" the effort.  Maybe someone seeing this may decide otherwise...

set background=light
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="desert256"

if has("gui_running") || &t_Co == 88 || &t_Co == 256

    call <SID>X("VertSplit", "c2bfa5", "7f7f7f", "reverse")
    call <SID>X("Folded", "9999cc", "f4f4f4", "")
    call <SID>X("IncSearch", "708090", "f0e68c", "")
    call <SID>X("Visual", "3888ff", "ffffff", "reverse")
    call <SID>X("Comment", "1C9518", "", "")
"    call <SID>X("Comment", "20AD1B", "", "")
    call <SID>X("Constant", "5500ff", "", "")
    call <SID>X("String", "ff7777", "", "")
    call <SID>X("Float", "ff7777", "", "")
    call <SID>X("Boolean", "000080", "", "bold")
    call <SID>X("Identifier", "98fb98", "", "none")
    call <SID>X("Statement", "000080", "", "bold")
    call <SID>X("PreProc", "20b5ff", "", "")
    call <SID>X("Type", "000080", "", "bold")
    call <SID>X("Special", "CDAB00", "", "")
    call <SID>X("Underlined", "0000cc", "", "")
    call <SID>X("Todo", "ff4500", "eeee00", "")

else
    " color terminal definitions
    hi VertSplit    ctermfg=lightgray ctermbg=gray cterm=reverse
    hi Folded       ctermfg=blue ctermbg=lightcyan
    hi IncSearch    ctermfg=lightgray ctermbg=yellow
    hi Visual       ctermfg=blue ctermbg=white cterm=reverse
    hi Comment      ctermfg=green
    hi Constant     ctermfg=blue
    hi String       ctermfg=red
    hi Float        ctermfg=red
    hi Boolean      ctermfg=darkblue cterm=bold
    hi Statement    ctermfg=darkblue cterm=bold
    hi PreProc      ctermfg=cyan
    hi Type         ctermfg=darkblue cterm=bold
    hi Special      ctermfg=brown
    hi Underlined   ctermfg=blue
    hi Todo         ctermfg=red ctermbg=yellow
endif

" vim: set fdl=0 fdm=marker:
