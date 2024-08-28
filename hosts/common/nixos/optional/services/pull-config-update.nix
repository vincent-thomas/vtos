{
  services.comin = {
    enable = true;
    remotes = [{
      name = "origin";
      url = "https://gitlab.com/vincent_thomas1/vtos.git";
      branches.main.name = "main";
      branches.testing.name = "";
    }];
  };
}
