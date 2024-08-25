# Hosts
- __vt-pc__: NixOS Workstation (Ryzen 5800x, 32GB 3200MHz RAM, 512GB M.2, 2080 TI).
- __vt-laptop__: School laptop WSL because locked bootloader (i5 1135G7, 16 GB 3200MHz RAM, 256GB SSD, MX450)

## How to add new host
1. `hosts/`
  1. Add new folder and which is named after the hostname following this schema.
    - NixOS configuration: `default.nix`
    - Home manager configuration: `home.nix`
    - Hardware configuration: `hardware.nix`
  1. Add entry using in `./default.nix` with hostname as key and with helper function `mkSystem`
