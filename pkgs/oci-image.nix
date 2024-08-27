{ pkgs, ... }:
let
  vtosEnv = pkgs.buildEnv {
    name = "vt-env";
    paths = with pkgs; [ coreutils vt-nvim tmux ripgrep fd git yazi ];
    pathsToLink = [ "/bin" ];
  };
in pkgs.dockerTools.buildImage {
  name = "vtos-oci";
  tag = "latest";

  copyToRoot = vtosEnv;

  config.Cmd = [ "${pkgs.zsh}/bin/zsh" ];
}
