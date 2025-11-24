{
  config,
  pkgs,
  userName,
  spicetify-nix,
  inputs,
  ...
}:
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    inputs.niri.homeModules.niri
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./shell.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userName;
  home.homeDirectory = "/home/schokopuddingg";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ];
  };

  programs.plasma = {
    enable = true;
    workspace = {
      # set wallpaper
      wallpaper = ./messe-frankfurt-staircase-with-logo.png; # idk what I'm doing wrong but wallpaper somehow not working qwq
    };
  };

  programs = {

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

          # MODULE CONFIGS

          clock = {
            timezone = "Europe/Berlin";
            format = "{:%I:%M  %d.%m.%y}";
            tooltip-format = "{calendar}";
            calendar.mode = "month";
          };

          cpu = {
            format = "{usage}% ";
            tooltip = true;
            tooltip-format = "CPU usage: {usage}%\Cores: {cores}";
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

      # Optional: eigenes CSS
      style = ''
                /* -- Global rules -- */
        * {
          border: none;
          font-family: "JetbrainsMono Nerd Font";
          font-size: 15px;
          min-height: 10px;
        }

        window#waybar {
          background: rgba(34, 36, 54, 0.6);
        }

        window#waybar.hidden {
          opacity: 0.2;
        }

        /* - Genera rules for visible modules -- */
        #custom-archicon,
        #clock,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #idle_inhibitor,
        #pulseaudio,
        #pulseaudio-slider,
        #network,
        #battery,
        #language {
          color: #161320;
          margin-top: 6px;
          margin-bottom: 6px;
          padding-left: 10px;
          padding-right: 10px;
          transition: none;
        }

        /* Separation to the left */
        #custom-archicon,
        #cpu,
        #idle_inhibitor {
          margin-left: 5px;
          border-top-left-radius: 10px;
          border-bottom-left-radius: 10px;
        }

        /* Separation to the rigth */
        #clock,
        #temperature,
        #language {
          margin-right: 5px;
          border-top-right-radius: 10px;
          border-bottom-right-radius: 10px;
        }

        /* -- Specific styles -- */

        /* Modules left */
        #custom-archicon {
          font-size: 20px;
          color: #89B4FA;
          background: #161320;
          padding-right: 17px;
        }

        #clock {
          background: #ABE9B3;
        }

        #cpu {
          background: #96CDFB;
        }

        #memory {
          background: #DDB6F2;
        }

        #disk {
          background: #F5C2E7;
        }

        #temperature {
          background: #F8BD96;
        }

        /* Modules center */
        #workspaces {
          background: rgba(0, 0, 0, 0.5);
          border-radius: 10px;
          margin: 6px 5px;
          padding: 0px 6px;
        }

        #workspaces button {
          color: #B5E8E0;
          background: transparent;
          padding: 4px 4px;
          transition: color 0.3s ease, text-shadow 0.3s ease, transform 0.3s ease;
        }

        #workspaces button.occupied {
          color: #A6E3A1;
        }

        #workspaces button.active {
          color: #89B4FA;
          text-shadow: 0 0 4px #ABE9B3;
        }

        #workspaces button:hover {
          color: #89B4FA;
        }

        #workspaces button.active:hover {}

        /* Modules right */
        #taskbar {
          background: transparent;
          border-radius: 10px;
          padding: 0px 5px;
          margin: 6px 5px;
        }

        #taskbar button {
          padding: 0px 5px;
          margin: 0px 3px;
          border-radius: 6px;
          transition: background 0.3s ease;
        }

        #taskbar button.active {
          background: rgba(34, 36, 54, 0.5);
        }

        #taskbar button:hover {
          background: rgba(34, 36, 54, 0.5);
        }

        #idle_inhibitor {
          background: #B5E8E0;
          padding-right: 15px;
        }

        #pulseaudio {
          min-width: 55px;
          color: #1A1826;
          background: #F5E0DC;
        }

        #pulseaudio-slider {
          color: #1A1826;
          background: #E8A2AF;
          min-width: 50px;
        }

        #pulseaudio-slider slider {}


        #network {
          background: #CBA6F7;
          padding-right: 13px;
        }

        #battery {
          background: #85ff85;
        }

        #battery.critical {
           background: #ff5555;
            font-weight: bold;
        }

        #language {
          background: #A6E3A1;
          padding-right: 15px;
        }

        /* === Optional animation === */
        @keyframes blink {
          to {
            background-color: #BF616A;
            color: #B5E8E0;
          }
        }
      '';
    };

    niri = {
      enable = true;
    };

    git = {
      enable = true;
      userEmail = "niklas@schokopuddingg.de";
      userName = "Schokopuddingg";
      extraConfig = {
        push = {
          autoSetupRemote = true;
        };
        init.defaultBranch = "main";
      };
    };

    starship = {
      enable = true;
      settings = {
        directory = {
          truncate_to_repo = false;
        };
        nix_shell = {
          format = "[$symbol]($style) ";
        };
        sudo = {
          disabled = false;
        };
      };
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd"
        "cd"
      ];
    };

    eza = {
      enable = true;
      icons = "auto";
      git = true;
    };

    spicetify =
      let
        spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        theme = spicePkgs.themes.catppuccin;
      };

  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/schokopuddingg/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Aliases for nixswitch and homeswitch for easy config update
  home.shellAliases = {
    nixswitch = "nixos-rebuild switch --flake ~/nixconf --use-remote-sudo";
    homeswitch = "home-manager switch --flake ~/nixconf";
    allswitch = "nix run . -- switch --flake .";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
