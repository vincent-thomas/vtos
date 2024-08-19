local conform = require("conform")

local M = {}

local config = {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    javascript = { "prettierd" },
    nix = { "nixfmt" },
  },
}

function M.setup()
  conform.setup(config)

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      require("conform").format({ bufnr = args.buf })
    end,
  })
end

return M
