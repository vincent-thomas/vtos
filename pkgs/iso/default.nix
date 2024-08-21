{ inputs, system, pkgs, outputs, ... }:

inputs.nixos-generators.nixosGenerate {
  system = system;
  specialArgs = {
    inherit pkgs;
    diskSize = 20 * 1024;
  };

  modules = [
    # Pin nixpkgs to the flake input, so that the packages installed
    # come from the flake inputs.nixpkgs.url.
    ({ ... }: { nix.registry.nixpkgs.flake = inputs.nixpkgs; })
    { nixpkgs.hostPlatform = system; }
    inputs.agenix.nixosModules.default
    outputs.nixosModules.default
    ./configuration.nix
  ];

  format = "iso";
}
