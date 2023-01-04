local M = {
  "neovim/nvim-lspconfig",
  event = 'VeryLazy',
  cond = IS_SMALL_FILE,
}

function M.config()
  require("plugins.lsp.lsp")
end

return M
