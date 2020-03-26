{ config, lib, pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/apple/macbook-air/6>
      ./hardware-configuration.nix
      ./x.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.cleanTmpDir = true;

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";

  services.acpid.enable = true;

  hardware.acpilight.enable = true;

  networking.hostName = "absu";
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "dnsmasq";
  networking.networkmanager.wifi.powersave = true;

  services.openvpn.servers = {
    devim = {
      config = '' config /root/.vpn/devim/client.ovpn '';
      autoStart = false;
    };
    expressvpn = {
      config = '' config /root/.vpn/expressvpn/my_expressvpn_netherlands_-_rotterdam_udp.ovpn '';
      autoStart = false;
    };
  };

  environment.variables = {};

  virtualisation.docker.enable = true;
  virtualisation.docker.autoPrune.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  console.font = "Lat2-Terminus16";
  console.useXkbConfig = true;

  time.timeZone = "Europe/Moscow";
  
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    killall
    zsh
    curl
    wget
    pass
    ripgrep
    fd
    jq
    nnn
    autojump
    ngrok
    openssl
    gnupg
    unzip
    p7zip
    unar
    ncdu
    git
    spotify
    tree
    feh
    alacritty
    dmenu
    mpv
    xmobar
    stalonetray
    kbdlight
    libnotify
    dunst
    go
    goimports
    godef
    golangci-lint
    kubectl
    skaffold
    tdesktop
    tldr
    openvpn
    postman
    influxdb
    xbanish
    dropbox
    pywal
    firefox
  ];

  fonts.fonts = with pkgs; [
    corefonts
  ];

  networking.firewall.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.dnsmasq.enable = true;
  services.dnsmasq.servers = ["8.8.8.8" "8.8.4.4"];

  xdg.portal.enable = true;
  services.flatpak.enable = true;

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.plugins = [
    "git"
    "extract"
    "pass"
    "rsync"
    "docker"
    "go"
    "kubectl"
    "autojump"
  ];
  programs.zsh.ohMyZsh.theme = "minimal";

  programs.gnupg.agent = { enable = true; enableSSHSupport = true; }; 

  services.emacs.enable = true;
  services.emacs.defaultEditor = true;
  services.emacs.install = true;
  services.emacs.package = with pkgs; (emacsWithPackages (with emacsPackagesNg; [
    base16-theme
    use-package
    use-package-chords
    general
    benchmark-init
    minions
    exec-path-from-shell
    evil
    evil-collection
    evil-surround
    evil-commentary
    dired-hide-dotfiles
    helm
    helm-rg
    yasnippet
    yasnippet-snippets
    multi-term
    golden-ratio
    diff-hl
    magit
    evil-magit
    magit-todos
    paredit
    parinfer
    rainbow-delimiters
    origami
    company
    company-lsp
    lsp-mode
    projectile
    helm-projectile
    go-mode
    go-gen-test
    go-impl
    protobuf-mode
    slime
    geiser
    racket-mode
    cider
    ob-http
    ob-async
    org
    evil-org
    org-bullets
    kubernetes
    kubernetes-evil
    yaml-mode
    nix-mode
    company-nixos-options
  ]));

  services.xserver.enable = true;
  services.xserver.layout = "us,ru";
  services.xserver.xkbOptions = "eurosign:e,grp:ctrl_shift_toggle,ctrl:swapcaps";

  services.xserver.libinput.enable = true;
  services.xserver.libinput.disableWhileTyping = true;

  services.compton = {
    enable = true;
    fade = true;
    #inactiveOpacity = "0.9";
    #shadow = true;
    fadeDelta = 4;
  };

  services.xserver.displayManager.sddm.enable = true;

  services.xserver.desktopManager.xterm.enable = false;
  # services.xserver.desktopManager.plasma5.enable = true; 
  
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.xmonad.config =
    ''
     import XMonad
     import XMonad.Actions.SpawnOn
     import XMonad.Config.Desktop
     import XMonad.Hooks.DynamicLog
     import qualified XMonad.StackSet as W -- to shift and float windows

     baseConfig = desktopConfig

     main = xmonad =<< xmobar baseConfig
            { terminal    = "alacritty"
            , modMask     = mod4Mask
	    , manageHook  = manageHook baseConfig <+> myManageHook
            }

     myManageHook = composeAll . concat $
         [ [ className   =? c --> doFloat           | c <- myFloats]
         , [ title       =? t --> doFloat           | t <- myOtherFloats]
	 , [ className   =? c --> doF (W.shift "2") | c <- webApps]
	 , [ className   =? c --> doF (W.shift "3") | c <- ircApps]
	 ]
       where myFloats      = ["MPlayer", "Gimp"]
             myOtherFloats = ["alsamixer"]
             webApps       = ["Firefox-bin", "Opera"] -- open on desktop 2
             ircApps       = ["Ksirc"]                -- open on desktop 3
    '';

  users.defaultUserShell = pkgs.zsh;
  users.users.xdefrag = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker"];
    uid = 1000;
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "19.09";
}
