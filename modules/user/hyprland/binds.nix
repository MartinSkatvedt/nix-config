{ systemSettings, ... }:
let
  inherit (import ../../../hosts/${systemSettings.hostname}/config.nix)
    terminal browser;
in {
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";

      bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e2 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e2 -n2 set 5%-"
      ];
      bind = [
        "$mod, Q, exec, ${terminal}"
        "$mod,W,exec,${browser}"
        "$mod,P,exec, hyprpicker"

        "$mod, S, exec, rofi -show drun -show-icons"

        "$mod, C, killactive,"

        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Move focus with mod + hjkl (vim binds)
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        "$mod, PRINT, exec, hyprshot -m region"

      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]) 9));
    };
  };
}

