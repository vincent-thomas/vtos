{ vtLib }:
{ lib, ... }:
{
  imports =
    [
    ]
    ++ lib.lists.forEach (vtLib.listFiles ./wm) (x: ./wm/${x})
    ++ lib.lists.forEach (vtLib.listFiles ./terminals) (x: ./terminals/${x})

    ++ lib.lists.forEach (vtLib.listFiles ./apps) (x: ./apps/${x})
    ++ lib.lists.forEach (vtLib.listFiles ./services) (x: ./services/${x});
}
