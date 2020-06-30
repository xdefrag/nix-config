{ lib, pkgs, cfg, ... }:

{
  home.sessionVariables = { };

  home.keyboard = {
    layout = "us,ru";
    options = [ "grp:ctrl_shift_toggle" "ctrl:swapcaps" ];
  };

  fonts.fontconfig.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = {
      bars = [{ command = "waybar"; }];
      fonts = [ "Iosevka Term 10" ];
      keybindings = let mod = cfg.config.modifier; in lib.mkOptionDefault { };
      menu = "${pkgs.rofi}/bin/rofi -show run";
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      window = {
        border = 0;
        titlebar = false;
      };
      workspaceAutoBackAndForth = true;
      startup = [{ command = "mako"; }];
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
    font-awesome
    cantarell-fonts
    mako
    waybar
    sway-contrib.grimshot
    corefonts
    iosevka
    autojump
    bitwig-studio
    blueman
    dropbox
    firefox
    ghcid
    swaylock
    swayidle
    swaybg
    imagemagick
    lutris
    nixfmt
    plantuml
    python-language-server
    pywal
    rofi-pass
    scrot
    spotify
    tdesktop
    tldr
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
      font = "Iosevka Term 10";
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
      '';
      enableAutosuggestions = true;
      enableCompletion = true;
      autocd = true;
      defaultKeymap = "emacs";
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
    gpg-agent.enable = true;
    pasystray.enable = true;
  };

  home.file = {
    ".emacs".text = ''
      (package-initialize)
      (org-babel-load-file "~/Dropbox/org/emacs-cfg.org")
    '';
  };

  xdg.configFile = {
    "rofi/config.rasi".text = ''
      configuration {
      theme: "~/.cache/wal/colors-rofi-light";
      }
    '';
    "waybar/config".source = ./dotfiles/waybar;
    "waybar/style.css".source = ./dotfiles/style.css;
    "mako/config".text = ''font=Iosevka Term 10
background-color=#323232
text-color=#FFFFFF
border-size=0
default-timeout=2000'';
  };
}
