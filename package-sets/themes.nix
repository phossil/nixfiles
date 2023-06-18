{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    luna-icons
    la-capitaine-icon-theme
    flat-remix-icon-theme
    kora-icon-theme
    papirus-icon-theme
    vimix-icon-theme
    tela-icon-theme
    sweet
    orchis-theme
  ];
}
