{ pkgs, ... }:

{
  # Nixos Home Manager channel:
  # $ nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
  # $ nix-channel --update
  # More info: https://github.com/rycee/home-manager
  
  environment.systemPackages = with pkgs; [
    home-manager
  ];
}
