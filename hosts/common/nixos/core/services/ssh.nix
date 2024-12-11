{
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      HostKeyAlgorithms = "+ecdsa-sha2-nistp256,ssh-ed25519";
    };
  };
}
