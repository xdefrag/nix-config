{ pkgs, ... }:

{
  home.sessionVariables = {};

  home.packages = with pkgs; [
    autojump
    bitwig-studio
    dmenu
    dropbox
    firefox
    plantuml
    pywal
    rofi-pass
    tdesktop
    tldr
    xlockmore
    # (python37.withPackages(ps: with ps; [
    #   Keras
    #   flake8
    #   jupyter
    #   numpy
    #   pip
    #   pytest
    #   python-language-server
    #   tensorflow
    #   tensorflow-tensorboard
    # ]))
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
          size = 14.0;
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
      fadeDelta = 10;
      shadow = false;
      vSync = true;
    };
    screen-locker = {
      enable = true;
      inactiveInterval = 5;
      lockCmd = "i3lock";
    };
    spotifyd = {
      enable = true;
      settings = {
        global = {
          user = "me@xdefrag.dev";
          password_cmd = "pass spotify-usa";
          device_name = "nix";
          bitrate = "320";
        };
      };
    };
    stalonetray.enable = true;
    taffybar.enable = true;
  };

  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };

  home.file = {
    ".emacs".text = ''
                    (package-initialize)
                    (org-babel-load-file "~/Dropbox/org/emacs-cfg.org")
                    '';
  };
}
