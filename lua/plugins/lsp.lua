local M = {
  "neovim/nvim-lspconfig",
  event = 'VeryLazy',
}

function M.config()
  require("plugins.lsp.lsp")
end

return M
