local config = {
  workspaces = {
    {
      name = "VT",
      path = "~/Obsidian/VT",
    },
  },
  daily_notes = {
    folder = "daily",
    date_format = "%Y-%m-%d",
    default_tags = { "daily" },
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
  mappings = {
    ["<leader>d"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
  }
}

local M = {}

function M.setup()
  require("obsidian").setup(config)
end

return M
