{ lib, pkgs, config, ... }:

with lib;
let
  cfg = config.services.xserver.windowManager.qvwm;
in

{
  ###### interface
  options = {
    services.xserver.windowManager.qvwm.enable = mkEnableOption (lib.mdDoc "qvwm");
  };

  ###### implementation
  config = mkIf cfg.enable {
    services.xserver.windowManager = {
      session = [{
        name = "qvwm";
        start = "
          ${pkgs.qvwm}/bin/qvwm
        ";
      }];
    };
    environment.systemPackages = [ pkgs.qvwm ];
  };
}
