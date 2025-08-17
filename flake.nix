# Flake config for Schokopuddingg's Tuxedo laptop

{
  description = "NixOS system config";

  # Flake Inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spicetify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri Window Manager
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Lix Module
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.2-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake Outputs
  outputs =
    {
      nixpkgs,
      flake-utils,
      treefmt-nix,
      home-manager,
      spicetify-nix,
      niri,
      lix-module,
      ...
    }:
    let
      hostName = "tuxedo"; # Hostname
      userName = "schokopuddingg"; # User name
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      # NixOS Configurations
      nixosConfigurations = {
        "${hostName}" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./hardware-configuration.nix
            lix-module.nixosModules.default
          ];
          specialArgs = {
            inherit hostName;
          };
        };
      };

      # Home Manager Configs
      homeConfigurations = {
        "${userName}" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          modules = [
            spicetify-nix.homeManagerModules.default
            niri.homeModules.niri
            ./home.nix
          ];
          extraSpecialArgs = {
            inherit userName spicetify-nix;
          };
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: {
      # Allow installing Home Manager with `nix run . -- switch --flake .`
      packages.default = home-manager.packages.${system}.default;

      # Formatter
      formatter =
        (treefmt-nix.lib.evalModule (import nixpkgs { inherit system; }) ./treefmt.nix)
        .config.build.wrapper;
    });
}
