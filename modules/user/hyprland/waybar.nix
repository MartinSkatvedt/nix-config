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
        "network"
        "custom/notification"
        "battery"
        "backlight"
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
          "title<.*bitbucket.*>" = "";
          "title<.*Calendar.*>" = "";
          "title<.*NixOS.*>" = "󱄅";

          "class<google-chrome>" = "";
          "class<slack>" = "";
          "class<1Password>" = "";
          "class<xwaylandvideobridge>" = "";
          "org.kde.konsole" = "";
        };
      };

      "clock" = {
        format =
          "<span color='#${config.lib.stylix.colors.base08}'>  </span> {:%H:%M} ";

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
          "<span color='#${config.lib.stylix.colors.base0C}'>  </span> {used:0.1f}G/{total:0.1f}G ";
        tooltip = true;
      };
      "cpu" = {
        interval = 5;
        format =
          "<span color='#${config.lib.stylix.colors.base0B}'>  </span> {usage}% ";
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
        format-wifi =
          "<span color='#${config.lib.stylix.colors.base0C}'> {icon} </span> {signalStrength}%";
        format-disconnected = "󰤮";
        tooltip = true;
      };
      "tray" = { spacing = 12; };
      "pulseaudio" = {
        format =
          "<span color='#${config.lib.stylix.colors.base0A}'> {icon} </span> {volume}% <span color='#${config.lib.stylix.colors.base0A}'> {format_source} </span>";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted =
          "<span color='#${config.lib.stylix.colors.base0A}'>  {format_source} </span>";
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

      "backlight" = {
        interval = 1;
        format = "{icon} {percent}%";
        format-icons = [ "🔅" "🔆" ];

      };
      "custom/exit" = {
        tooltip = false;
        format =
          "<span color='#${config.lib.stylix.colors.base08}'>  </span> ";
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
          "<span color='#${config.lib.stylix.colors.base09}'> {icon} </span> {}";
        format-icons = {
          notification = "<span background-selected='red'><sup></sup></span>";
          none = "";
          dnd-notification =
            "<span background-selected='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification =
            "<span background-selected='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification =
            "<span background-selected='red'><sup></sup></span>";
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
        interval = 1;
        format = "<span color='#008000'> {icon} </span> {capacity}% ";
        format-charging = "<span color='#FF9F0A'>  </span> {capacity}%";
        format-plugged = "<span color='#FF9F0A'> 󱘖 </span> {capacity}%";
        format-icons = [ "" "" "" "" "" ];
        on-click = "";
        tooltip = true;
        tooltip-format = "{time} remaining until empty";
        tooltip-format-chargin = "{time} remaining until full";
      };
    }];

    style = concatStrings [''
      @define-color background #${config.lib.stylix.colors.base00};
      @define-color background-alt #${config.lib.stylix.colors.base01};
      @define-color background-selected #${config.lib.stylix.colors.base02};

      @define-color default-text #${config.lib.stylix.colors.base05};

      * {
        font-family: "JetBrainsMono NF Mono";
        font-size: 12px;
        border: none;
        min-height: 0px;
      }

      window#waybar {
        background-color: @background;
        border-radius: 12px;
        color: @default-text;
      }

      #custom-startmenu, #workspaces, #tray {
        padding: 0px 4px;
      }
      #custom-startmenu {
        font-size: 20px;
        padding-left: 12px;
        padding-right: 12px;
      }

      #workspaces {
        margin-right: 24px;
        margin-left: 8px;
      }

      #workspaces button {
        background: transparent;
        border-radius: 0px;
        padding: 8px;
        padding-right: 12px;
      }
      #workspaces button.active {
        background-color: @background-selected;
      }
      #workspaces button:hover {
        background-color: @background-alt;
      }


      #clock, #idle_inhibitor {
        padding: 0px 4px;
      }
      #clock {
        font-weight: bold;
      }


      #custom-notification, #battery, #pulseaudio, #cpu, #memory, #disk, #custom-exit {
        padding: 0px 4px;
      }
      #custom-exit {
        padding-right: 12px;
        padding-left: 4px;
      }

      tooltip {
        background: @background;
        border: 1px solid @default-text;
        border-radius: 12px;
      }
      tooltip label {
        color: @default-text;
      }
    ''];

  };
}

