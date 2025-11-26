{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./waybar/frutiger.nix # depending on prefered theme
  ];
}
