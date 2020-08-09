if exists('g:loaded_go')
  finish
endif
let g:loaded_go = 1

let s:cpo_save = &cpo
set cpo&vim

function! go#alternate()
	let file=expand('%')
	let f=".go"
	let r="_test.go"

	if match(file, "_test.go") != -1
		let f="_test.go"
		let r=".go"
	endif
	
	execute "edit " . substitute(file, f, r, "")
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
