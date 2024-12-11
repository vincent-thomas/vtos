repo:
{ config, ... }:
let
  name = "runner-${config.networking.hostName}";
in
{
  services.github-runners."${name}" = {
    inherit name;
    enable = true;
    tokenFile = config.age.secrets.gha-runner1-key.path;
    url = "https://github.com/vincent-thomas/${repo}";
  };
}
