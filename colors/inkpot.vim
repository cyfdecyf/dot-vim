" 本配色方案由 gui2term.py 程序增加彩色终端支持。
" Vim color file
" Name:       inkpot.vim
" Maintainer: Ciaran McCreesh <ciaran.mccreesh@blueyonder.co.uk>
" This should work in the GUI, rxvt-unicode (88 colour mode) and xterm (256
" colour mode). It won't work in 8/16 colour terminals.
"
" To use a black background, :let g:inkpot_black_background = 1

set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let colors_name = "inkpot"

" map a urxvt cube number to an xterm-256 cube number
fun! <SID>M(a)
    return strpart("0135", a:a, 1) + 0
endfun

" map a urxvt colour to an xterm-256 colour
fun! <SID>X(a)
    if &t_Co == 88
        return a:a
    else
        if a:a == 8
            return 237
        elseif a:a < 16
            return a:a
        elseif a:a > 79
            return 232 + (3 * (a:a - 80))
        else
            let l:b = a:a - 16
            let l:x = l:b % 4
            let l:y = (l:b / 4) % 4
            let l:z = (l:b / 16)
            return 16 + <SID>M(l:x) + (6 * <SID>M(l:y)) + (36 * <SID>M(l:z))
        endif
    endif
endfun

if ! exists("g:inkpot_black_background")
    let g:inkpot_black_background = 0
endif

if has("gui_running")
    if ! g:inkpot_black_background
        hi Normal         gui=NONE   guifg=#cfbfad   guibg=#1e1e27 ctermfg=187 ctermbg=16 cterm=none
    else
        hi Normal         gui=NONE   guifg=#cfbfad   guibg=#000000 ctermfg=187 ctermbg=16 cterm=none
    endif

    hi IncSearch      gui=BOLD   guifg=#303030   guibg=#cd8b60 ctermfg=236 ctermbg=173 cterm=bold
    hi Search         gui=NONE   guifg=#303030   guibg=#cd8b60 ctermfg=236 ctermbg=173 cterm=none
    hi ErrorMsg       gui=BOLD   guifg=#ffffff   guibg=#ce4e4e ctermfg=231 ctermbg=167 cterm=bold
    hi WarningMsg     gui=BOLD   guifg=#ffffff   guibg=#ce8e4e ctermfg=231 ctermbg=173 cterm=bold
    hi ModeMsg        gui=BOLD   guifg=#7e7eae   guibg=NONE ctermfg=103 ctermbg=16 cterm=bold
    hi MoreMsg        gui=BOLD   guifg=#7e7eae   guibg=NONE ctermfg=103 ctermbg=16 cterm=bold
    hi Question       gui=BOLD   guifg=#ffcd00   guibg=NONE ctermfg=220 ctermbg=16 cterm=bold

    hi StatusLine     gui=BOLD   guifg=#b9b9b9   guibg=#3e3e5e ctermfg=250 ctermbg=60 cterm=bold
    hi User1          gui=BOLD   guifg=#00ff8b   guibg=#3e3e5e ctermfg=48 ctermbg=60 cterm=bold
    hi User2          gui=BOLD   guifg=#7070a0   guibg=#3e3e5e ctermfg=103 ctermbg=60 cterm=bold
    hi StatusLineNC   gui=NONE   guifg=#b9b9b9   guibg=#3e3e5e ctermfg=250 ctermbg=60 cterm=none
    hi VertSplit      gui=NONE   guifg=#b9b9b9   guibg=#3e3e5e ctermfg=250 ctermbg=60 cterm=none

    hi WildMenu       gui=BOLD   guifg=#eeeeee   guibg=#6e6eaf ctermfg=254 ctermbg=61 cterm=bold

    hi MBENormal                 guifg=#cfbfad   guibg=#2e2e3f ctermfg=187 ctermbg=60 cterm=none
    hi MBEChanged                guifg=#eeeeee   guibg=#2e2e3f ctermfg=254 ctermbg=60 cterm=none
    hi MBEVisibleNormal          guifg=#cfcfcd   guibg=#4e4e8f ctermfg=252 ctermbg=61 cterm=none
    hi MBEVisibleChanged         guifg=#eeeeee   guibg=#4e4e8f ctermfg=254 ctermbg=61 cterm=none

    hi DiffText       gui=NONE   guifg=#ffffcd   guibg=#4a2a4a ctermfg=230 ctermbg=96 cterm=none
    hi DiffChange     gui=NONE   guifg=#ffffcd   guibg=#306b8f ctermfg=230 ctermbg=67 cterm=none
    hi DiffDelete     gui=NONE   guifg=#ffffcd   guibg=#6d3030 ctermfg=230 ctermbg=131 cterm=none
    hi DiffAdd        gui=NONE   guifg=#ffffcd   guibg=#306d30 ctermfg=230 ctermbg=71 cterm=none

    hi Cursor         gui=NONE   guifg=#404040   guibg=#8b8bff ctermfg=238 ctermbg=105 cterm=none
    hi lCursor        gui=NONE   guifg=#404040   guibg=#8fff8b
    hi CursorIM       gui=NONE   guifg=#404040   guibg=#8b8bff ctermfg=238 ctermbg=105 cterm=none

    hi Folded         gui=NONE   guifg=#cfcfcd   guibg=#4b208f ctermfg=252 ctermbg=54 cterm=none
    hi FoldColumn     gui=NONE   guifg=#8b8bcd   guibg=#2e2e2e ctermfg=104 ctermbg=236 cterm=none

    hi Directory      gui=NONE   guifg=#00ff8b   guibg=NONE ctermfg=48 ctermbg=16 cterm=none
    hi LineNr         gui=NONE   guifg=#8b8bcd   guibg=#2e2e2e ctermfg=104 ctermbg=236 cterm=none
    hi NonText        gui=BOLD   guifg=#8b8bcd   guibg=NONE ctermfg=104 ctermbg=16 cterm=bold
    hi SpecialKey     gui=BOLD   guifg=#ab60ed   guibg=NONE ctermfg=135 ctermbg=16 cterm=bold
    hi Title          gui=BOLD   guifg=#af4f4b   guibg=NONE ctermfg=131 ctermbg=16 cterm=bold
    hi Visual         gui=NONE   guifg=#eeeeee   guibg=#4e4e8f ctermfg=254 ctermbg=61 cterm=none

    hi Comment        gui=NONE   guifg=#cd8b00   guibg=NONE ctermfg=172 ctermbg=16 cterm=none
    hi Constant       gui=NONE   guifg=#ffcd8b   guibg=NONE ctermfg=222 ctermbg=16 cterm=none
    hi String         gui=NONE   guifg=#ffcd8b   guibg=#404040 ctermfg=222 ctermbg=238 cterm=none
    hi Error          gui=NONE   guifg=#ffffff   guibg=#6e2e2e ctermfg=231 ctermbg=131 cterm=none
    hi Identifier     gui=NONE   guifg=#ff8bff   guibg=NONE ctermfg=213 ctermbg=16 cterm=none
    hi Ignore         gui=NONE ctermbg=16 cterm=none
    hi Number         gui=NONE   guifg=#f0ad6d   guibg=NONE ctermfg=216 ctermbg=16 cterm=none
    hi PreProc        gui=NONE   guifg=#409090   guibg=NONE ctermfg=73 ctermbg=16 cterm=none
    hi Special        gui=NONE   guifg=#c080d0   guibg=NONE ctermfg=176 ctermbg=16 cterm=none
    hi SpecialChar    gui=NONE   guifg=#c080d0   guibg=#404040 ctermfg=176 ctermbg=238 cterm=none
    hi Statement      gui=NONE   guifg=#808bed   guibg=NONE ctermfg=105 ctermbg=16 cterm=none
    hi Todo           gui=BOLD   guifg=#303030   guibg=#d0a060 ctermfg=236 ctermbg=179 cterm=bold
    hi Type           gui=NONE   guifg=#ff8bff   guibg=NONE ctermfg=213 ctermbg=16 cterm=none
    hi Underlined     gui=BOLD   guifg=#df9f2d   guibg=NONE ctermfg=172 ctermbg=16 cterm=bold
    hi TaglistTagName gui=BOLD   guifg=#808bed   guibg=NONE ctermfg=105 ctermbg=16 cterm=bold

    hi perlSpecialMatch   gui=NONE guifg=#c080d0   guibg=#404040
    hi perlSpecialString  gui=NONE guifg=#c080d0   guibg=#404040

    hi cSpecialCharacter  gui=NONE guifg=#c080d0   guibg=#404040
    hi cFormat            gui=NONE guifg=#c080d0   guibg=#404040

    hi doxygenBrief                 gui=NONE guifg=#fdab60   guibg=NONE
    hi doxygenParam                 gui=NONE guifg=#fdd090   guibg=NONE
    hi doxygenPrev                  gui=NONE guifg=#fdd090   guibg=NONE
    hi doxygenSmallSpecial          gui=NONE guifg=#fdd090   guibg=NONE
    hi doxygenSpecial               gui=NONE guifg=#fdd090   guibg=NONE
    hi doxygenComment               gui=NONE guifg=#ad7b20   guibg=NONE
    hi doxygenSpecial               gui=NONE guifg=#fdab60   guibg=NONE
    hi doxygenSpecialMultilineDesc  gui=NONE guifg=#ad600b   guibg=NONE
    hi doxygenSpecialOnelineDesc    gui=NONE guifg=#ad600b   guibg=NONE

    if v:version >= 700
        hi Pmenu          gui=NONE   guifg=#eeeeee   guibg=#4e4e8f ctermfg=254 ctermbg=61 cterm=none
        hi PmenuSel       gui=BOLD   guifg=#eeeeee   guibg=#2e2e3f ctermfg=254 ctermbg=60 cterm=bold
        hi PmenuSbar      gui=BOLD   guifg=#eeeeee   guibg=#6e6eaf ctermfg=254 ctermbg=61 cterm=bold
        hi PmenuThumb     gui=BOLD   guifg=#eeeeee   guibg=#6e6eaf ctermfg=254 ctermbg=61 cterm=bold

        hi SpellBad     gui=undercurl guisp=#cc6666 ctermbg=16 cterm=undercurl
        hi SpellRare    gui=undercurl guisp=#cc66cc ctermbg=16 cterm=undercurl
        hi SpellLocal   gui=undercurl guisp=#cccc66 ctermbg=16 cterm=undercurl
        hi SpellCap     gui=undercurl guisp=#66cccc ctermbg=16 cterm=undercurl

        hi MatchParen   gui=NONE      guifg=#404040   guibg=#8fff8b ctermfg=238 ctermbg=120 cterm=none
    endif
else
    if ! g:inkpot_black_background
        exec "hi Normal         cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(80)
    else
        exec "hi Normal         cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(16)
    endif

    exec "hi IncSearch      cterm=BOLD   ctermfg=" . <SID>X(80) . " ctermbg=" . <SID>X(73)
    exec "hi Search         cterm=NONE   ctermfg=" . <SID>X(80) . " ctermbg=" . <SID>X(73)
    exec "hi ErrorMsg       cterm=BOLD   ctermfg=" . <SID>X(16) . " ctermbg=" . <SID>X(48)
    exec "hi WarningMsg     cterm=BOLD   ctermfg=" . <SID>X(16) . " ctermbg=" . <SID>X(68)
    exec "hi ModeMsg        cterm=BOLD   ctermfg=" . <SID>X(38) . " ctermbg=" . "NONE"
    exec "hi MoreMsg        cterm=BOLD   ctermfg=" . <SID>X(38) . " ctermbg=" . "NONE"
    exec "hi Question       cterm=BOLD   ctermfg=" . <SID>X(52) . " ctermbg=" . "NONE"

    exec "hi StatusLine     cterm=BOLD   ctermfg=" . <SID>X(85) . " ctermbg=" . <SID>X(81)
    exec "hi User1          cterm=BOLD   ctermfg=" . <SID>X(28) . " ctermbg=" . <SID>X(81)
    exec "hi User2          cterm=BOLD   ctermfg=" . <SID>X(39) . " ctermbg=" . <SID>X(81)
    exec "hi StatusLineNC   cterm=NONE   ctermfg=" . <SID>X(84) . " ctermbg=" . <SID>X(81)
    exec "hi VertSplit      cterm=NONE   ctermfg=" . <SID>X(84) . " ctermbg=" . <SID>X(81)

    exec "hi WildMenu       cterm=BOLD   ctermfg=" . <SID>X(87) . " ctermbg=" . <SID>X(38)

    exec "hi MBENormal                   ctermfg=" . <SID>X(85) . " ctermbg=" . <SID>X(81)
    exec "hi MBEChanged                  ctermfg=" . <SID>X(87) . " ctermbg=" . <SID>X(81)
    exec "hi MBEVisibleNormal            ctermfg=" . <SID>X(85) . " ctermbg=" . <SID>X(82)
    exec "hi MBEVisibleChanged           ctermfg=" . <SID>X(87) . " ctermbg=" . <SID>X(82)

    exec "hi DiffText       cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(34)
    exec "hi DiffChange     cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(17)
    exec "hi DiffDelete     cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(32)
    exec "hi DiffAdd        cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(20)

    exec "hi Folded         cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(35)
    exec "hi FoldColumn     cterm=NONE   ctermfg=" . <SID>X(39) . " ctermbg=" . <SID>X(80)

    exec "hi Directory      cterm=NONE   ctermfg=" . <SID>X(28) . " ctermbg=" . "NONE"
    exec "hi LineNr         cterm=NONE   ctermfg=" . <SID>X(39) . " ctermbg=" . <SID>X(80)
    exec "hi NonText        cterm=BOLD   ctermfg=" . <SID>X(39) . " ctermbg=" . "NONE"
    exec "hi SpecialKey     cterm=BOLD   ctermfg=" . <SID>X(55) . " ctermbg=" . "NONE"
    exec "hi Title          cterm=BOLD   ctermfg=" . <SID>X(48) . " ctermbg=" . "NONE"
    exec "hi Visual         cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(38)

    exec "hi Comment        cterm=NONE   ctermfg=" . <SID>X(52) . " ctermbg=" . "NONE"
    exec "hi Constant       cterm=NONE   ctermfg=" . <SID>X(73) . " ctermbg=" . "NONE"
    exec "hi String         cterm=NONE   ctermfg=" . <SID>X(73) . " ctermbg=" . <SID>X(81)
    exec "hi Error          cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(32)
    exec "hi Identifier     cterm=NONE   ctermfg=" . <SID>X(53) . " ctermbg=" . "NONE"
    exec "hi Ignore         cterm=NONE"
    exec "hi Number         cterm=NONE   ctermfg=" . <SID>X(69) . " ctermbg=" . "NONE"
    exec "hi PreProc        cterm=NONE   ctermfg=" . <SID>X(25) . " ctermbg=" . "NONE"
    exec "hi Special        cterm=NONE   ctermfg=" . <SID>X(55) . " ctermbg=" . "NONE"
    exec "hi SpecialChar    cterm=NONE   ctermfg=" . <SID>X(55) . " ctermbg=" . <SID>X(81)
    exec "hi Statement      cterm=NONE   ctermfg=" . <SID>X(27) . " ctermbg=" . "NONE"
    exec "hi Todo           cterm=BOLD   ctermfg=" . <SID>X(16) . " ctermbg=" . <SID>X(57)
    exec "hi Type           cterm=NONE   ctermfg=" . <SID>X(71) . " ctermbg=" . "NONE"
    exec "hi Underlined     cterm=BOLD   ctermfg=" . <SID>X(77) . " ctermbg=" . "NONE"
    exec "hi TaglistTagName cterm=BOLD   ctermfg=" . <SID>X(39) . " ctermbg=" . "NONE"

    if v:version >= 700
        exec "hi Pmenu          cterm=NONE   ctermfg=" . <SID>X(87) . " ctermbg=" . <SID>X(82)
        exec "hi PmenuSel       cterm=BOLD   ctermfg=" . <SID>X(87) . " ctermbg=" . <SID>X(38)
        exec "hi PmenuSbar      cterm=BOLD   ctermfg=" . <SID>X(87) . " ctermbg=" . <SID>X(39)
        exec "hi PmenuThumb     cterm=BOLD   ctermfg=" . <SID>X(87) . " ctermbg=" . <SID>X(39)

        exec "hi SpellBad       cterm=NONE ctermbg=" . <SID>X(32)
        exec "hi SpellRare      cterm=NONE ctermbg=" . <SID>X(33)
        exec "hi SpellLocal     cterm=NONE ctermbg=" . <SID>X(36)
        exec "hi SpellCap       cterm=NONE ctermbg=" . <SID>X(21)
        exec "hi MatchParen     cterm=NONE ctermbg=" . <SID>X(14) . "ctermfg=" . <SID>X(25)
    endif
endif

" vim: set et :
