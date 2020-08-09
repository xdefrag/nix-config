augroup go
	autocmd!
	autocmd BufWrite *_test.go Dispatch! go test ./...
	autocmd BufWrite *.go Dispatch!
augroup END

augroup vim
	autocmd!
	autocmd BufWrite *.vim source %
augroup END
