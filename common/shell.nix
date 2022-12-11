{ lib, pkgs, ... }:

{
  # install zsh with autosuggestions
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
  };
  # this is absolutely mandatory, i swear
  programs.starship.enable = true;
  programs.starship.settings = import ./starship.toml.nix;
}
