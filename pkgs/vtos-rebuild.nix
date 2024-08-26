{ pkgs, ... }:
pkgs.writeShellScriptBin "vtos-rebuild" ''
  sudo nixos-rebuild switch --flake .
''
