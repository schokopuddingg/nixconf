# NixOS config for Schokopuddingg's Tuxedo laptop

{
  config,
  pkgs,
  hostName,
  ...
}:

{
  # Imports
  imports = [
    ./hardware-configuration.nix
  ];

  # Nix Settings
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Hardware
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true; # Show battery charge of Bluetooth devices
      };
    };
  };
  
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = hostName;
  networking.networkmanager.enable = true;

  # Localization
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Graphical Interface
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Console Key Map
  console.keyMap = "de";

  # Services
  services.udisks2.enable = true;
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User Config & Packages
  users.users.schokopuddingg = {
    isNormalUser = true;
    description = "Schokopuddingg";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
      discord
      telegram-desktop
      element-desktop
      btop
      bitwarden-desktop
      vscode
      rawtherapee
      darktable
      pix
      vlc
      alacritty
      ferdium
      steam
      flameshot
      cpu-x
      gajim
      putty
      ncspot
    ];
    shell = pkgs.fish;
  };

  # Programs
  programs.fish.enable = true;
  programs.firefox.enable = true;
  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono
  ];

  # OBS v4l2loopback for virtual camera
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" "udf" "iso9660" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  # Unfree Packages
  nixpkgs.config.allowUnfree = true;

  # Package Overrides
  nixpkgs.config.packageOverrides = pkgs: {
    # 32-Bit support for steam
    steam = pkgs.steam.override {
      extraPkgs = p: [ pkgs.xorg.libxcb ];
    };
  };

  # X Server & Window Manager
  services.xserver = {
    enable = true;
    xkb = {
      layout = "de";
      variant = "";
    };
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
        luadbi-mysql
        awesome-wm-widgets
      ];
    };
  };

  # System Wide Packages
  environment.systemPackages = with pkgs; [
    git
    
    # support both 32-bit and 64-bit applications
    wineWowPackages.stable

    # support 32-bit only
    wine

    # support 64-bit only
    (wine.override { wineBuild = "wine64"; })

    # support 64-bit only
    wine64

    # wine-staging (version with experimental features)
    wineWowPackages.staging

    # winetricks (all versions)
    winetricks

    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ];

  # Enable SSH daemon
  services.openssh.enable = true;

  # System State
  system.stateVersion = "25.05"; # probably shouldn't change that
}
