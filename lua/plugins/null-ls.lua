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
end

return M
