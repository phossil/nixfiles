{ lib, pkgs, ... }:

{
  # install zsh with autosuggestions
  programs.zsh.enable = true;
  programs.zsh.autosuggestions.enable = true;

  # this is absolutely mandatory, i swear
  programs.starship.enable = true;
  programs.starship.settings = import ./starship.toml.nix;

  # i want my time stamps
  services.atuin.enable = true;
  # 128 * 1024 makes sense, right ?
  services.atuin.maxHistoryLength = 131072;
  # the above only enables the server, a client instance is needed
  # TODO: add to global zshrc
  environment.systemPackages = [ pkgs.atuin ];
}
