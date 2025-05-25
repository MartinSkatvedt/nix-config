{ systemSettings, pkgs, ... }:
let
  inherit (import ../../../hosts/${systemSettings.hostname}/config.nix)
    background-image terminal browser;
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
      general = {
        border_size = 0;
        gaps_out = 8;
        gaps_in = 4;
        layout = "master";
        resize_on_border = true;
      };

      decoration = {
        rounding = 8;
        dim_inactive = true;
        dim_strength = 0.2;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          ignore_opacity = false;
        };
        shadow = {
          enabled = true;
          range = 8;
          render_power = 3;
          color = "rgba(00000080)";
          offset = "4 4";

        };
      };

      input = {
        kb_layout = "no";
        kb_options = "caps:swapescape";
      };

      gestures = { workspace_swipe = true; };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        layers_hog_keyboard_focus = true;
        initial_workspace_tracking = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        enable_swallow = false;
        vrr = 3;
        animate_manual_resizes = true;
      };
      xwayland = { force_zero_scaling = true; };

      cursor = { hide_on_key_press = true; };
      ecosystem = { no_donation_nag = true; };

      exec-once = [
        "killall -q swayc;sleep .5 && swayc"
        "killall -q swww-daemon;sleep .5 && swww-daemon"

        "nm-applet --indicator"

        #Startup apps
        "[workspace 1 silent] ${terminal}"
        "[workspace 1 silent] ${browser}"
        "[workspace 2 silent] 1password"
        "[workspace 3 silent] slack"
      ];

      exec = [
        "killall -q .waybar-wrapped;sleep .5 && waybar"
        "sleep 1.5 && swww img ${background-image}"
      ];

      windowrulev2 = [
        "tag +settings, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"

        "center, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
      ];

    };

    extraConfig = ''
      monitor=,preferred,auto,auto
    '';

    #plugins = [ inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars ];
  };

  # hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
