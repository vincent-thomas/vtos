{ config, ... }: {
  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];
  hardware.nvidia = {
    package = import ./pkg.nix { inherit config; };
    modesetting.enable = true;

    # Don't change this.
    powerManagement.enable = false;

    # Don't run this.
    powerManagement.finegrained = false;

    # This is buggy
    open = false;

    nvidiaSettings = false;
  };

}
