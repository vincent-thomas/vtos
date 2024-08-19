{user, ... }:{
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        contrastOpacity = 188;
        savePath = "/home/${user}/Downloads";
      };
    };
  };
}
