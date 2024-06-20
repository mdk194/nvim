-- file size < 512KiB
-- use as cond to disable plugins like lsp, null-ls, treesitter
function IS_SMALL_FILE()
  local fsize = vim.fn.getfsize(vim.fn.expand("%:p:f"))
  if fsize > 512 * 1024 then
    return false
  end

  return true
end

-- setup lazy -----------------------------------------------------------------------
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

vim.cmd('packadd cfilter')
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require('settings')
require('mappings')
require('autocmd')
require('statusline')

-- load plugins -----------------------------------------------------------------------
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
})

