{ config, pkgs, ... }:

{
  # define lv2 path and some other stuff because zrythm
  # copied from musnix/modules/base.nix
  environment.variables = {
    DSSI_PATH =
      "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi";
    LADSPA_PATH =
      "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa";
    LV2_PATH =
      "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2";
    LXVST_PATH =
      "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst";
    VST_PATH =
      "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst";
  };
  # rtkit is optional but recommended for PipeWire
  security.rtkit.enable = true;
  # memory unlocking for zrythm, hopefully
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "95";
    }
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  ## pls make sure flakes are enabled for searching to work
  environment.systemPackages = with pkgs; [
    # now look at this lovely mess
    krita
    openscad
    pikopixel
    grafx2
    darktable
    rawtherapee
    inkscape
    zrythm
    blender
    libresprite
    gmsh
    bambootracker
    solvespace
    antimony
    drawpile
    supercollider
    bpm-tools
    # music and stuff
    vmpk
    hydrogen
    zynaddsubfx-ntk
    calf
    mimic
    frescobaldi
    denemo
    MIDIVisualizer
    sonic-visualiser
    tony
    puredata
    schismtracker
    milkytracker
    qtractor
    ardour
    musescore
    giada
    ChowCentaur
    bespokesynth
    yoshimi
    non
    qsynth
    industrializer
    boops
    # lv2 plugins - archlinux.org/groups/x86_64/lv2-plugins/
    geonkick
    distrho
    zam-plugins
    dragonfly-reverb
    zynaddsubfx-ntk
    adlplug
    ams-lv2
    artyFX
    x42-avldrums
    bchoppr
    bsequencer
    bshapr
    stone-phaser
    drumgizmo
    drumkv1
    eq10q
    fomp
    x42-gmsynth
    guitarix
    gxplugins-lv2
    helm
    infamousPlugins
    lsp-plugins
    mda_lv2
    ninjas2
    noise-repellent
    opnplug
    padthv1
    qmidiarp
    samplv1
    setbfree
    sorcer
    spectmorph
    synthv1
    wolf-shaper
    x42-plugins
    bslizr
  ];
}
