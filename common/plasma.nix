{ config, pkgs, lib, ... }:

{
  # enable plasma5 qwq
  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    xserver.desktopManager.plasma5.enable = true;
    displayManager.defaultSession = lib.mkForce "plasmawayland";
  };

  programs = {
    # i thought this was installed by default qwq
    kdeconnect.enable = true;
    # gnome disks alone isn't enough !!!
    partition-manager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # syncthing is nice
    syncthingtray
  ];

  # the gtk-based (?) panel is annoying
  i18n.inputMethod.ibus.panel = "${pkgs.plasma5Packages.plasma-desktop}/lib/libexec/kimpanel-ibus-panel";
}
