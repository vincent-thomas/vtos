{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      autoOptimiseStore = true;
    };
  };
}
