{ userSettings, ... }: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0;
        hide_cursor = true;
        ignore_empty_input = true;
      };
      background = [{
        path = "/home/${userSettings.username}/Pictures/Wallpapers/group.jpg";
        blur_passes = 3;
        blur_size = 8;
      }];
      image = [{
        path = "/home/${userSettings.username}/Pictures/Wallpapers/yoshi.png";
        size = 150;
        border_size = 4;
        #border_color = "rgb(0C96F9)";
        rounding = -1; # Negative means circle
        position = "0, 200";
        halign = "center";
        valign = "center";
      }];
      input-field = [{
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(CFE6F4)";
        inner_color = "rgb(657DC2)";
        outer_color = "rgb(0D0E15)";
        outline_thickness = 3;
        placeholder_text = "Password...";
        shadow_passes = 2;
      }];
    };
  };
}

