{ config, pkgs, ... }:

{
  # List services that you want to enable:
  services = {
    # graphics and stuff
    xserver = {
      # Configure keymap in X11
      layout = "us";
      # `ctrl:nocaps`: Map Caps Lock as an additional Ctrl key
      # (the vanilla Caps Lock key is useless to me)
      # `compose:menu`: Map the Menu key as the Compose key
      # (the Compose key is useful for inputing "exotic" characters)
      xkbOptions = "ctrl:nocaps,compose:menu";
      # Enable touchpad with tap-to-click support
      libinput.touchpad.tapping = true;
    };
  };
  # tty stuff
  console = {
    # use the X11 keymap settings instead
    useXkbConfig = true;
  };
}
