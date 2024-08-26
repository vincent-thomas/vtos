{ outputs, ... }:
final: _prev: {
  powertools = outputs.packages.${final.system}.powertools;
}

