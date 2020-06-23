{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = ["intel"];
    layout = "us,ru";
    xkbOptions = "eurosign:e,grp:ctrl_shift_toggle,ctrl:swapcaps";
    libinput.enable = true;
    libinput.disableWhileTyping = true;
    displayManager.defaultSession = "none+xmonad";
    desktopManager.xterm.enable = false;
    windowManager.xmonad.enable = true;
  };

  fonts.fonts = with pkgs; [
    corefonts
    iosevka
  ];
}
