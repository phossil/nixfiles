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

  # exclude these packages bc the build them takes too long TwT
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-store
    cosmic-term
  ];
}
