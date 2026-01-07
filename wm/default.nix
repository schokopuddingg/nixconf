{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./waybar/fancy.nix # depending on prefered theme
  ];
}
