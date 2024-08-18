{ lib, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    allow-unsafe-native-code-during-evaluation = true;
  };

  # nixpkgs = {
  #   config = {
  #     allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "chrome" ];
  #   };
  # };
}
