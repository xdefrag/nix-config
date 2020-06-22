{ config, lib, pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/apple/macbook-air/6>
      <musnix>
      ./hardware-configuration.nix
    ];

  musnix.enable = true;
  musnix.kernel.optimize = true;
  musnix.kernel.realtime = true;
  musnix.kernel.packages = pkgs.linuxPackages_latest_rt;
  musnix.kernel.latencytop = true;
  musnix.alsaSeq.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [ "acpi_osi=! acpi_osi=\"Windows 2009\""];
  boot.kernelModules = ["kvm-intel" "vboxdrv"];

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    libGL_driver
  ];

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  boot.cleanTmpDir = true;

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "perfomance";

  services.acpid.enable = true;
  hardware.acpilight.enable = true;

  hardware.bluetooth.enable = true;

  networking.hostName = "absu";
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "dnsmasq";
  networking.networkmanager.wifi.powersave = true;

  services.openvpn.servers = {
    devim = {
      config = '' config /root/.vpn/devim/client.ovpn '';
      autoStart = false;
    };
    expressvpn-europe = {
      config = '' config /root/.vpn/expressvpn-europe/my_expressvpn_netherlands_-_rotterdam_udp.ovpn '';
      autoStart = false;
    };
    expressvpn-usa = {
      config = '' config /root/.vpn/expressvpn-usa/expressvpn-usa.ovpn '';
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
    vim
    busybox
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
    plasma5.sddm-kcm
    rofi
    rofi-pass
    mpv
    texlive.combined.scheme-full
    go
    goimports
    godef
    gotests
    golangci-lint
    clojure
    clojure-lsp
    leiningen
    kubectl
    kustomize
    skaffold
    tdesktop
    tldr
    openvpn
    postman
    xbanish
    dropbox
    firefox
    chromium
    rtorrent
    dosbox
    dbeaver
    krita
    bitwig-studio
    qjackctl
    patchage
    minikube
    pywal
    docker-compose
    godot
    discord
    torbrowser
    plantuml
    imagemagick
    (python37.withPackages(ps: with ps; [ pip python-language-server flake8 pytest numpy jupyter tensorflow tensorflow-tensorboard Keras ]))
    renpy
  ];

  fonts.fonts = with pkgs; [
    corefonts
    symbola
    monoid
    iosevka
  ];

  networking.firewall.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  services.jack = {
    jackd.enable = true;
    alsa.enable = false;
    loopback = {
      enable = true;
      # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
      #dmixConfig = ''
      #  period_size 2048
      #'';
    };
  };

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

  services.emacs.enable = false;
  services.emacs.defaultEditor = false;
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
    company-quickhelp
    helm-company
    lsp-mode
    clojure-lsp
    projectile
    helm-projectile
    go-mode
    go-gen-test
    go-impl
    protobuf-mode
    slime
    slime-company
    slime-repl-ansi-color
    geiser
    racket-mode
    cider
    ob-http
    ob-async
    org
    evil-org
    org-bullets
    yaml-mode
    ewal
    which-key
    flycheck
    flycheck-status-emoji
    flycheck-inline
    flycheck-golangci-lint
    renpy
    eimp
  ]));

  services.xserver.enable = true;
  services.xserver.layout = "us,ru";
  services.xserver.xkbOptions = "eurosign:e,grp:ctrl_shift_toggle,ctrl:swapcaps";

  services.xserver.libinput.enable = true;
  services.xserver.libinput.disableWhileTyping = true;

  # services.xserver.videoDrivers = ["intel"];
  services.xserver.videoDrivers = ["mesa"];

  services.xserver.displayManager.sddm.enable = true;

  services.xserver.desktopManager.xterm.enable = false;

  services.xserver.desktopManager.plasma5.enable = true;

  users.extraGroups.vboxusers.members = [ "xdefrag" ];
  
  users.defaultUserShell = pkgs.zsh;
  users.users.xdefrag = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker" "jackaudio" "audio"];
    uid = 1000;
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  services.nixosManual.showManual = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "19.09";
}
