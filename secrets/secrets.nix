let
  # Hosts
  vt-pc =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINEuTOYOZwE/eXMAiDVLyTYJ8njbE8/1PdcFtP+H9eJI";
in {
  "tailscale-auth-key.age".publicKeys = [ vt-pc ];
  "vt-password.age".publicKeys = [ vt-pc ];
}
