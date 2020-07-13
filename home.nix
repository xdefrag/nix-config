{ lib, pkgs, cfg, ... }:

{
  accounts.email.maildirBasePath = ".mail";

  accounts.email.accounts = {
    mycoldwinter = {
      address = "mycoldwinter@gmail.com";
      userName = "mycoldwinter@gmail.com";
      realName = "Stanislav Karkavin";
      primary = true;
      flavor = "gmail.com";
      passwordCommand = "${pkgs.pass}/bin/pass mycoldwinter@gmail.com";
      msmtp.enable = true;
      notmuch.enable = true;
      neomutt.enable = true;
      imapnotify = {
        enable = true;
        boxes = [ "Inbox" ];
        onNotifyPost = "${pkgs.libnotify}/bin/notify-send mycoldwinter@gmail.com 'New mail'";
      };
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        remove = "both";
        patterns = [ "*" "![Gmail]*" "[Gmail]/Sent Mail" ];
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.keyboard = {
    layout = "us,ru";
    options = [ "grp:ctrl_shift_toggle" "ctrl:swapcaps" ];
  };

  fonts.fontconfig.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = {
      bars = [{ command = "waybar"; }];
      fonts = [ "Iosevka 10" ];
      menu = "${pkgs.rofi}/bin/rofi -show run";
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      window = {
        border = 0;
        titlebar = false;
      };
      workspaceAutoBackAndForth = true;
      startup = [
        { command = "mako"; }
        { command = "dropbox"; }
        { command = "qutebrowser"; }
        { command = "telegram-desktop"; }
      ];
      assigns = {
        "1: web" = [ 
          { class = "qutebrowser"; }
        ];
        "2: msg" = [
          { class = "TelegramDesktop"; }
        ];
        "3: wrk" = [];
        "4: msc" = [];
      };
      floating.criteria = [
        { title = ".*mpv$"; }
      ];
      input = {
        "*" = { 
          xkb_layout = "us,ru";
          xkb_options = "grp:ctrl_shift_toggle,ctrl:swapcaps";
        };
      };
      keybindings = lib.mkOptionDefault {
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
      };
    };
    extraConfig = ''
      include "$HOME/.cache/wal/colors-sway"

      output * background $wallpaper fill
      client.focused $color0 $background $foreground $color7 $background
    '';
  };

  home.packages = with pkgs; [
    gitAndTools.bfg-repo-cleaner
    gitAndTools.git-absorb
    gitAndTools.git-extras
    gitAndTools.git-fame
    gitAndTools.git-open
    gitAndTools.git-secrets

    act
    autojump
    bitwig-studio
    blueman
    cantarell-fonts
    corefonts
    dropbox
    fff
    font-awesome
    git-doc
    gopls
    imagemagick
    iosevka
    libnotify
    lutris
    mako
    neofetch
    nixfmt
    nixos-icons
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    plantuml
    pywal
    qutebrowser
    rofi-pass
    rtv
    scrot
    spotify
    sway-contrib.grimshot
    swaybg
    swayidle
    swaylock
    tdesktop
    thefuck
    tldr
    universal-ctags
    w3m
    waybar
    youtube-dl
    (python37.withPackages (ps:
      with ps; [
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
    home-manager.enable = true;
    alacritty = {
      enable = true;
      settings = {
        font = {
          normal = { family = "Iosevka"; };
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
      extraConfig = {
        pull = {
          rebase = true;
        };
      };
    };
    go = {
      enable = true;
      packages = { };
      goBin = "go/bin";
      goPath = "go";
    };
    gpg = {
      enable = true;
    };
    jq.enable = true;
    mpv.enable = true;
    notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync -a";
      };
    };
    neomutt = {
      enable = true;
      editor = "${pkgs.vim}/bin/vim";
      vimKeys = true;
      sort = "date-received";
      extraConfig = ''
        auto_view text/html
        alternative_order text/plain text/html
      '';
    };
    mbsync = {
      enable = true;
    };
    msmtp.enable = true;
    rofi = {
      enable = true;
      font = "Iosevka 10";
    };
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

        if [ "$(tty)" = "/dev/tty1" ]; then
	       exec sway
        fi
      '';
      enableAutosuggestions = true;
      enableCompletion = true;
      autocd = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "autojump"
          "bgnotify"
          "docker"
          "extract"
          "fancy-ctrl-z"
          "fzf"
          "git"
          "gitignore"
          "git-extras"
          "golang"
          "kubectl"
          "man"
          "pass"
          "rsync"
          "thefuck"
        ];
        theme = "lambda";
      };
      shellAliases = {
        v = "vim";
        k = "kubectl";
        p = "pass";
        r = "ranger";
        t = "gotop";
        df = "df -h";
        ns = "sudo nixos-rebuild switch";
        hs = "home-manager switch";
        s = "systemctl --user";
      };
    };
    vim = {
      enable = true;
      extraConfig = builtins.readFile ./dotfiles/vimrc;
      plugins = with pkgs.vimPlugins; [
        auto-pairs
        fzf-vim
        supertab
        tagbar
        vim-commentary
        vim-dispatch
        vim-eunuch
        vim-gitgutter
        vim-polyglot
        vim-repeat
        vim-surround
        vim-unimpaired
        wal-vim
        vim-snippets
        vim-snipmate
      ];
    };
  };

  services = {
    gpg-agent.enable = true;
    mbsync = {
      enable = true;
      frequency = "*:0/5";
      postExec = "${pkgs.notmuch}/bin/notmuch new";
    };
  };

  xdg = {
    configFile = {
        "rofi/config.rasi".text = ''
        configuration {
        theme: "~/.cache/wal/colors-rofi-light";
        }
        '';
        "rtorrent/rtorrent.rc".source = ./dotfiles/rtorrent.rc;
        "waybar/config".source = ./dotfiles/waybar;
        "waybar/style.css".source = ./dotfiles/style.css;
        "mako/config".source = ./dotfiles/mako;
        "qutebrowser/config.py".source = ./dotfiles/qutebrowser.py;
        "qutebrowser/qutewal.py".source = ./dotfiles/qutewal.py;
    };
  };

  home.file = {
    ".mailcap".source = ./dotfiles/mailcap;
  };
}
