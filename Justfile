rebuild:
  sudo nixos-rebuild switch --flake .
apply:
  kustomize build manifests | kubectl apply --prune --all -f -
secret:
  sops secrets.yaml
