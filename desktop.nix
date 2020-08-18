{ pkgs, ... }:

{
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      hack-font
      cantarell-fonts
      corefonts
      font-awesome
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
    ];
  };

  fonts.fontconfig = {
    enable = true;
    dpi = 90;
    antialias = true;
    hinting = {
      enable = true;
      autohint = true;
    };
    subpixel = {
      lcdfilter = "default";
      rgba = "rgb";
    };
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "Dejavu Sans Mono" ];
      sansSerif = [ "Dejavu Sans" ];
      serif = [ "DejaVu Serif" ];
    };
  };

  environment.systemPackages = with pkgs;
    [
      home-manager

      # games
      nethack

      # music
      bitwig-studio

      # internet
      isync
      msmtp
      neomutt
      newsboat
      notmuch
      qutebrowser
      rtorrent
      tdesktop
      urlview
      w3m
      weechat

      # docs
      zathura

      # cli tools
      cv
      fzf
      gnupg
      imv
      mpv
      neofetch
      nnn
      pandoc
      pywal
      scrot
      youtube-dl

      # dev tools
      bash-completion
      cht-sh
      direnv
      fswatch
      go-pup
      hugo
      jq
      lorri
      mk
      nixfmt
      shellcheck
      universal-ctags

      # system
      blueman
      dmenu
      libnotify
      redshift
      slstatus
      st
      syncthing
      xdg_utils
    ] ++ (with gitAndTools; [ git-extras ]) ++ (with weechatScripts; [
      wee-slack
      weechat-matrix-bridge
      weechat-autosort
      weechat-otr
    ]);

  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:ctrl_shift_toggle,ctrl:swapcaps";
    libinput.enable = true;
    wacom.enable = true;
    windowManager.dwm.enable = true;
    displayManager.startx.enable = true;
  };
}
