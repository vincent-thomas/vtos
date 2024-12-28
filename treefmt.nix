{
  projectRootFile = "flake.nix";

  settings.global.excludes = [
    ".direnv"
    ".git"
  ];

  # Nix
  programs.nixfmt.enable = true;
  # YAML
  programs.yamlfmt.enable = true;
  # MD
  programs.mdformat.enable = true;
  # Justfile
  programs.just.enable = true;
}
