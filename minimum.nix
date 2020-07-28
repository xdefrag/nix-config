{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.cleanTmpDir = true;

  boot.plymouth.enable = false;

  networking.hostName = "absu";

  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "dnsmasq";
  networking.networkmanager.wifi.powersave = true;

  i18n.defaultLocale = "en_US.UTF-8";

  console.font = "Lat2-Terminus16";
  console.useXkbConfig = true;

  time.timeZone = "Europe/Moscow";
  
  environment.systemPackages = with pkgs; [
    brightnessctl
    curl
    fd
    git
    gnupg
    gotop
    ncdu
    openssl
    p7zip
    parted
    pass
    ripgrep
    tree
    unar
    unzip
  ];

  networking.firewall.enable = true;

  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    systemWide = true;
  };

  hardware.bluetooth.enable = true;

  services.dnsmasq.enable = true;
  services.dnsmasq.servers = ["8.8.8.8" "8.8.4.4"];
  services.blueman.enable = true;

  services.udisks2.enable = true;
  services.devmon.enable = true;

  programs.gnupg.agent = { enable = true; enableSSHSupport = true; }; 

  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;

  services.mingetty.autologinUser = "xdefrag";

  users.users.xdefrag = {
    isNormalUser = true;
    extraGroups = ["wheel" "input" "networkmanager" "docker" "jackaudio" "audio" "video"];
    uid = 1000;
    shell = pkgs.fish;
  };

  security.sudo.wheelNeedsPassword = false;

  services.nixosManual.showManual = false;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "19.09";
}
