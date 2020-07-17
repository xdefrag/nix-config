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
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        remove = "both";
      };
    };
    dev = {
      address = "me@xdefrag.dev";
      userName = "me@xdefrag.dev";
      realName = "Stanislav Karkavin";
      passwordCommand = "${pkgs.pass}/bin/pass me@xdefrag.dev";
      msmtp.enable = true;
      notmuch.enable = true;
      neomutt.enable = true;
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        remove = "both";
      };
      smtp = {
        host = "smtp.fastmail.com";
        port = 465;
      };
      imap = {
        host = "imap.fastmail.com";
        port = 993;
      };
    };
  };

  home.sessionVariables = { EDITOR = "vim"; };

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
        { command = "gebaard -b"; }
        { command = "mako"; }
        { command = "dropbox"; }
        { command = "qutebrowser"; }
        { command = "telegram-desktop"; }
      ];
      assigns = {
        "1:www" = [{ class = "qutebrowser"; }];
        "2:mail" = [{ class = "TelegramDesktop"; }];
      };
      floating.criteria = [{ title = ".*mpv$"; }];
      input = {
        "*" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:ctrl_shift_toggle,ctrl:swapcaps";
        };
      };
      keybindings = lib.mkOptionDefault {
        "XF86AudioRaiseVolume" =
          "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" =
          "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
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

    goimports
    golangci-lint
    gomodifytags
    gotests
    impl
    reftools

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

    xdg_utils
    gebaar-libinput
    zathura
    imv
    act
    autojump
    bitwig-studio
    blueman
    cantarell-fonts
    corefonts
    dropbox
    fff
    font-awesome
    iosevka
    mako
    neofetch
    nixfmt
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    plantuml
    pywal
    qutebrowser
    rofi-pass
    scrot
    spotify
    sway-contrib.grimshot
    swaybg
    swaylock
    tdesktop
    thefuck
    tldr
    universal-ctags
    w3m
    waybar
    youtube-dl 
  ];

  news.display = "silent";

  nixpkgs.config.allowUnfree = true;

  programs = {
    home-manager.enable = true;
    alacritty = {
      enable = true;
      settings = {
        env.TERM = "alacritty";
        font = {
          normal = { family = "Iosevka"; };
          size = 12.0;
        };
        window = {
          padding = {
            x = 0;
            y = 0;
          };
          dynamic_padding = false;
          decorations = "none";
        };
      };
    };
    command-not-found.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      # signing.key = "";
      userEmail = "me@xdefrag.dev";
      userName = "Stanislav Karkavin";
      extraConfig = { pull = { rebase = true; }; };
    };
    go = {
      enable = true;
      packages = { };
      goBin = "go/bin";
      goPath = "go";
    };
    gpg = { enable = true; };
    jq.enable = true;
    mpv.enable = true;
    notmuch = {
      enable = true;
      search.excludeTags = [ "deleted" "spam" "trash" "archive" ];
      new.tags = [ "unread" "inbox" ];
      hooks = {
        preNew = "mbsync -a";
        postNew = ''
          notmuch tag -inbox +sent -- from:me@xdefrag.dev or from:mycoldwinter@gmail.com
          notmuch tag +newsletters -inbox -- from:peter@golangweekly.com or from:peter@webopsweekly.com
          notmuch tag +notifications -inbox -- from:'*info*' or from:'*noreply*' or from:'*no-reply*' or from:'*postmaster*'
        '';
      };
    };
    neomutt = {
      enable = true;
      vimKeys = true;
      sort = "date-received";
      macros = [{
        action = "<modify-labels-then-hide>+archive -unread -inbox<enter>";
        key = "A";
        map = "index";
      }];
      extraConfig = ''
        set date_format="%m-%d"
        set index_format="%d | %-30F %s [%g]"

        set help=no

        auto_view text/html
        alternative_order text/plain text/html

        set fast_reply=yes
        set include=yes

        set virtual_spoolfile=yes
        set folder=notmuch-root-folder
        virtual-mailboxes "inbox" "notmuch://?query=tag:inbox"
        virtual-mailboxes "sent" "notmuch://?query=tag:sent"
        virtual-mailboxes "newsletters" "notmuch://?query=tag:newsletters"
        virtual-mailboxes "notifications" "notmuch://?query=tag:notifications"
        virtual-mailboxes "archive" "notmuch://?query=tag:archive"
      '';
    };
    mbsync = { enable = true; };
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
        export TERM=xterm-256color
        export PATH=$PATH:~/go/bin

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
        open = "xdg-open";
        nm = "notmuch";
        mutt = "TERM=screen-256color neomutt";
        neomutt = "TERM=screen-256color neomutt";
      };
    };
  };

  gtk.enable = false;
  qt.enable = false;

  services = {
    redshift = {
      enable = true;
      package = pkgs.redshift-wlr;
      latitude = "59";
      longitude = "30";
      brightness = {
        day = "0.7";
        night = "0.4";
      };
      temperature = {
        day = 5700;
        night = 3500;
      };
    };
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 34560000;
      maxCacheTtl = 34560000;
    };
    mbsync = {
      enable = true;
      frequency = "*:0/5";
      postExec = "${pkgs.notmuch}/bin/notmuch new";
    };
  };

  xdg = {
    enable = true;
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
      "gebaar/gebaard.toml".text = ''
        [commands.swipe.three]
        up = "sway fullscreen toggle"
        down = "sway layout toggle"
        left = "sway workspace next"
        right = "sway workspace prev"
      '';
    };
    mime.enable = false;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/epub+zip" = [ "org.pwmt.zathura.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "default-web-browser" = [ "org.qutebrowser.qutebrowser.desktop" ];
        "image/jpeg" = [ "imv.desktop" ];
        "image/png" = [ "imv.desktop" ];
        "text/html" = [ "org.qutebrowser.qutebrowser.desktop" ];
        "text/plain" = [ "vim.desktop" ];
        "inode/directory" = [ "fff.desktop" ];
        "x-scheme-handler/mailto" = [ "mutt.desktop" ];
      };
    };
    userDirs = {
      enable = true;
      desktop = "$HOME/desk";
      documents = "$HOME/docs";
      download = "$HOME/tmp";
      music = "$HOME/music";
      pictures = "$HOME/pics";
      publicShare = "$HOME/public";
      templates = "$HOME/templates";
      videos = "$HOME/videos";
    };
  };

  home.file = {
    ".mailcap".source = ./dotfiles/mailcap;
    ".local/share/applications/fff.desktop".text = ''
      [Desktop Entry]
      Name=FFF
      Comment=File browser
      Exec=fff
      Terminal=true
      Type=Application
      Icon=terminal
      MimeType=inode/directory;
    '';
    ".local/share/applications/vim.desktop".text = ''
      [Desktop Entry]
      Name=Vim Text Editor
      Comment=Edit text files
      Exec=vim 
      Terminal=true
      Type=Application
      Icon=terminal
      StartupNotify=true
      MimeType=text/plain;
    '';
    ".local/share/applications/mutt.desktop".text = ''
      [Desktop Entry]
      Name=Mail
      Exec=neomutt
      Terminal=true
      Type=Application
      Icon=terminal
      StartupNotify=true
      MimeType=x-scheme-handler/mailto;
    '';

  };
}
