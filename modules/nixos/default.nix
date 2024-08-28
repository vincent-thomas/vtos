{ vtLib }:
{ lib, ... }: {
  imports = [ ./x11.nix ]
    ++ lib.lists.forEach (vtLib.listFiles ./apps) (x: ./apps/${x})
    ++ lib.lists.forEach (vtLib.listFiles ./services) (x: ./services/${x});
}
