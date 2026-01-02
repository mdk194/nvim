local M = {
  'nvim-java/nvim-java',
  ft = 'java',
}

function M.config()
  local functions = require('functions')

  require('java').setup({
    jdk = {
      auto_install = true,
    },
  })
  vim.lsp.enable('jdtls')
end

return M
