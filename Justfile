rebuild:
  sudo nixos-rebuild switch --flake .
apply:
  kubectl apply -k ./infra/manifests
