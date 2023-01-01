-- nvim --headless "+Lazy! sync" +qa
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

vim.g.mapleader = ","
vim.g.maplocalleader = ","

require('globals')
require('settings')
require('mappings')
require('autocmd')

require("lazy").setup("plugins", {
  -- defaults = { lazy = true },
  install = {
    missing = true, -- install missing plugins on startup, doesn't increase startup time
  },
  change_detection = {
    enabled = false, -- automatically check for config file changes and reload the ui
    notify = true, -- get a notification when changes are found
  },
  debug = false,
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "⚡",
      ft = "ft",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

