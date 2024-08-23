return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("vt.config.treesitter").setup()
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("vt.config.fidget").setup()
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("vt.config.fzf").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("vt.config.lspconfig").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("vt.config.lualine").setup()
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/VT/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("vt.config.obsidian").setup()
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        columns = {
          "icon",
        },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["gs"] = "actions.change_sort",
          ["t"] = "actions.open_external",
          ["."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
        preview_split = "left",
        filters = {
          dotfiles = false,
        },
      })
      vim.keymap.set("n", "-", "<cmd>Oil<cr>")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
      })
      vim.cmd("colorscheme catppuccin")
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      padding = true,
      toggler = {
        line = "gl",
        block = "gb",
      },
    },
    lazy = false,
  },

  -- Copilot cmp injenction
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      require("vt.config.cmp").setup()
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("vt.config.conform").setup()
    end,
  },
}
