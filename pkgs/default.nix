{ inputs, system, pkgs, outputs, ... }: {
  vt-nvim = import ./neovim { inherit inputs system pkgs; };
  vt-iso = import ./iso { inherit inputs system pkgs outputs; };

  tmux-sessionizer = import ./tmux-sessionizer { inherit pkgs; };
}
