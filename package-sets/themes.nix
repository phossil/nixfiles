{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    #luna-icons # error: luna-icons has been removed as it was removed upstream
    #la-capitaine-icon-theme # `ERROR: noBrokenSymlinks: found 7 dangling symlinks, 0 reflexive symlinks and 0 unreadable symlinks`
    flat-remix-icon-theme
    kora-icon-theme
    papirus-icon-theme
    vimix-icon-theme
    tela-icon-theme
    sweet
    orchis-theme
  ];
}
