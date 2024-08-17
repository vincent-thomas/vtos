local config = {
  ensure_installed = {
    "typescript",
    "javascript",
    "rust",
    "lua",
    "json",
    "toml",
    "markdown",
    "nix"
  },
  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false,
    enable_autocmd = false,
  },
  sync_install = false,
  indent = { enable = false },
}

local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup(config)
end

return M
