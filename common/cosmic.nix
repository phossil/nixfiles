{
  config,
  libs,
  pkgs,
  nixos-cosmic,
  ...
}:

{
  # import nixos module from the cosmic flake
  imports = [ nixos-cosmic.nixosModules.default ];

  # use prebuilt binaries when possible
  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };

  # main setting
  services.desktopManager.cosmic.enable = true;

  # don't enable cosmic greeter if sddm is already enabled qwq
  services.displayManager.cosmic-greeter.enable =
    if (config.services.displayManager.sddm.enable == true) then false else true;

  # i need my kde connects qwq
  programs.kdeconnect.enable = true;

  # hopefully cosmic can theme qt apps soon TwT
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  environment.systemPackages = with pkgs; [
    # the cosmic file manager looks pretty but it ruins my file metadata
    # including mtime and crtime
    gnome.nautilus
    # xwayland support is still a bit buggy when multiple x11 apps close and later re-open
    # when possible , use wayland
    qt5.qtwayland
    qt6.qtwayland
  ];
}
