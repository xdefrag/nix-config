{ pkgs, ... }:

{
  home.sessionVariables = {};

  home.keyboard = {
    layout = "us,ru";
    options = [
      "grp:ctrl_shift_toggle"
      "ctrl:swapcaps"
    ];
  };

  home.packages = with pkgs; [
    nixfmt
    lutris
    autojump
    bitwig-studio
    blueman
    dropbox
    firefox
    ghcid
    gnome3.networkmanagerapplet
    i3lock
    imagemagick
    pa_applet
    pcmanfm
    plantuml
    python-language-server
    pywal
    rofi-pass
    scrot
    spotify
    tdesktop
    tldr
    trayer
    xfce.xfce4-power-manager
    xmobar
    youtube-dl
    (python37.withPackages(ps: with ps; [
      Keras
      flake8
      jupyter
      numpy
      pip
      pytest
      tensorflow
      tensorflow-tensorboard
    ]))
  ];

  news.display = "silent";

  nixpkgs.config.allowUnfree = true;

  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = "Iosevka";
          };
          size = 12.0;
        };
      };
    };
    command-not-found.enable = true;
    feh.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      # signing.key = "";
      userEmail = "me@xdefrag.dev";
      userName = "Stanislav Karkavin";
    };
    go = {
      enable = true;
      packages = {};
      goBin = "go/bin";
      goPath = "go";
    };
    gpg.enable = true;
    jq.enable = true;
    mpv.enable = true;
    rofi.enable = true;
    rtorrent.enable = true;
    ssh.enable = true;
    texlive = {
      enable = true;
      # package = pkgs.texlive.combined.scheme-full;
    };
    zsh = {
      enable = true;
      initExtra = ''
                  cat ~/.cache/wal/sequences
                  source ~/.cache/wal/colors-tty.sh
                  '';
      enableAutosuggestions = true;
      enableCompletion = true;
      autocd = true;
      defaultKeymap = "emacs";
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "extract" "pass" "rsync" "docker"
                    "golang" "kubectl" "autojump" ];
        theme = "minimal";
      };
      shellAliases = {
        v = "vim";
        e = "emacsclient";
        k = "kubectl";
        p = "pass";
        df = "df -h";
        ns = "sudo nixos-rebuild switch";
        hs = "home-manager switch";
      };
    };
  };

  services = {
    dunst.enable = true;
    gpg-agent.enable = true;
    picom = {
      enable = true;
      blur = true;
      fade = true;
      fadeDelta = 5;
      shadow = false;
      vSync = true;
    };
  };

  xsession = {
    enable = true;
    initExtra =
      ''
      wal -R &
      trayer --edge top --align right --SetDockType true --SetPartialStrut true \
             --expand true --width 15 --transparent true --alpha 0 --tint 0x283339 --height 20\
             --monitor 1 &
      nm-applet &
      xfce4-power-manager &
      blueman-applet &
      dropbox &
      pa-applet &
      '';
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };

  home.file = {
    ".emacs".text =
      ''
      (package-initialize)
      (org-babel-load-file "~/Dropbox/org/emacs-cfg.org")
      '';
    ".xmonad/xmonad.hs".source = ./dotfiles/xmonad.hs;
    ".xmobarrc".source = ./dotfiles/xmobarrc;
  };

  xdg.configFile = {
    "dunst/dunstrc".source = ./dotfiles/dunstrc;
    "rofi/config.rasi".text =
      ''
      configuration {
        theme: "~/.cache/wal/colors-rofi-light";
      }
      '';
  };
}
