{ systemSettings, pkgs, ... }:
let
  inherit (import ../../../hosts/${systemSettings.hostname}/config.nix)
    background-image;
in {

  home.packages = with pkgs;
    [
      swww # Wayland wallpaper daemon
    ];
  # Place Files Inside Home Directory
  home.file = {
    "Pictures/Wallpapers" = {
      source = ../../../wallpapers;
      recursive = true;
    };
    #".face.icon".source = ./face.jpg;
    #".config/face.jpg".source = ./face.jpg;
  };

  wayland.windowManager.hyprland = {
    enable = true; # enable  Hyprland
    # set the flake package
    package = null;
    portalPackage = null;

    systemd.enable = false; # disable systemd service
    systemd.variables = [ "--all" ];

    settings = {

      exec-once = [
        "killall -q waybar;sleep .5 && waybar"
        "killall -q swayc;sleep .5 && swayc"
        "killall -q swww;sleep .5 && swww-daemon"

        "nm-applet --indicator"
        "sleep 1.5 && swww img ${background-image}"
      ];

      windowrulev2 = [
        "tag +settings, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"

        "center, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
      ];

      misc = {
        layers_hog_keyboard_focus = true;
        initial_workspace_tracking = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = false;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_swallow = false;
        vfr = true; # Variable Frame Rate
        vrr =
          2; # Variable Refresh Rate  Might need to set to 0 for NVIDIA/AQ_DRM_DEVICES
        # Screen flashing to black momentarily or going black when app is fullscreen
        # Try setting vrr to 0
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures = { workspace_swipe = true; };

      input = {
        kb_layout = "no";
        kb_options = "caps:swapescape";
      };
    };

    extraConfig = ''
      monitor=,preferred,auto,auto
    '';

    #plugins = [ inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars ];
  };

  # hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
