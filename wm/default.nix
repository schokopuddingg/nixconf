{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./waybar/config.nix
  ];
}
