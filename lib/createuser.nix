{ pkgs, ... }:

{ username, userGroups, isRoot, shell }: {
  users.users.${username} = {
    isNormalUser = !isRoot;
    extraGroups = userGroups;
    shell = shell;
  };
}
