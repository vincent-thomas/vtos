let
  # Hosts
  vt-pc =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINEuTOYOZwE/eXMAiDVLyTYJ8njbE8/1PdcFtP+H9eJI";
  vt-skol-laptop =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPiKky4l/cRjmi6InvjTQkZYHPOwE4XOFNf7GJecwSzc";
  vt-laptop =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJWEvtG8UCEcFYcYsl47AhSZvghpzJKDGPrPztxh0dFA";
in {
  "tailscale-auth-key.age".publicKeys = [ vt-pc vt-skol-laptop vt-laptop ];
  "vt-password.age".publicKeys = [ vt-pc vt-skol-laptop vt-laptop ];
}
