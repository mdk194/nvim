local M = {
  'nvim-java/nvim-java',
  ft = 'java',
}

function M.config()
  local functions = require('functions')

  vim.env.JAVA_HOME = vim.env.JAVA_HOME or '/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home'

  require('java').setup({
    jdk = {
      auto_install = true,
    },
  })
  vim.lsp.enable('jdtls')
end

return M
