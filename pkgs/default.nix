{ inputs, system, pkgs, ... }: {
  vt-nvim = import ./neovim { inherit inputs system pkgs; };
}
