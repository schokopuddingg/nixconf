{
  config,
  pkgs,
  lib,
  ...
}:

let
  css = ./style.css;
in

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
          position = "top";
          autohide = true;
          autohide-blocked = false;
          exclusive = true;
          passthrough = false;
          gtk-layer-shell = true;

          modules-left = [
            "clock"
            "cpu"
            "memory"
            "disk"
            "temperature"
          ];

          modules-center = [
            "sway/workspaces"
          ];

          modules-right = [
            "wlr/taskbar"
            "idle_inhibitor"
            "pulseaudio/slider"
            "pulseaudio"
            "network"
            "battery"
          ];

          clock = {
            timezone = "Europe/Berlin";
            format = "{:%I:%M  %d.%m.%y}";
            tooltip-format = "{calendar}";
            calendar.mode = "month";
          };

          cpu = {
            format = "{usage}% ";
            tooltip = true;
            tooltip-format = "CPU usage: {usage}%\nCores: {cores}";
          };

          memory = {
            format = "{}% 󰍛";
            tooltip = true;
            tooltip-format = "RAM used: {used} / {total} ({percentage}%)";
          };

          disk = {
            format = "{percentage_free}% ";
            tooltip = true;
            tooltip-format = "Free space: {free} / {total} ({percentage_free}%)";
          };

          temperature = {
            format = "{temperatureC}°C {icon}";
            tooltip = true;
            tooltip-format = "Current temperature: {temperatureC}°C\nCritical temperature > 80°C";
            format-icons = [ "" ];
          };

          workspaces = {
            format = "{icon}";
            format-icons = {
              default = "";
              active = "";
            };
            disable-scroll = true;
            all-outputs = true;
            show-special = true;
          };

          taskbar = {
            format = "{icon}";
            all-outputs = true;
            active-first = true;
            tooltip-format = "{name}";
            on-click = "activate";
            on-click-middle = "close";
            ignore-list = [ "rofi" ];
          };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };

          "pulseaudio/slider" = {
            format = "{volume}%";
            format-muted = " MUTE";
            step = 5;
            tooltip = false;
          };

          battery = {
            bat = "BAT0";
            format = "{capacity}% ";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            interval = 10;
          };

          pulseaudio = {
            format = "{volume}% {icon}";
            format-muted = " {format_source}";
            format-icons.default = [
              ""
              ""
            ];
          };

          network = {
            format = "{ifname}";
            format-ethernet = "{ifname} 󰈀";
            format-disconnected = " ";
            tooltip-format = " {ifname} via {gwaddr}";
            tooltip-format-ethernet = " {ifname} {ipaddr}/{cidr}";
            tooltip-format-disconnected = "Disconnected";
            max-length = 50;
          };
        }
      ];

      style = builtins.readFile "${./waybar.css}";
    };
  };
}