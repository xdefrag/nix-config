{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.cleanTmpDir = true;

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
    htop
    vim
    busybox
    killall
    zsh
    curl
    wget
    ripgrep
    fd
    autojump
    openssl
    gnupg
    unzip
    p7zip
    unar
    ncdu
    git
    tree
    pass
  ];

  networking.firewall.enable = true;

  sound.enable = true;

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  services.dnsmasq.enable = true;
  services.dnsmasq.servers = ["8.8.8.8" "8.8.4.4"];

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.plugins = [
    "git"
    "extract"
    "rsync"
  ];
  programs.zsh.ohMyZsh.theme = "minimal";

  programs.gnupg.agent = { enable = true; enableSSHSupport = true; }; 

  users.defaultUserShell = pkgs.zsh;

  users.users.xdefrag = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker" "jackaudio" "audio" "video"];
    uid = 1000;
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  services.nixosManual.showManual = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "19.09";
}
