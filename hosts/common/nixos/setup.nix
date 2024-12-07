{ hostname, ... }:
{
  imports = [
    ./core
  ];

  vt.services.networking.hostname = hostname;
}
