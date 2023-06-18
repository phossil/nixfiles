{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    gopls
    rust-analyzer
    rnix-lsp
  ];
}
