{ pkgs, ... }:

{
  services.emacs.enable = true;
  services.emacs.defaultEditor = true;
  services.emacs.install = true;
  services.emacs.package = with pkgs; (emacsWithPackages (with emacsPackagesNg; [
    base16-theme
    use-package
    use-package-chords
    general
    benchmark-init
    minions
    exec-path-from-shell
    evil
    evil-collection
    evil-surround
    evil-commentary
    dired-hide-dotfiles
    helm
    helm-rg
    yasnippet
    yasnippet-snippets
    multi-term
    diff-hl
    magit
    evil-magit
    magit-todos
    paredit
    parinfer
    rainbow-delimiters
    origami
    company
    helm-company
    lsp-mode
    clojure-lsp
    projectile
    helm-projectile
    go-mode
    go-gen-test
    go-impl
    protobuf-mode
    slime
    slime-company
    slime-repl-ansi-color
    geiser
    racket-mode
    cider
    ob-http
    ob-async
    org
    evil-org
    org-bullets
    yaml-mode
    ewal
    which-key
    flycheck
    flycheck-status-emoji
    flycheck-inline
    flycheck-golangci-lint
  ]));
}
