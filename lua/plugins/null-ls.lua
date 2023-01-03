local M = {
  'jose-elias-alvarez/null-ls.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/prettier.nvim',
  },
}

function M.config()
  require('plugins.lsp.null-ls')
  vim.cmd([[ command! DisableNullLs execute 'lua require("null-ls").disable({})' ]])
  vim.cmd([[ command! EnableNullLs execute 'lua require("null-ls").enable({})' ]])
end

return M
