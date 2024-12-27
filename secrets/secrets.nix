let
  # Hosts
  vt-pc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINEuTOYOZwE/eXMAiDVLyTYJ8njbE8/1PdcFtP+H9eJI";

in
{
  "k3s-test-cluster.age".publicKeys = [ vt-pc ];

  "gha-runner1-key.age".publicKeys = [ vt-pc ];
}
