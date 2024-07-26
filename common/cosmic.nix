{
  config,
  libs,
  nixos-cosmic,
  ...
}:

{
  imports = [ nixos-cosmic.nixosModules.default ];

  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };

  services.desktopManager.cosmic.enable = true;

  services.displayManager.cosmic-greeter.enable =
    if (config.services.displayManager.sddm.enable == true) then false else true;
}
