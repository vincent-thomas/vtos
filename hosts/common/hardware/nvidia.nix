{ config, ... }: {
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
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
