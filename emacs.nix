{ pkgs, ... }:

{
  services.emacs.enable = true;
  services.emacs.defaultEditor = true;
  services.emacs.install = true;
  services.emacs.package = with pkgs; (emacsWithPackages (with emacsPackagesNg; [
    base16-theme
    benchmark-init
    cider
    clojure-lsp
    company
    company-ghci
    diff-hl
    dired-hide-dotfiles
    evil
    evil-collection
    evil-commentary
    evil-magit
    evil-org
    evil-surround
    ewal
    exec-path-from-shell
    flycheck
    flycheck-golangci-lint
    flycheck-inline
    flycheck-status-emoji
    geiser
    general
    go-gen-test
    go-impl
    go-mode
    helm
    helm-company
    helm-projectile
    helm-rg
    lsp-mode
    lsp-python-ms
    magit
    magit-todos
    minions
    multi-term
    ob-async
    ob-http
    org
    org-bullets
    origami
    paredit
    parinfer
    projectile
    protobuf-mode
    racket-mode
    rainbow-delimiters
    slime
    slime-company
    slime-repl-ansi-color
    use-package
    use-package-chords
    which-key
    yaml-mode
    yasnippet
    yasnippet-snippets
  ]));
}
