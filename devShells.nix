{ inputs, system, pkgs }: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    packages = [
      inputs.agenix.packages.${system}.default
      pkgs.age
      pkgs.statix
      pkgs.vt-nvim
      # My shortcut
      pkgs.vtos-rebuild
    ];
  };
}
