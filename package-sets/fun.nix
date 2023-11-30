{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    cli-visualizer
    cava
    projectm
    glava
    neo-cowsay
    nicotine-plus
    bucklespring-libinput
    bottom-rs
    uwuify
    owofetch
    activate-linux
    soulseekqt
  ];
}
