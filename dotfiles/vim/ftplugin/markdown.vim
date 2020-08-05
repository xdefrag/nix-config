let b:dispatch = 'mdview %'

setlocal keywordprg=ddg
setlocal path=**/*.md

setlocal foldmethod=indent

" Checkboxes
inoremap ,[  [ ] 
nnoremap x ^f[lrx^
nnoremap <C-x> ^fxr ^
