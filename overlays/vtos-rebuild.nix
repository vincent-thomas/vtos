{ outputs, ... }:
final: _prev: {
  vtos-rebuild = outputs.packages.${final.system}.vtos-rebuild;
}

