{
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    audio.enable = true;
  };

  # Used by pipewire
  security.rtkit.enable = true;
}
