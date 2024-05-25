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
  # packages
  environment.systemPackages = with pkgs; [
    # graphics and modelling
    krita
    openscad
    pikopixel
    grafx2
    darktable
    rawtherapee
    inkscape
    blender
    libresprite
    gmsh
    solvespace
    antimony
    drawpile
    rx
    wings
    lazpaint
    hugin
    makehuman
    # music and stuff
    zrythm
    vmpk
    hydrogen
    mimic
    frescobaldi
    denemo
    MIDIVisualizer
    sonic-visualiser
    tony
    bpm-tools
    supercollider
    puredata
    bambootracker
    schismtracker
    milkytracker
    qtractor
    ardour
    musescore
    giada
    non
    surge-XT
    luppp
    sonic-lineup
    #openutau # error: cannot download Concentus.Oggfile.1.0.4.nupkg from any mirror
    kwave
    furnace
    lmms
    polyphone
    paulstretch
    muse
    #csound-qt
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
    # other plugins
    zynaddsubfx-ntk
    calf
    ChowCentaur
    bespokesynth
    yoshimi
    industrializer
    boops
    dexed
    cardinal
    stochas
    sfizz
    # video editing and effects
    olive-editor
    flowblade
    #cinelerra # error: cannot download source from any mirror
    kdenlive
    openshot-qt
    natron
  ];
}
