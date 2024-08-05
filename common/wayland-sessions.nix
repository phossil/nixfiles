{
  config,
  pkgs,
  nixflake-cuarzo,
  ...
}:

{
  # macos-like wayland compositor
  # requires `with pkgs;` for `${system}`
  services.displayManager.sessionPackages = with pkgs; [ nixflake-cuarzo.packages.${system}.louvre ];

  # louvre doesn't seem to support xwayland yet
  programs.gamescope.enable = true;
  # xwayland capable compositor if gamescope fails
  programs.labwc.enable = true;
  # extra just in case
  programs.miriway.enable = true;

  # mandatory daemons
  environment.systemPackages = with pkgs; [
    synapse
    swaylock
    waybar
    swaynotificationcenter
    lxqt.lxqt-policykit
    swaybg
    wallust
    grim
    wofi
    # preferred but not usable on miriway yet
    gtklock # doesn't unlock
    ironbar # needs wlr_foreign_toplevel_manager
  ];
}
