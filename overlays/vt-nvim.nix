{ outputs, ... }:
final: _prev: {
  vt-nvim = outputs.packages.${final.system}.vt-nvim;
}

