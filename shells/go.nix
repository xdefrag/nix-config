{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    gnumake
    go
    goimports
    golangci-lint
    gomodifytags
    gotags
    gotests
    impl
    reftools
  ];

  shellHook = ''
    export PATH=$PATH:~/go/bin
  '';
}
