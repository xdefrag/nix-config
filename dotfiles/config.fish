set PATH $PATH ~/bin
set EDITOR vim
set TERM xterm-256color

alias v=vim
alias ns="sudo nixos-rebuild switch"
alias hs="home-manager switch"
alias t=gotop
alias mutt="neomutt"
alias nm=notmuch
alias c=clear

cat ~/.cache/wal/sequences

function fish_greeting
end

if test (tty) = "/dev/tty1"
	exec sway
end
