let b:dispatch = 'goimports -w %'

compiler go

setlocal keywordprg=go\ doc
setlocal path=**/*.go
setlocal tags+=~/.tags/gostd
