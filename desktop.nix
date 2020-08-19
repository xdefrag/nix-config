{ pkgs, ... }:

with builtins;

let
  dwm-fixborders = fetchurl {
    url = "https://dwm.suckless.org/patches/alpha/dwm-fixborders-6.2.diff";
    sha256 = "1bf7vykwpids0fhr483ibpd1r9b48wgsazk33153z2nbf76xqhq3";
  };
  dwm-alpha = fetchurl {
    url =
      "https://dwm.suckless.org/patches/alpha/dwm-alpha-20180613-b69c870.diff";
    sha256 = "1mgr84jm5c7d09v01i5d6p13wwlr71jvy7g7fbxyp8hx152vr2sn";
  };
  dwm-fullgaps = fetchurl {
    url = "https://dwm.suckless.org/patches/fullgaps/dwm-fullgaps-6.2.diff";
    sha256 = "0b8bkvmp70r677q7lzs879gbs50jvh99fqzz64yfrf139d7i0n9w";
  };
  dwm-warp = fetchurl {
    url = "https://dwm.suckless.org/patches/warp/dwm-warp-6.2.diff";
    sha256 = "0w2v0x8j9h0c4zxigcl65j9sgjc19jxszxz8q81x2x7r5y4bn5mx";
  };
  dwm-notitle = fetchurl {
    url = "https://dwm.suckless.org/patches/notitle/dwm-notitle-6.2.diff";
    sha256 = "0lr7l98jc88lwik3hw22jq7pninmdla360c3c7zsr3s2hiy39q9f";
  };
  st-anysize = fetchurl {
    url = "https://st.suckless.org/patches/anysize/st-anysize-0.8.1.diff";
    sha256 = "03z5vvajfbkpxvvk394799l94nbd8xk57ijq17hpmq1g1p2xn641";
  };
  st-alpha = fetchurl {
    url = "https://st.suckless.org/patches/alpha/st-alpha-0.8.2.diff";
    sha256 = "11dj1z4llqbbki5cz1k1crr7ypnfqsfp7hsyr9wdx06y4d7lnnww";
  };
  st-xresources = fetchurl {
    url =
      "https://st.suckless.org/patches/xresources/st-xresources-20200604-9ba7ecf.diff";
    sha256 = "0nsda5q8mkigc647p1m8f5jwqn3qi8194gjhys2icxji5c6v9sav";
  };
in {
  location = {
    latitude = 59.0;
    longitude = 30.0;
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      gohufont
      siji
      corefonts
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
      monospace = [ "DejaVu Sans Mono" ];
      sansSerif = [ "DejaVu Sans" ];
      serif = [ "DejaVu Serif" ];
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    dwm = pkgs.dwm.override {
      patches = [
        # dwm-fixborders
        dwm-alpha
        dwm-fullgaps
        dwm-warp
        ./dotfiles/dwm/dwm-config.diff
      ];
    };
    st = pkgs.st.override {
      patches =
        [ st-anysize st-alpha st-xresources ./dotfiles/st/st-config.diff ];
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
      spotify
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
      acpi
      blueman
      dmenu
      killall
      libnotify
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

  services = {
    xserver = {
      enable = true;
      layout = "us,ru";
      xkbOptions = "grp:ctrl_shift_toggle,ctrl:swapcaps";
      libinput.enable = true;
      wacom.enable = true;
      windowManager.dwm.enable = true;
      displayManager.startx.enable = true;
    };
    picom = {
      enable = true;
      fade = true;
      inactiveOpacity = 0.9;
      shadow = false;
      fadeDelta = 4;
    };
    redshift = {
      enable = true;
      temperature = {
        day = 4700;
        night = 1800;
      };
    };
  };
}
