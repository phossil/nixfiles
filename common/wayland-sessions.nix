{
  config,
  pkgs,
  nixflake-cuarzo,
  ...
}:

{
  # main compositor
  programs.labwc.enable = true;
  # extra just in case
  programs.miriway.enable = true;

  # the one i actually want to use, louvre views
  # requires `with pkgs;` for `${system}`
  services.displayManager.sessionPackages = with pkgs; [ nixflake-cuarzo.packages.${system}.louvre ];

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
