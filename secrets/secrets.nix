let
  # Hosts
  vt-pc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINEuTOYOZwE/eXMAiDVLyTYJ8njbE8/1PdcFtP+H9eJI";
  vt-skol-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH19aYJ/sPJBeemeCwq3Xz0FfH9X2YyAxMInYwIKzf5I";
  vt-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJWEvtG8UCEcFYcYsl47AhSZvghpzJKDGPrPztxh0dFA";

  homelab-k3s-master-01 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIabDDV+gsXjqT653qeoHkTDcRsXcwv1hu4S//3II3Fh";

in
{
  "vt-password.age".publicKeys = [
    vt-pc
    vt-skol-laptop
    vt-laptop
    homelab-k3s-master-01
  ];
}
