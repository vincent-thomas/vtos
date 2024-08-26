local conform = require("conform")
--
-- conform.setup({
--   formatters_by_ft = {
--     lua = { "stylua" },
--     -- You can customize some of the format options for the filetype (:help conform.format)
--     rust = { "rustfmt" },
--     -- Conform will run the first available formatter
--     javascript = { "prettierd", "prettier", stop_after_first = true },
--
--     nix = { "nixfmt" },
--   },
-- })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    conform.format({ bufnr = args.buf })
  end,
})
