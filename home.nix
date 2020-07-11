{ lib, pkgs, cfg, ... }:

{
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
      keybindings = let mod = cfg.config.modifier; in lib.mkOptionDefault { };
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
      ];
    };
    extraConfig = ''
      include "$HOME/.cache/wal/colors-sway"

      output * background $wallpaper fill
      client.focused $color0 $background $foreground $color7 $background

      input * {
        xkb_layout "us,ru"
        xkb_options "grp:ctrl_shift_toggle,ctrl:swapcaps"
      }

      bindsym XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
      bindsym XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
      bindsym XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
      bindsym XF86MonBrightnessDown exec brightnessctl set 5%-
      bindsym XF86MonBrightnessUp exec brightnessctl set +5%
      bindsym XF86AudioPlay exec playerctl play-pause
      bindsym XF86AudioNext exec playerctl next
      bindsym XF86AudioPrev exec playerctl previous
    '';
  };

  home.packages = with pkgs; [
    act
    autojump
    bitwig-studio
    blueman
    cantarell-fonts
    corefonts
    dropbox
    fff
    font-awesome
    gopls
    imagemagick
    iosevka
    lutris
    mako
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
    tldr
    universal-ctags
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
    };
    go = {
      enable = true;
      packages = { };
      goBin = "go/bin";
      goPath = "go";
    };
    gpg.enable = true;
    jq.enable = true;
    mpv.enable = true;
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
          "git"
          "extract"
          "pass"
          "rsync"
          "docker"
          "golang"
          "kubectl"
          "autojump"
        ];
        theme = "minimal";
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
}
