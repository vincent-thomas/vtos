{pkgs, ...}: {

  extraPackages = with pkgs; [
    rustfmt
    stylua
    prettierd
    nixfmt
  ];

  plugins.conform-nvim = {
   enable = true;
   notifyOnError = true;
    formattersByFt = {
      lua = [ "stylua" ];
      rust = [ "rustfmt" ];
      nix =  [ "nixfmt" ];
      # Conform will run multiple formatters sequentially
      # python = [ "isort" "black" ];
      # Use a sub-list to run only the first available formatter
      javascript = [ [ "prettierd" "prettier" ] ];
      # Use the "*" filetype to run formatters on all filetypes.
      # "*" = [ "codespell" ];
      # Use the "_" filetype to run formatters on filetypes that don't
      # have other formatters configured.
      # "_" = [ "trim_whitespace" ];
    };
  };
  extraConfigLua = builtins.readFile ./conform.lua;
}
