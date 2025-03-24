{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    git-lfs
  ];

  # For some reason nixos puts the config under ~/.config/git/config??
  programs.git = {
    enable = true;
    userName = "Vincent Thomas";
    aliases = {
      st = "status";
      cm = "commit -m";
      a = "add";
      l = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      c = "checkout $(git branch --format='%(refname:short)' | fzf)";
    };

    extraConfig = {
      init.defaultBranch = "main";
      core.askpass = ""; # Disable git credential manager
      gpg.format = "ssh";
      commit.gpgsign = true;
      user = {
        email = "77443389+vincent-thomas@users.noreply.github.com";
        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK2TanW6Iiz6qrI+BV8P3KGAfS+w/eKHBoOUiPyBFSal";
      };
      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };
    };
  };
}
