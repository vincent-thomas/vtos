{ lib, ... }:
lib.genAttrs [
  "x86_64-linux"
  "aarch64-darwin"
]
