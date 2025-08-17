{ pkgs, ... }:
{
  #used to find the project root
  projectRootFile = "flake.nix";

  programs = {
    nixfmt-rfc-style.enable = true;
    jsonfmt.enable = true;
    yamlfmt.enable = true;
    mdformat.enable = true;
    shfmt.enable = true;
  };
}
