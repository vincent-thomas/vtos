rebuild:
  sudo nixos-rebuild switch --flake .
apply:
  kustomize build infra/manifests --enable-helm | kubectl apply --prune --all -f -
