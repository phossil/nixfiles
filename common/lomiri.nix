# ty, puna !!
{ config, pkgs, lib, ... }:

{
  services.desktopManager.lomiri.enable = true;
  services.xserver.displayManager.lightdm.enable =
    if (config.services.displayManager.sddm.enable == true)
    then false else true;
}
