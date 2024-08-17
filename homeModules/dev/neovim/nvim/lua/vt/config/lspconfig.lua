local lspconfig = require("lspconfig")
local nvim_cmp_nvim_lsp = require("cmp_nvim_lsp")

local function keybinds(ev)
  local opts = { buffer = ev.buf, silent = true }
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
  -- 'K' finns redan
  -- vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
end

local M = {}

function M.setup()
  local capabilities = nvim_cmp_nvim_lsp.default_capabilities()

  lspconfig.tsserver.setup({
    capabilities,
  })

  lspconfig.dockerls.setup({
    capabilities,
  })

  lspconfig.pyright.setup({
    capabilities,
  })

  lspconfig.nixd.setup({
    capabilities,
  })

  lspconfig.lua_ls.setup({
    capabilities,
    settings = {
      Lua = {
        -- make the language server recognize "vim" global
        diagnostics = {
          globals = { "vim" },
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
  lspconfig.rust_analyzer.setup({
    capabilities,
    settings = {
      ["rust-analyzer"] = {
        check = {
          command = "clippy",
        },
      },
    },
  })

  lspconfig.marksman.setup({ capabilities })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = keybinds,
  })
end

return M
