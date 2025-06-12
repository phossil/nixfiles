{ lib, pkgs, ... }:

{
  # install fish
  programs.fish.enable = true;

  # this is absolutely mandatory, i swear
  programs.starship.enable = true;
  programs.starship.settings = lib.importTOML ./starship.toml;

  # i want my time stamps
  services.atuin.enable = true;
  # 128 * 1024 makes sense, right ?
  services.atuin.maxHistoryLength = 131072;

  environment.systemPackages = with pkgs; [
    # the above only enables the server, a client instance is needed
    # TODO: add to global fish config
    atuin
    # add the `!!` function to fish , like bash and zsh
    fishPlugins.bang-bang
  ];
}
