# Hosts

## Linux - NixOS

- __vt-pc__: NixOS Workstation (Ryzen 5800x, 32GB 3200MHz RAM, 512GB M.2, 2080 TI).
- __vt-laptop__: Thinkpad (I5-8265U, 8 GB 2400MHz RAM, 256GB SSG)

## MacOS - nix-darwin

- __vt-mbp__: Macbook Pro 14" 2018.

## How to add new host

1. `hosts/(darwin|nixos)`
1. Add new folder and which is named after the hostname following this schema.
   \- nix-darwin configuration: `default.nix`
   \- Home manager configuration: `home.nix`
1. Add entry using in `./default.nix` with hostname as key and with helper function `mkDarwin`
