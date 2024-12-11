let
  # Hosts
  vt-pc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINEuTOYOZwE/eXMAiDVLyTYJ8njbE8/1PdcFtP+H9eJI";
  vt-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEuvk4QTCcHSsNmUL5wqmWQ9yLwPN/R0Dc9G5YWSWex";
  vt-skol-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH19aYJ/sPJBeemeCwq3Xz0FfH9X2YyAxMInYwIKzf5I";

  homelab-k3s-master-01 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIabDDV+gsXjqT653qeoHkTDcRsXcwv1hu4S//3II3Fh";

in
{
  "vt-password.age".publicKeys = [
    vt-pc
    vt-skol-laptop
    vt-laptop
    homelab-k3s-master-01
  ];

  "k3s-test-cluster.age".publicKeys = [ vt-pc ];

  "gha-runner1-key.age".publicKeys = [ vt-pc ];
}
