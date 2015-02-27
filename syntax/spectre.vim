" syntax/spectre.vim

if exists("b:current_syntax")
    finish
endif

" Comments
syntax match spectreComment "\v//.*$"

highlight link spectreComment Comment

" Match TODO comments
syntax keyword spectreTodos TODO XXX FIXME NOTE

highlight default link spectreTodos Todo

" Match language specific keywords
syntax keyword spectreKeywords altergroup ahdl_include
syntax keyword spectreKeywords correlate export 
syntax keyword spectreKeywords ic inline local march 
syntax keyword spectreKeywords nodeset paramset plot print return
syntax keyword spectreKeywords save sens statistics simulator 
syntax keyword spectreKeywords to truncate vary

highlight default link spectreKeywords Keyword

syntax match  spectreConditional "\vif|then|else|for"

highlight default link spectreStructure Conditional


" Structural stuff
" ================

syntax match spectreStructure "\vparameters|function|include"

highlight default link spectreStructure Structure

" Model
" ----
syntax region spectreModel start="\v^[ \t]*model" end="\v\n" contains=spectreModelKeyword, spectreModelName, spectreModelType
syntax keyword spectreModelKeyword model    contained containedin=spectreModel
syntax match  spectreModelName "\v[^ \t]+"       contained containedin=spectreModel
syntax match  spectreModelType "\v[^ \t]+"       contained containedin=spectreModel

highlight link spectreModelKeyword Keyword
highlight link spectreModelName Identifier
highlight link spectreModelType Identifier

" Subckt
" -----
syntax region spectreSubcktFirst matchgroup=spectreSubcktKeyword start="\v^subckt" end="\v$" contains=spectreSubcktName, spectreSubcktConns
syntax match  spectreSubcktName "\v[^ \t]+"     contained containedin=spectreSubcktFirst
syntax match  spectreSubcktConns "\v\(.+\)"     contained containedin=spectreSubcktFirst

highlight link spectreSubcktKeyword Keyword
highlight link spectreSubcktName Identifier
highlight link spectreSubcktConns PreProc

syntax region spectreSubcktEnd matchgroup=spectreSubcktEndWord start="\v^ends" end="\v$" contains=spectreSubcktEndName
syntax match  spectreSubcktEndName "\v.+"   contained containedin=spectreSubcktEnd

highlight link spectreSubcktEndWord Keyword
highlight link spectreSubcktEndName Identifier

" Library/Section
" ---------------
syntax region spectreLibSectFirst matchgroup=spectreLibSectKeyword start="\v^[ \t]*(section|library)" end="\v$" contains=spectreLibSectName
syntax match spectreLibSectName "\v.+"    contained containedin=spectreLibSectFirst

highlight link spectreLibSectKeyword Keyword
highlight link spectreLibSectName Identifier

syntax match spectreLibEndWord "\v^[ \t]*end(section|library)"
highlight link spectreLibEndWord Keyword 

" Expressions
" ----------- 

syntax region spectreExpression matchgroup=spectreExpFirst start=/\v^\+/ end=/\v$/ contains=spectreOperator, spectreMathFuncs, spectreVarName, spectreNumber, spectreConstants
highlight link spectreExpFirst Structure

syntax match spectreVarName "\v\w+"     contained containedin=spectreExpression
highlight link spectreVarName Identifier

" Match all number types
syntax match spectreNumber "\v<\d+>"     contained containedin=spectreExpression
syntax match spectreNumber "\v<\d+\.\d+>"     contained containedin=spectreExpression
syntax match spectreNumber "\v<\d*\.?\d+([Ee]-?)?\d+>"     contained containedin=spectreExpression
syntax match spectreNumber "\v<0x\x+([Pp]-?)?\x+>"     contained containedin=spectreExpression
syntax match spectreNumber "\v<0b[01]+>"     contained containedin=spectreExpression
syntax match spectreNumber "\v<0o\o+>"     contained containedin=spectreExpression

highlight default link spectreNumber Number

" Operators
syntax match spectreOperator "\v\="     contained containedin=spectreExpression
syntax match spectreOperator "\v\*"     contained containedin=spectreExpression
syntax match spectreOperator "\v/"     contained containedin=spectreExpression
syntax match spectreOperator "\v\+"     contained containedin=spectreExpression
syntax match spectreOperator "\v-"     contained containedin=spectreExpression
syntax match spectreOperator "\v\?"     contained containedin=spectreExpression
syntax match spectreOperator "\v\*\="     contained containedin=spectreExpression
syntax match spectreOperator "\v/\="     contained containedin=spectreExpression
syntax match spectreOperator "\v\+\="     contained containedin=spectreExpression
syntax match spectreOperator "\v-\="     contained containedin=spectreExpression
syntax match spectreOperator "\v\*\*"     contained containedin=spectreExpression

highlight link spectreOperator Function

syntax keyword spectreMathFuncs abs acos acosh asin asinh atan atan2 atanh     contained containedin=spectreExpression
syntax keyword spectreMathFuncs ceil cos cosh exp floor fmod     contained containedin=spectreExpression
syntax keyword spectreMathFuncs hypot int log log10 march max min     contained containedin=spectreExpression
syntax keyword spectreMathFuncs pow pwr real                        contained containedin=spectreExpression
syntax keyword spectreMathFuncs sin sinh sqrt      contained containedin=spectreExpression
syntax keyword spectreMathFuncs tan tanh      contained containedin=spectreExpression

highlight link spectreMathFuncs Function

syntax keyword spectreConstants M_1_PI M_2_PI M_2_SQRTPI M_DEGPERRAD M_E M_LN10 M_LN2 M_LOG10E M_LOG2E M_PI M_PI_2 M_PI_4 M_SQRT1_2 M_SQRT2 M_TWO_PI contained containedin=spectreExpression
syntax keyword spectreConstants P_C P_CELSIUS0 P_EPS0 P_H P_K P_Q P_U0 contained containedin=spectreExpression

highlight default link spectreConstants PreProc

" Strings
syntax region spectreString start=/\v"/ skip=/\v\\./ end=/\v"/
syntax region spectreString start=/\v'/ skip=/\v\\./ end=/\v'/
highlight link spectreString String


let b:current_syntax = "spectre"

