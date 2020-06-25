{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true; # broadcom wifi driver.

  # Nixos-hardware channel:
  #   $ sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
  #   $ sudo nix-channel --update
  # More info: https://github.com/NixOS/nixos-hardware

  imports = [
    ./hardware-configuration.nix
    <nixos-hardware/apple/macbook-air/6>
    ./minimum.nix
    ./emacs.nix
    ./x.nix
    ./desktop.nix
  ];

  hardware.facetimehd.enable = true;

  boot.kernelModules = [
    "coretemp" "applesmc" "intel_pstate=disable" ];

  services.tlp = {
    enable = true;
    extraConfig = ''
      TLP_DEFAULT_MODE=BAT
      TLP_PERSISTENT_DEFAULT=1
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
      CPU_SCALING_GOVERNOR_ON_AC=ondemand
    '';
  };

  services.mbpfan = {
    enable = true;
    lowTemp = 56;
    highTemp = 66;
    maxTemp = 80;
    maxFanSpeed = 6500;
    minFanSpeed = 1200;
    pollingInterval = 7;
  };

  environment.systemPackages = with pkgs; [
    lm_sensors
  ];
}
