{ lib, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Vincent Thomas";
    userEmail = "22414954-vincent_thomas1@users.noreply.gitlab.com";
    aliases = {
      st = "status";
      cm = "commit -m";
      a = "add";
      l =
        "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    };
    extraConfig = {
      init.defaultBranch = "main";
      core.askpass = ""; # Disable git credential manager
      gpg.format = "ssh";
      "gpg \"ssh\"".program =
        "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      commit.gpgsign = true;
    };
  };
}
