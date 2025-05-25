{ config, ... }:

{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "sleep 1; systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "sleep 1; systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "logout";
        action = "sleep 1; hyprctl dispatch exit";
        text = "Exit";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "sleep 1; systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "lock";
        action = "sleep 1; hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "sleep 1; systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
    ];
    style = ''
      * {
      	background-image: none;
      	transition: 20ms;
      }
      window {
        background-color: rgba(12, 12, 12, 0.9);
      }
      button {
      	color: #${config.lib.stylix.colors.base05};
        font-size:20px;
        background-repeat: no-repeat;
      	background-position: center;
      	background-size: 25%;
      	border-style: solid;
      	background-color: rgba(12, 12, 12, 0.3);
      	border: 3px solid #${config.lib.stylix.colors.base05};
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
      	margin: 10px;
      	border-radius: 12px;
        outline-style: none;
      }

      button:focus,
      button:active,
      button:hover {
        color: #${config.lib.stylix.colors.base02};
        background-color: rgba(12, 12, 12, 0.5);
        border: 3px solid #${config.lib.stylix.colors.base02};
      }
      #logout {
      	background-image: image(url("icons/logout.png"));
      }
      #suspend {
      	background-image: image(url("icons/suspend.png"));
      }
      #shutdown {
      	background-image: image(url("icons/shutdown.png"));
      }
      #reboot {
      	background-image: image(url("icons/reboot.png"));
      }
      #lock {
      	background-image: image(url("icons/lock.png"));
      }
      #hibernate {
      	background-image: image(url("icons/hibernate.png"));
      }
    '';
  };
  home.file.".config/wlogout/icons" = {
    source = ./icons;
    recursive = true;
  };
}

