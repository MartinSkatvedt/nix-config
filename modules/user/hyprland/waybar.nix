{ lib, config, ... }:

with lib; {
  # Configure & Theme Waybar

  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      margin-top = 4;
      margin-left = 4;
      margin-right = 4;
      modules-center = [ "clock" "idle_inhibitor" ];
      modules-left = [ "custom/startmenu" "hyprland/workspaces" "tray" ];
      modules-right = [
        "custom/notification"
        "battery"
        "pulseaudio"
        "cpu"
        "memory"
        "disk"
        "custom/exit"
      ];

      "hyprland/workspaces" = {
        disable-scroll = false;

        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";

        move-to-monitor = true;
        all-outputs = true;
        format = "{icon} {windows}";

        on-click = "activate";
        window-rewrite-default = "";

        window-rewrite = {
          "title<.*youtube.*>" = "";
          "title<.*github.*>" = "";
          "title<.*gitlab.*>" = "";

          "class<google-chrome>" = "";
          "class<slack>" = "";
          "class<1Password>" = "";
          "class<xwaylandvideobridge>" = "";
          "org.kde.konsole" = "";
        };
      };

      "clock" = {
        format =
          "<span color='#${config.lib.stylix.colors.base0A}'>  </span> {:%H:%M} ";

        tooltip = true;
        tooltip-format = ''
          <big>{:%A, %d.%B %Y }</big>
          <tt><small>{calendar}</small></tt>'';
      };
      "hyprland/window" = {
        max-length = 22;
        separate-outputs = false;
        rewrite = { "" = " No Windows "; };
      };
      "memory" = {
        interval = 5;
        format =
          "<span color='#${config.lib.stylix.colors.base0B}'>  </span> {used:0.1f}G/{total:0.1f}G ";
        tooltip = true;
      };
      "cpu" = {
        interval = 5;
        format =
          "<span color='#${config.lib.stylix.colors.base0C}'>  </span> {usage}% ";
        tooltip = true;
      };
      "disk" = {
        format =
          "<span color='#${config.lib.stylix.colors.base0D}'>  </span> {specific_free:0.2f}GB";
        unit = "GB";
        tooltip = true;
      };
      "network" = {
        format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        format-ethernet = " {bandwidthDownOctets}";
        format-wifi = "{icon} {signalStrength}%";
        format-disconnected = "󰤮";
        tooltip = false;
      };
      "tray" = { spacing = 12; };
      "pulseaudio" = {
        format =
          "<span color='#${config.lib.stylix.colors.base0D}'> {icon} </span> {volume}% {format_source}";
        #format = "{icon} {volume}% {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = "";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" " " ];
        };
        on-click = "sleep 0.1 && pavucontrol";
      };
      "custom/exit" = {
        tooltip = false;
        format = "";
        on-click = "sleep 0.1 && wlogout";
      };
      "custom/startmenu" = {
        tooltip = false;
        format = "";
        on-click = "sleep 0.1 && rofi -show drun -show-icons";
      };
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
        tooltip = "false";
      };
      "custom/notification" = {
        tooltip = false;

        format =
          "<span color='#${config.lib.stylix.colors.base0A}'> {icon} </span> {}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification =
            "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification =
            "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "sleep 0.1 && task-waybar";
        escape = true;
      };
      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "<span color='#FF9F0A'> {icon} </span> {capacity}% ";
        format-charging = " {capacity}%";
        format-plugged = "󱘖 {capacity}%";
        format-icons = [ "" "" "" "" "" ];
        on-click = "";
        tooltip = true;
        tooltip-format = "{time} remaining until empty";
        tooltip-format-chargin = "{time} remaining until full";
      };
    }];

    style = concatStrings [''
      @define-color text-foreground #${config.lib.stylix.colors.base02};
      @define-color background #${config.lib.stylix.colors.base00};
      @define-color foreground #${config.lib.stylix.colors.base01};

      * {
        font-family: "JetBrainsMono NF Mono";
        font-size: 12px;
        border: none;
        min-height: 0px;
      }

      window#waybar {
        background-color: transparent;
        color: @text-foreground;
      }

      #custom-startmenu {
        font-size: 20px;
        border-radius: 12px;
        background: @background;
        padding: 8px 20px 8px 12px;
      }

      #workspaces {
        border-radius: 12px;
        background: @background;
        margin: 0px 8px 0px 8px;
      }

      #workspaces label {
        font-size: 12px;
      }

      #workspaces button:first-child {
        border-radius: 12px 0px 0px 12px;
        padding-left: 12px;
      }

      #workspaces button:last-child {
        border-radius: 0px 12px 12px 0px;
        padding-right: 12px;
      }

      #workspaces button {
        padding: 0 8px 0 8px;
        background: transparent;
        color: @text-foreground;
        border-radius: 0px;
      }
      #workspaces button.active {
        background-color: @foreground;
      }
      #workspaces button:hover {
        background-color: @foreground;
      }

      #tray {
        background: @background;
        padding: 8px;
        border-radius: 12px;
      }


      #clock, #idle_inhibitor {
        background: @background;
        padding: 8px;
      }

      #clock {
        font-weight: bold;
        border-radius: 12px 0px 0px 12px;
        padding-left: 12px;
      }

      #idle_inhibitor {
        border-radius: 0px 12px 12px 0px;
        padding-right: 12px;
      }


      tooltip {
        background: #${config.lib.stylix.colors.base00};
        border: 1px solid #${config.lib.stylix.colors.base05};
        border-radius: 12px;
      }
      tooltip label {
        color: #${config.lib.stylix.colors.base05};
      }

      #custom-notification, #battery, #pulseaudio, #cpu, #memory, #disk, #custom-exit {
        background: @background;
        padding: 8px;
      }

      #custom-notification {
        border-radius: 12px 0px 0px 12px;
        padding-left: 12px;
      }

      #custom-exit {
        border-radius: 0px 12px 12px 0px;
        padding-right: 12px;
      }
    ''];

  };
}

