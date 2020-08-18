{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true; # broadcom wifi driver.

  imports = [
    ./hardware-configuration.nix
    ./minimum.nix
    ./desktop.nix
    ./vpn.nix
    ./vim.nix
    ./state.nix
  ];

  nix.trustedUsers = [ "root" "xdefrag" ];

  hardware.facetimehd.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;

  boot.kernelModules = [ "coretemp" "applesmc" "intel_pstate=disable" ];

  services.tlp = {
    enable = true;
    settings = {
      "TLP_DEFAULT_MODE" = "BAT";
      "TLP_PERSISTENT_DEFAULT" = 1;
      "CPU_SCALING_GOVERNOR_ON_BAT" = "powersave";
      "CPU_SCALING_GOVERNOR_ON_AC" = "ondemand";
    };
  };

  services.mbpfan = {
    enable = true;
    lowTemp = 55;
    highTemp = 60;
    maxTemp = 80;
    maxFanSpeed = 6500;
    minFanSpeed = 1200;
    pollingInterval = 7;
  };

  services.logind = { lidSwitch = "hibernate"; };

  environment.systemPackages = with pkgs; [ lm_sensors linuxPackages.broadcom_sta ];
}
