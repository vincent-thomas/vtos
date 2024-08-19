local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = require("vt.plugins")

require("lazy").setup({
  plugins,
}, {
  lockfile = "~/nix/modules/home/dev/neovim/nvim/lazy-lock.json",
  checker = {
    enabled = false,
    notify = false,
  },
  change_detection = {
    notify = true,
  },
})
