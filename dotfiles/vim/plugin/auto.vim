augroup go
	autocmd!
	autocmd BufWrite *.go Dispatch goimports -w %
augroup END

augroup vim
	autocmd!
	autocmd BufWrite *.vim source %
augroup END
