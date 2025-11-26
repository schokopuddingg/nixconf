{
  config,
  pkgs,
  lib,
  ...
}:

# let
#   css = ./frutiger.css;
# in

{
  programs = {

    wlogout = {
      enable = true;
    };

    swaylock.package = pkgs.swaylock-effects;

    waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          spacing = 0;
          height = 0;
          margin-top = 0;
          position = "top";
          margin-right = 0;
          margin-bottom = 0;
          margin-left = 0;

          modules-left = [
            "custom/os_btn"
            "sway/workspaces"
            "wlr/taskbar"
          ];

          modules-center = [
            "clock"
          ];

          modules-right = [
            "tray"
            "network"
            "battery"
            "pulseaudio"
          ];

          "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            tooltip = false;
          };

          "wlr/taskbar" = {
            format = "{icon}";
            spacing = 3;
            icon-size = 28;
            on-click = "activate";
            tooltip-format = "{title}";
          };

          tray = {
            spacing = 10;
            tooltip = false;
          };

          clock = {
            format = "{:%H:%M - %a | %d %b %Y}";
            tooltip = false;
          };

          network = {
            format-wifi = "󰤢 {bandwidthDownBits}";
            format-ethernet = "󰤢 {bandwidthDownBits}";
            format-disconnected = "󰤠 No Network";
            interval = 5;
            tooltip = false;
          };

          pulseaudio = {
            scroll-step = 5;
            max-volume = 150;
            format = "{icon} {volume}%";
            format-bluetooth = "{icon} {volume}%";
            format-icons = [
              ""
              ""
              " "
            ];
            nospacing = 1;
            format-muted = " ";
            on-click = "pavucontrol";
            tooltip = false;
          };

          battery = {
            format = "{icon} {capacity}%";
            interval = 5;
            states = {
              warning = 20;
              critical = 10;
            };
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            tooltip = false;
          };
        }
      ];

      style = builtins.readFile "${./frutiger.css}"; # --- choose .css theme file
    };
  };
}
