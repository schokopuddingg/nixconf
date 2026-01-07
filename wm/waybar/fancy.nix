{
  config,
  pkgs,
  lib,
  ...
}:

# let
#   css = ./fancy.css;
# in

{
  programs = {

    wlogout = {
      enable = true;
    };

    hyprlock = {
      enable = true;
      settings = {
        # BACKGROUND
        background = {
          monitor = "";
          path = "~/.config/hypr/walls/1.png";
        };

        general = {
          no_fade_in = false;
          no_fade_out = false;
          hide_cursor = true;
          grace = 0;
          disable_loading_bar = true;
          ignore_empty_input = true;
        };

        "input-field" = {
          monitor = "";
          size = {
            width = 250;
            height = 60;
          };
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.2)";
          font_color = "rgb(205, 214, 244)";
          fade_on_empty = false;
          rounding = -1;
          placeholder_text = "<span foreground=\"#cdd6f4\">Password</span>";
          hide_input = false;
          position = {
            x = 0;
            y = -200;
          };
          halign = "center";
          valign = "center";
          check_color = "rgb(108, 112, 134)";
          fail_color = "rgb(243, 139, 168)";
          fail_text = "<b>$ATTEMPTS</b>";
          fail_timeout = 2000;
          fail_transition = 300;
        };

        label = [
          {
            monitor = "";
            text = "cmd[update:1000] date +\"%A, %B %d\"";
            color = "rgb(205, 214, 244)";
            font_size = 22;
            font_family = "JetBrains Mono";
            position = {
              x = 0;
              y = 300;
            };
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "cmd[update:1000] date +\"%-I:%M\"";
            color = "rgb(205, 214, 244)";
            font_size = 95;
            font_family = "JetBrains Mono Extrabold";
            position = {
              x = 0;
              y = 200;
            };
            halign = "center";
            valign = "center";
          }
        ];

      };
    };

    waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          position = "top";
          spacing = 0;
          height = 34;
          modules-left = [
            "custom/logo"
            "hyprland/workspaces"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "tray"
            "memory"
            "network"
            "pulseaudio/slider"
            "wireplumber"
            "battery"
            "custom/power"
          ];
          "wlr/taskbar" = {
            format = "{icon}";
            on-click = "activate";
            on-click-right = "fullscreen";
            icon-theme = "WhiteSur";
            icon-size = 25;
            tooltip-format = "{title}";
          };
          "hyprland/workspaces" = {
            on-click = "activate";
            format = "{icon}";
            format-icons = {
              default = "";
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              active = "󱓻";
              urgent = "󱓻";
            };
            persistent-workspaces = {
              "1" = [ ];
              "2" = [ ];
              "3" = [ ];
              "4" = [ ];
              "5" = [ ];
            };
          };
          memory = {
            interval = 5;
            format = "󰍛 {}%";
            max-length = 10;
          };
          tray = {
            spacing = 10;
          };
          clock = {
            tooltip-format = "{calendar}";
            format-alt = "  {:%a, %d %b %Y}";
            format = "  {:%I:%M %p}";
          };
          network = {
            format-wifi = "{icon}";
            format-icons = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            format-ethernet = "󰀂";
            format-alt = "󱛇";
            format-disconnected = "󰖪";
            tooltip-format-wifi = "{icon} {essid}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            tooltip-format-ethernet = "󰀂  {ifname}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            tooltip-format-disconnected = "Disconnected";
            on-click = "~/.config/rofi/wifi/wifi.sh &";
            on-click-right = "~/.config/rofi/wifi/wifinew.sh &";
            interval = 5;
            nospacing = 1;
          };

          "pulseaudio/slider" = {
            format = "{volume}%";
            format-muted = " MUTE";
            step = 5;
            tooltip = true;
          };

          wireplumber = {
            format = "{icon}";
            format-bluetooth = "󰂰";
            nospacing = 1;
            tooltip-format = "Volume : {volume}%";
            format-muted = "󰝟";
            format-icons = {
              headphone = "";
              default = [
                "󰖀"
                "󰕾"
                ""
              ];
            };
            on-click = "pamixer -t";
            scroll-step = 1;
          };
          "custom/logo" = {
            format = "  ";
            tooltip = false;
            on-click = "~/.config/rofi/launchers/misc/launcher.sh &";
          };
          battery = {
            format = "{capacity}% {icon}";
            format-icons = {
              charging = [
                "󰢜"
                "󰂆"
                "󰂇"
                "󰂈"
                "󰢝"
                "󰂉"
                "󰢞"
                "󰂊"
                "󰂋"
                "󰂅"
              ];
              default = [
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
            };
            format-full = "Charged ";
            interval = 5;
            states = {
              warning = 20;
              critical = 10;
            };
            tooltip = false;
          };
          "custom/power" = {
            format = "󰤆";
            tooltip = false;
            on-click = "~/.config/rofi/powermenu/type-2/powermenu.sh &";
          };
        }
      ];

      style = builtins.readFile "${./fancy.css}"; # --- choose .css theme file
    };
  };
}
