{ lib, pkgs, ... }:

{
  # install zsh with autosuggestions
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    # history file size
    histSize = 100000;
  };
  # this is absolutely mandatory, i swear
  programs.starship.enable = true;
  programs.starship.settings = import ./starship.toml.nix;
}
