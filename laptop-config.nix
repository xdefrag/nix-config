{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true; # broadcom wifi driver.

  # Nixos-hardware channel:
  #   $ sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
  #   $ sudo nix-channel --update
  # More info: https://github.com/NixOS/nixos-hardware

  imports =
    [
      ./hardware-configuration.nix
      <nixos-hardware/apple/macbook-air/6>
      ./minimum.nix
      ./emacs.nix
      ./x.nix
      ./desktop.nix
      ./dotfiles.nix
    ];
}
