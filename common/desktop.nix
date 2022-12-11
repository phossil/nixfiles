{ config, pkgs, ... }:

{
  hardware = {
    # disable PulseAudio bc PipeWire is better
    pulseaudio.enable = false;
    # enable bluetooth
    bluetooth.enable = true;
    # Enable scanner support because that's not included ???
    sane.enable = true;
  };
  # enable audio with pipewire
  services.pipewire = {
    enable = true;
    # compatibility with other audio api's
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
    # enable 32-bit because wine
    alsa.support32Bit = true;
  };
  # rtkit is optional but recommended for PipeWire
  security.rtkit.enable = true;
  # bluetooth stuff for pipewire
  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "all" ];
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ uniemoji mozc typing-booster ];
    };
  };

  # List services that you want to enable:
  services = {
    # Avahi or something
    avahi = {
      enable = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };
  };
}
