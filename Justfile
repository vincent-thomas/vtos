rebuild:
    sudo nixos-rebuild switch --flake .

mb-rebuild:
    sudo darwin-rebuild switch --flake . --show-trace

apply:
    kustomize build manifests | kubectl apply --prune --all -f -

edit-secret:
    SOPS_AGE_KEY=$(sudo cat /etc/ssh/ssh_host_ed25519_key | ssh-to-age -private-key) sops secrets.yaml

update-public-keys:
    SOPS_AGE_KEY=$(sudo cat /etc/ssh/ssh_host_ed25519_key | ssh-to-age -private-key) sops updatekeys secrets.yaml
