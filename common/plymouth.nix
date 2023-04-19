{ lib, pkgs, ... }:

# gimme yuyu !!!
{
  boot.plymouth = {
    enable = true;
    # yuyu spinny
    logo = pkgs.fetchurl {
      # i couldn't find a better link for the image but the site credits
      # a user known as general cirno [1], who credits another user known
      # as azu [2] for ripping the sprite from a fighting game known as
      # mystic chain [3], so if anyone knows of a place where some of
      # the assets are online please let me know
      url = "https://ninetales.neocities.org/img/yuyuko_attack_by_generalcirno-d36n1jf.gif";
      sha256 = "t4IY20W0O5+qZ3/mSZcFpq4UeIquXmQXBQYX9MHeFjc=";
    };
  };
}
# references for the image
# 1. [piczo's neocities page](https://ninetales.neocities.org/cc)
# 2. [Yuyuko Attack by GeneralCirno on DeviantArt](https://www.deviantart.com/generalcirno/art/Yuyuko-Attack-192551307)
# 3. [Mystical Chain - Touhou Wiki - Characters, games, locations, and more](https://en.touhouwiki.net/wiki/Mystical_Chain)
