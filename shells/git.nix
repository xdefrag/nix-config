{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "git";

  buildInputs = with pkgs.gitAndTools; [
    git
    bfg-repo-cleaner
    git-absorb
    git-extras
    git-fame
    git-open
    git-secrets
  ];
}
