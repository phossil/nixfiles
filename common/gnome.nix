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
  qt5 = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # some gnome apps and extensions
  environment.systemPackages = with pkgs; [
    # now look at this lovely mess
    gnome.gnome-tweaks
    gnome.pomodoro
    gnomeExtensions.audio-output-switcher
    gnomeExtensions.vitals
    gnomeExtensions.syncthing-icon
    gnomeExtensions.systemd-manager
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.appindicator
    gnomeExtensions.material-shell
    gnomeExtensions.syncthing-indicator
    gnome-usage
    gnome.gnome-system-monitor
  ];

  # i genuinely forgot what this was for
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];
}
