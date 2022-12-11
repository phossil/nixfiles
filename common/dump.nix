{ lib, pkgs, ... }:

{
  # systemd's dns resolver
  services.resolved.enable = true;

  # heccin
  # monoprice
  # (huion) tablet >:[[[[
  services.xserver.digimend.enable = true;

  # iio-sensor-proxy for ambient light sensor
  hardware.sensor.iio.enable = true;

  # firefox with decent touchscreen suppport ??? :O
  environment.sessionVariables = { MOZ_USE_XINPUT2 = "1"; };
}
