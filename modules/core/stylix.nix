{ pkgs, ... }:

{
  # Styling Options
  stylix = {
    enable = true;
    #image = "../wallpapers/background.jpg";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    polarity = "dark";
    opacity.terminal = 1.0;
  };
}

