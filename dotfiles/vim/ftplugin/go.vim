let b:dispatch = 'goimports -w %'

compiler go

setlocal keywordprg=go\ doc
setlocal path=**/*.go
setlocal tags+=~/.tags/gostd

nnoremap <leader>a :call go#alternate()<CR>

" general
inoremap ,p package 
inoremap ,m func main() {<CR><CR>}<Esc>kA<Tab>
inoremap ,ev if err := somefunc(); err != nil {<CR>return err<CR>}<Esc>kkfsciw
inoremap ,er if err != nil {<CR>return err<CR>}<CR><CR>
inoremap ,f func somename() error {<CR>return nil<CR>}<Esc>kkfsciw

" testing
inoremap ,tm func TestMain(t *testing.M) {<CR><CR>}<Esc>kA<Tab>
inoremap ,tt func TestSomething(t *testing.T) {<CR><CR>}<Esc>kA<Tab>
inoremap ,te if err != nil {<CR>t.Error("Something")<CR>}<Esc>kfSciw
inoremap ,tf if err != nil {<CR>t.Fatal("Something")<CR>}<Esc>kfSciw
