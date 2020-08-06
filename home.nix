{ lib, pkgs, config, ... }:

with builtins;

let
  bash-sensible = fetchurl
    "https://raw.githubusercontent.com/mrzool/bash-sensible/master/sensible.bash";
in {
  accounts.email.maildirBasePath = ".mail";

  accounts.email.accounts = {
    s = {
      address = "s@humanramen.dev";
      userName = "s@humanramen.dev";
      realName = "Stanislav Karkavin";
      primary = true;
      passwordCommand = "${pkgs.pass}/bin/pass s@humanramen.dev";
      msmtp = {
        enable = true;
        extraConfig = { tls_starttls = "on"; };
      };
      notmuch.enable = true;
      neomutt.enable = true;
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        remove = "both";
      };
      smtp = {
        host = "mail.humanramen.dev";
        port = 587;
      };
      imap = {
        host = "mail.humanramen.dev";
        port = 993;
      };
    };
    mycoldwinter = {
      address = "mycoldwinter@gmail.com";
      userName = "mycoldwinter@gmail.com";
      realName = "Stanislav Karkavin";
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
      bindkeysToCode = true;
      bars = [{ command = "waybar"; }];
      fonts = [ "Iosevka 10" ];
      menu = "~/bin/launcher ~/bin/swayrun";
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      window = {
        border = 0;
        titlebar = false;
        commands = [
          {
            command = "sticky enable";
            criteria = { title = ".*mpv$"; };
          }
          {
            command = "resize set width 400px";
            criteria = { title = ".*mpv$"; };
          }
          {
            command = "move absolute position 1020px 300px";
            criteria = { title = ".*mpv$"; };
          }
        ];
      };
      workspaceAutoBackAndForth = true;
      startup = [
        { command = "gebaard -b"; }
        { command = "mako"; }
        { command = "dropbox"; }
      ];
      floating = {
        border = 0;
        criteria = [ { title = ".*mpv$"; } { app_id = "launcher"; } ];
      };
      input = {
        "*" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:ctrl_shift_toggle,ctrl:swapcaps";
        };
      };
      keybindings =
        let modifier = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+a" = "exec ~/bin/launcher ~/bin/swaypass";
          "${modifier}+v" = "exec ${pkgs.alacritty}/bin/alacritty -e vim";
          "${modifier}+n" = "exec ${pkgs.alacritty}/bin/alacritty -e newsboat";
          "${modifier}+m" = "exec ${pkgs.alacritty}/bin/alacritty -e neomutt";
          "${modifier}+b" = "exec ${pkgs.qutebrowser}/bin/qutebrowser";
          "${modifier}+p" = "exec ${pkgs.alacritty}/bin/alacritty -e spt";
          "${modifier}+o" = "exec ${pkgs.alacritty}/bin/alacritty -e nnn";
          "${modifier}+t" = "exec ${pkgs.alacritty}/bin/alacritty -e gotop";
          "XF86AudioRaiseVolume" =
            "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" =
            "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
        };
      gaps = {
        left = 5;
        right = 5;
        outer = 5;
        inner = 5;
        top = 5;
        bottom = 5;
        horizontal = 5;
        vertical = 5;
        smartBorders = "on";
        smartGaps = true;
      };
    };
    extraConfig = ''
      include "$HOME/.cache/wal/colors-sway"

      output * background $wallpaper fill
      client.focused $color0 $background $foreground $color7 $background
    '';
  };

  home.packages = with pkgs;
    with pkgs.gitAndTools; [
      bfg-repo-cleaner
      git-absorb
      git-extras
      git-fame
      git-open
      git-secrets

      grim
      wl-clipboard
      cht-sh
      shellcheck
      direnv
      bash-completion
      bitwig-studio
      blueman
      cantarell-fonts
      corefonts
      cv
      dropbox
      font-awesome
      fswatch
      gebaar-libinput
      gnumake
      imv
      iosevka
      jq
      libnotify
      mako
      neofetch
      nixfmt
      nnn
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
      pandoc
      pywal
      qutebrowser
      scrot
      spotify-tui
      swaybg
      swaylock
      tdesktop
      universal-ctags
      urlview
      w3m
      waybar
      xdg_utils
      youtube-dl
      zathura
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
          dynamic_padding = true;
          decorations = "none";
        };
        background_opacity = 0.8;
      };
    };
    bash = {
      initExtra = (readFile bash-sensible + ''
        export PS1="\w ⚔️  "
        export PAGER="w3m"

        cat ~/.cache/wal/sequences

        eval "$(direnv hook bash)"

        if [[ $(tty) = /dev/tty1 ]]; then
        exec sway
        fi
      '');
      enable = true;
      enableAutojump = true;
      sessionVariables = {
        BROWSER = "qutebrowser";
        EDITOR = "vim";
        VISUAL = "$EDITOR";
        PATH = "$PATH:~/bin";
      };
      shellAliases = {
        v = "vim";
        vv = "cd ~/Dropbox && vim ~/Dropbox/index.md";
        vh = "cd ~/nix-config && vim ~/nix-config/home.nix";
        l = "ls -h --group-directories-first";
        la = "ls -h --group-directories-first --all";
        ".." = "cd ..";
        ns = "sudo nixos-rebuild switch";
        hs = "home-manager switch";
        t = "gotop";
        p = "progress";
      };
    };
    git = {
      enable = true;
      signing.key = "D0395157";
      userEmail = "s@humanramen.dev";
      userName = "Stanislav Karkavin";
      extraConfig = { pull = { rebase = true; }; };
    };
    gpg = { enable = true; };
    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
    mpv.enable = true;
    notmuch = {
      enable = true;
      search.excludeTags = [ "deleted" "spam" "trash" "archive" ];
      new.tags = [ "unread" "inbox" ];
      hooks = {
        preNew = "mbsync -a";
        postNew = ''
          notmuch tag -inbox +sent -- from:me@xdefrag.dev or from:mycoldwinter@gmail.com or from:s@humanramen.dev
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
    msmtp = { enable = true; };
    newsboat = {
      enable = true;
      autoReload = true;
      extraConfig = readFile ./dotfiles/newsboat;
    };
    rtorrent.enable = true;
    ssh.enable = true;
  };

  gtk.enable = false;
  qt.enable = false;

  services = {
    redshift = {
      enable = true;
      package = pkgs.redshift-wlr;
      latitude = "59";
      longitude = "30";
      temperature = {
        day = 5700;
        night = 3500;
      };
    };
    spotifyd = {
      enable = true;
      settings = {
        global = {
          username = "me@xdefrag.dev";
          password_cmd = "pass spotify-usa";
          device_name = "absu-spotifyd";
          bitrate = "320";
          backend = "pulseaudio";
        };
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
    lorri.enable = true;
  };

  xdg = {
    enable = true;
    configFile = {
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
      "git/ignore".text = ''
        dist/

        tags
        tags.lock
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
    "bin".source = ./bin;
    ".vim/vimrc".source = ./dotfiles/vim/vimrc;
    ".vim/after/ftplugin".source = ./dotfiles/vim/ftplugin;
    ".vim/autoload".source = ./dotfiles/vim/autoload;
    ".vim/colors".source = ./dotfiles/vim/colors;
    ".vim/compiler".source = ./dotfiles/vim/compiler;
    ".vim/plugin".source = ./dotfiles/vim/plugin;
    ".w3m/keymap".source = ./dotfiles/keymap.w3m;
    ".w3m/config".source = ./dotfiles/config.w3m;
    ".mailcap".source = ./dotfiles/mailcap;
    ".newsboat/urls".text = readFile ~/Dropbox/newsboat-urls;
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
