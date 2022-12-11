{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  ## pls make sure flakes are enabled for searching to work
  environment.systemPackages = with pkgs; [
    # now look at this lovely mess
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
