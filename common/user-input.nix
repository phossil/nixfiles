{ config, pkgs, ... }:

{
  # List services that you want to enable:
  services = {
    # Configure keymap in X11
    xserver.xkb.layout = "us";
    # `ctrl:nocaps`: Map Caps Lock as an additional Ctrl key
    # (the vanilla Caps Lock key is useless to me)
    xserver.xkb.options = "ctrl:nocaps";
    # Enable touchpad with tap-to-click support
    libinput.touchpad.tapping = true;
  };
  # tty stuff
  console = {
    # use the X11 keymap settings instead
    useXkbConfig = true;
  };
}
