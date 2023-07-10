{ config, pkgs, ... }:

{
  services = {
    # graphics and stuff
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # Enable the GNOME 3 Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  programs = {
    # kde connect but for gnome
    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
  };

  # make qt apps look good in gnome
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # some gnome apps and extensions
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.pomodoro
    gnome-usage
    gnome.gnome-system-monitor
  ] ++ (with pkgs.gnomeExtensions; [
    audio-output-switcher
    vitals
    #syncthing-icon
    systemd-manager
    alphabetical-app-grid
    appindicator
    #material-shell
    syncthing-indicator
    #fildem-global-menu
  ]);

  # i genuinely forgot what this was for
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];
}
