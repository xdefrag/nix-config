{config, pkgs, ...}:

let simpleXService = name: description: execStart: {
    inherit description;
    environment = {
      DISPLAY = ":0";
    };
    serviceConfig = {
      Type = "simple";
      User = "xdefrag";
      ExecStart = pkgs.writeScript name ''
          #! ${pkgs.bash}/bin/bash
          . ${config.system.build.setEnvironment}
          set -xe
          ${execStart}
        '';
      RestartSec = 3;
      Restart = "always";
    };
    wantedBy = [ "display-manager.service" ];
    after = [ "display-manager.service" ];
  };
in {
  environment.etc = {
    "gitconfig".source = ./dotfiles/gitconfig;
    "dunst/dunstrc".source = ./dotfiles/dunstrc;
    "X11/xresources".source = ./dotfiles/xresources;
  };

  systemd.services = {
    dunst = simpleXService "dunst"
      "libnotify server"
      "exec ${pkgs.dunst}/bin/dunst -config /etc/dunst/dunstrc"
      ;

    xbanish = simpleXService "xbanish"
      "xbanish hides the mouse pointer"
      "exec ${pkgs.xbanish}/bin/xbanish"
      ;

    xrdb = simpleXService "xrdb"
      "set X resources"
      ''
        ${pkgs.xorg.xrdb}/bin/xrdb /etc/X11/xresources
        exec sleep infinity
      '';
  };
 }