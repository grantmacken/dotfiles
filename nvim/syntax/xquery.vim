" VIM Syntax file
" 
" Language:    XQuery
" Maintainer:  Jeroen Pulles <jeroen.pulles@redslider.net>
" Last Change: 19 August 2012
" 
if exists("b:current_syntax")
   finish
endif

let b:current_syntax = "xquery"

setlocal iskeyword+=.,-
" NOTE that there's also a ftplugin for additional customization for XQuery. 

syn match   xqyQName            /\k\+\(:\k\+\)\?/ contained contains=NONE transparent 
syn region  xqyBlock            start=/{/ end=/}/ contains=ALLBUT,@xqyPrologStatements

syn region  xqyString           start=/\z(['"]\)/ skip=/\\\z1/ end=/\z1/ keepend
syn region  xqyAttrString       start=/\z(['"]\)/ skip=/\\\z1/ end=/\z1/ contained contains=xqyBlock
syn region  xqyStartTag         start=#<\([= \/]\)\@!# end=#># contains=xqyAttrString
syn region  xqyEndTag           start=#</# end=#># contains=xqyQName

" syn region  jsonProp          start=/\z(['"]\)/ skip=/\\\z1/ end=/\z1[:]/ contained 
syn match   jsonProp            /["']\(\w\|[@_:-]\)*["']:/

syn keyword xqyPrologKeyword    xquery version module namespace import at external
syn keyword xqyDecl             declare nextgroup=xqyOption,xqyContext,xqyDeclFun,xqyDeclVar,xqyDeclCons skipwhite
syn keyword xqyDeclCons         construction nextgroup=xqyDeclConsOpt skipwhite
syn keyword xqyDeclConsOpt      strip preserve
syn keyword xqyDeclVar          variable nextgroup=xqyVariable external skipwhite
syn keyword xqyContext          context item skipwhite
syn keyword xqyOption           option skipwhite
syn keyword xqyDeclFun          function nextgroup=xqyFunction skipwhite
syn match   xqyNamespace        /\(\w\|[-_]\)*:/ 

syn match   xqyVariable         /\$\k\+/
syn match   xqyAnnotation       /%\k\+\(:\k\+\)\?/
syn match   xqyFunction         /\k\+\(:\k\+\)\?()/ " FIXME 
syn keyword xqyTypeSigKeyword   as xs nextgroup=xqyType skipwhite
syn match   xqyType             /\k+\(:\k\+\)\?/ contained
syn cluster xqyPrologStatements contains=xqyPrologKeyword,xqyDecl,xqyDeclVar,xyDeclFun,xqyDeclCons,xqyDeclConsOpt

syn keyword xqyFLWOR            for in let where group by order by at count return
syn keyword xqyUpdate           modify copy delete rename insert node nodes into last first before after
syn keyword xqyWindow           tumbling sliding window start when end only

syn keyword xqyConstructor      attribute
syn match   xqyConstructor      /\(element\|comment\|processing-instruction\)\ze\s/

syn keyword xqyConditional      if then else every some
syn keyword xqyConditional      or and 
syn keyword xqyConditional      typeswitch 
syn keyword xqyConditional      switch case default
syn keyword xqyConditional      try catch
syn keyword xqyConditional      text not in ftor ftand ftnot any all ordered distance most words same sentence without occurs
syn keyword xqyConditional      using case sensitive diacritics using stemming language stop wildcards score fuzzy thesaurus
syn match   xqyConditional      /contains/
syn keyword xqyMapArrayType     map array

syn match   xqyMap              /\s!\s\|=>/

syn keyword xqyTodo             TODO XXX FIXME contained
syn match   xqyDocKeyword       display /@\(version\|since\|deprecated\|error\|return\|param\|author\|see\)/ contained nextgroup=xqyVariable skipwhite
syn region  xqyDocComment       start="(:\~" end=":)" contains=xqyTodo,xqyDocKeyword,xqyVariable,xqyComment,xqyDocComment,@Spell fold
syn region  xqyComment          start="(\:\(\~\)\@!" end="\:)" contains=xqyTodo,xqyComment,xqyDocComment,@Spell fold

" ==============================
hi def link xqyString           String
hi def link xqyAttrString       String
hi def link xqyStartTag         Question
hi def link jsonProp            Question
hi def link xqyEndTag           Special
hi def link xqyNamespace        Special

hi def link xqyMapArray         Comment
hi def link xqyComment          Comment
hi def link xqyDocComment       Comment
hi def link xqyDocKeyword       SpecialComment
hi def link xqyTodo             Todo

hi def link xqyDecl             Define
hi def link xqyDeclCons         Define
hi def link xqyDeclConsOpt      Define
hi def link xqyDeclFun          Define
hi def link xqyDeclVar          Define
hi def link xqyContext          Define
hi def link xqyOption           Define
hi def link xqyPrologKeyword    PreProc
hi def link xqyTypeSigKeyword   PreProc
hi def link xqyVariableExt      PreProc
hi def link xqyMapArrayType     PreProc

hi def link xqyFLWOR            Keyword
hi def link xqyUpdate           Keyword
hi def link xqyWindow           Keyword
hi def link xqyConstructor      Keyword
hi def link xqyConditional      Conditional

hi def link xqyVariable         Identifier
hi def link xqyAnnotation       Identifier
hi def link xqyMap              Identifier
hi def link xqyType             Type
