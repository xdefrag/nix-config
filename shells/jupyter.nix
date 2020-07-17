{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "jupyter";

  buildInputs = with pkgs.python37Packages; [
    Keras
    jupyter
    numpy
    tensorflow
    tensorflow-tensorboard
  ];

  shellHook = ''
    jupyter notebook
  '';
}
