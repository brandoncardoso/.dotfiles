set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "jbterm""

if version >= 700
	hi CursorLine cterm=none ctermbg=234 gui=none guibg=#1c1c1c
	hi CursorColumn ctermbg=234 guibg=#1c1c1c
	hi MatchParen cterm=bold ctermfg=231 ctermbg=108 gui=bold guifg=#ffffff guibg=#87af87

	hi TabLine cterm=none ctermfg=252 ctermbg=235 guifg=#d0d0d0 guibg=#262626
	hi TabLineFill ctermfg=235 guibg=#262626
	hi TabLineSel cterm=bold ctermfg=235 gui=bold ctermbg=252 guifg=#262626 guibg=#d0d0d0

	hi Pmenu ctermfg=231 ctermbg=240 guifg=#ffffff guibg=#585858
	hi PmenuSel ctermfg=232 ctermbg=254 guifg=#080808 guibg=#e4e4e4
endif

hi Normal ctermfg=230 guifg=#ffdfdf guibg=#121212
hi Visual ctermbg=237 guibg=#3a3a3a
hi Cursor ctermbg=153 guibg=#afff5f

hi LineNr ctermfg=59 ctermbg=234 guifg=#5f5f5f guibg=#1c1c1c
hi Comment ctermfg=244 guifg=#808080
hi Todo cterm=bold ctermfg=228 gui=bold guifg=#ffff87

hi StatusLine ctermfg=252 ctermbg=235 guifg=#d0d0d0 guibg=#262626
hi StatusLineNC ctermfg=235 ctermbg=252 guifg=#262626 guibg=#d0d0d0
hi VertSplit ctermfg=235 ctermbg=235 guifg=#262626 guibg=#262626
hi WildMenu ctermfg=217 ctermbg=235 guifg=#ffafaf guibg=#262626

hi Folded ctermfg=145 ctermbg=236 guifg=#afaf5f guibg=#303030
hi FoldColumn ctermfg=59 ctermbg=234 guifg=#5f5f5f guibg=#1c1c1c
hi SignColumn ctermfg=242 ctermbg=236 guifg=#6c6c6c guibg=#303030
hi ColorColumn ctermbg=235 guibg=#262626

hi Title cterm=bold ctermfg=71 gui=bold guifg=#5faf5f

hi Constant ctermfg=167 guifg=#d75f5f
hi Special ctermfg=107 guifg=#87af5f
hi Delimiter ctermfg=66 guifg=#5f8787

hi String ctermfg=107 guifg=#87af5f
hi StringDelimiter ctermfg=58 guifg=#5f5f00

hi Identifier ctermfg=183 guifg=#dfafff
hi Structure ctermfg=110 guifg=#87afd7
hi Function ctermfg=222 guifg=#ffdf87
hi Statement ctermfg=103 guifg=#8787af
hi PreProc ctermfg=110 guifg=#87afd7

hi! link Operator Normal

hi Type ctermfg=215 guifg=#ffaf5f
hi NonText ctermfg=240 ctermbg=233 guifg=#585858 guibg=#121212

hi SpecialKey ctermfg=237 ctermbg=234 guifg=#3a3a3a guibg=#1c1c1c

hi Search cterm=underline ctermfg=217 ctermbg=235 gui=underline guifg=#ffafaf guibg=#262626

hi Directory ctermfg=186 guifg=#dfdf87
hi ErrorMsg ctermbg=88 guibg=#870000
hi! link Error ErrorMsg
hi! link MoreMsg Special
hi Question ctermfg=71 guifg=#5faf5f

" Spell Checking
hi SpellBad cterm=underline ctermbg=88  gui=underline guibg=#870000
hi SpellCap cterm=underline ctermbg=20  gui=underline guibg=#0000d7
hi SpellRare cterm=underline ctermbg=53  gui=underline guibg=#5f005f
hi SpellLocal cterm=underline ctermbg=23  gui=underline guibg=#005f5f

" Diff
hi! link diffRemoved Constant
hi! link diffAdded String

" VimDiff
hi DiffAdd ctermfg=193 ctermbg=22 guifg=#dfffaf guibg=#005f00
hi DiffDelete ctermfg=235 ctermbg=52 guifg=#262626 guibg=#5f0000
hi DiffChange ctermbg=24 guibg=#005f87
hi DiffText ctermfg=235 ctermbg=81 guifg=#262626 guibg=#5fd7ff

" PHP
hi! link phpFunctions Function
hi StorageClass ctermfg=179 guifg=#dfaf5f
hi! link phpSuperglobal Identifier
hi! link phpQuoteSingle StringDelimiter
hi! link phpQuoteDouble StringDelimiter
hi! link phpBoolean Constant
hi! link phpNull Constant
hi! link phpArrayPair Operator

" Python
hi! link pythonOperator Statement

" Ruby
hi! link rubySharpBang Comment
hi rubyClass ctermfg=30 guifg=#008787
hi rubyIdentifier ctermfg=183 guifg=#dfafff
hi! link rubyConstant Type
hi! link rubyFunction Function

hi rubyInstanceVariable ctermfg=183 guifg=#dfafff
hi rubySymbol ctermfg=104 guifg=#8787d7
hi! link rubyGlobalVariable rubyInstanceVariable
hi! link rubyModule rubyClass
hi rubyControl ctermfg=104 guifg=#8787d7

hi! link rubyString String
hi! link rubyStringDelimiter StringDelimiter
hi! link rubyInterpolationDelimiter Identifier

hi rubyRegexpDelimiter ctermfg=53 guifg=#5f005f
hi rubyRegexp ctermfg=162 guifg=#d70087
hi rubyRegexpSpecial ctermfg=126 guifg=#af0087

hi rubyPredefinedIdentifier ctermfg=168 guifg=#d75f87

" JavaScript
hi! link javaScriptValue Constant
hi! link javaScriptRegexpString rubyRegexp

" CoffeeScript
hi! link coffeeRegExp javaScriptRegexpString

" Lua
hi! link luaOperator Conditional

" C
hi! link cFormat Identifier
hi! link cOperator Constant

" Objective-C/Cocoa
hi! link objcClass Type
hi! link cocoaClass objcClass
hi! link objcSubclass objcClass
hi! link objcSuperclass objcClass
hi! link objcDirective rubyClass
hi! link objcStatement Constant
hi! link cocoaFunction Function
hi! link objcMethodName Identifier
hi! link objcMethodArg Normal
hi! link objcMessageName Identifier

" Debugger.vim
hi DbgCurrent ctermfg=195 ctermbg=25 guifg=#dfff87 guibg=#005fd7
hi DbgBreakPt ctermbg=53 guibg=#5f005f

" vim-indent-
hi IndentGuidesOdd ctermbg=235 guifg=#262626
hi IndentGuidesEven ctermbg=234 guifg=#1c1c1c

" Plugins, etc.

hi! link TagListFileName Directory
hi PreciseJumpTarget ctermfg=155 ctermbg=22 guifg=#afff5f guibg=#005f00
