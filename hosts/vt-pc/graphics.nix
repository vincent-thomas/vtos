{ pkgs, user, ... }: {

  hardware.graphics.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome
  ];

  users.users.${user}.packages = with pkgs; [
    localsend
    todoist-electron
    discord

    pcmanfm
    networkmanagerapplet
    davinci-resolve
  ];

  vt.apps.onepassword = {
    enable = true;
    username = user;
  };
}
