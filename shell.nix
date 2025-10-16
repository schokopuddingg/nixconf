{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.bpletza.workstation.shell = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf config.bpletza.workstation.shell {

    programs.fish = {
      enable = true; 
    };

    programs.zsh = {
      enable = true;
      initContent = ''
        ${pkgs.neofetch}/bin/neofetch
      '';
      plugins = [
        {
          name = "nix-zsh-completions";
          src = "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
        }
        {
          name = "fast-syntax-highlighting";
          inherit (pkgs.zsh-fast-syntax-highlighting) src;
        }
      ];
    };

    programs.bash = {
      enable = true;
      historyFileSize = 1000000;
      historyIgnore = [ "exit" ];
    };

    programs.zoxide.enable = true;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      config.warn_timeout = "1m";
    };

    programs.starship = {
      enable = true;
      settings =
        lib.attrsets.recursiveUpdate
          (builtins.fromTOML (builtins.readFile ./static/shell-presets/pastel-powerline.toml))
          {
            /*
                    command_timeout = 2000;
                    status.disabled = false;
                    username = {
                      disabled = false;carapace
                      style_user = "bold cyan";
                      format = "[$user]($style)[@](white bold)";
                      show_always = true;
                    };
                    hostname = {
                      disabled = false;
                      style = "bold blue";
                      format = "[$ssh_symbol$hostname]($style) ";
                      ssh_symbol = "󰣀";
                      ssh_only = false;
                    };
                    directory = {
                      disabled = false;
                      truncation_length = 23;
                      truncation_symbol = "…/";
                    };
                    direnv = {
                      disabled = false;
                      format = "[$symbol$loaded$allowed]($style) ";
                      symbol = "󰚝 ";
                      loaded_msg = "";
                      unloaded_msg = " ";
                      allowed_msg = "";
                      not_allowed_msg = "󰌾";
                      denied_msg = "󰌾";
                    };
                    nix_shell = {
                      disabled = false;
                      format = "[$symbol$state(\($name\))]($style) ";
                      symbol = " ";
                      impure_msg = "*";
                      pure_msg = "";
                      unknown_msg = "?";
                    };
                    shell.disabled = false;
                    battery.disabled = false;
                    git_branch = {
                      disabled = false;
                      symbol = " ";
                      format = "[$symbol$branch(:$remote_branch)]($style) ";
                    };
                    git_commit = {
                      disabled = false;
                      tag_disabled = false;
                    };
                    package.disabled = true;
                    aws.disabled = true;
                    azure.disabled = true;
                    gcloud.disabled = true;
                    vcsh.disabled = true;
            */
          };

    };

    programs.atuin = {
      enable = true;
      daemon.enable = true;
      settings = {
        update_check = false;
        style = "compact";
        show_tabs = false;
        inline_height_shell_up_key_binding = 5;
        serch_mode = "skim";
        filter_mode_shell_up_key_binding = "session";
        stats.common_prefix = [
          "sudo"
          "run0"
          ","
        ];
        auto_sync = false;
        sync.records = true;
      };
    };

    programs.carapace = {
      enable = true;
    };
    home.sessionVariables = {
      CARAPACE_EXCLUDES = "nix-build,nix-channel,nix-instantiate,nix-shell,nix,nixos-rebuild,man";
    };
  };
}
