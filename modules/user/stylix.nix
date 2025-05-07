{ pkgs, systemSettings, ... }:
let
  inherit (import ../../hosts/${systemSettings.hostname}/config.nix)
    background-image;

in {
  stylix = {
    enable = true;

    image = background-image;
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    targets = {
      waybar.enable = false;
      firefox.enable = false;
      hyprland.enable = false;
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

