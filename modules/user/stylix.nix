{ pkgs, systemSettings, ... }:
let
  inherit (import ../../hosts/${systemSettings.hostname}/config.nix)
    background-image;

in {
  stylix = {
    enable = true;

    image = background-image;
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    base16Scheme = {
      base00 = "327219"; # Background - Dark Green
      base01 = "6cb44c"; # Foreground - Green
      base02 = "e9e9f4"; # Text foreground - Offwhite
      base03 = "626483";
      base04 = "62d6e8";
      base05 = "e9e9f4";
      base06 = "f1f2f8";
      base07 = "f7f7fb";
      base08 = "ea51b2";
      base09 = "b45bcf";

      base0A = "00b5ff"; # Accent - Light blue
      base0B = "6cb44c"; # Accent - Yoshi green
      base0C = "00b5ff"; # Accent -Yoshi green accent -Light blue
      base0D = "9999cc"; # Accent - Yoshi red accent - Green
      base0E = "b33618"; # Accent - Yoshi red
      base0F = "0062e0"; # Accent -Yoshi red accent - Blue
    };

    targets = {
      waybar.enable = false;
      firefox.enable = false;
      hyprland.enable = false;
      tmux.enable = false;
    };

    polarity = "dark";
    opacity.terminal = 0.7;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 11;
        popups = 12;
      };
    };
  };
}

