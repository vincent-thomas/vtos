{ inputs, system, pkgs, ... }:
let nixvim = inputs.nixvim.legacyPackages.${system};
in nixvim.makeNixvimWithModule {
  inherit pkgs;
  extraSpecialArgs = { inherit inputs; };
  module = ./config;
}

