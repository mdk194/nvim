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
  require('lspconfig').jdtls.setup({
    handlers = {
      -- By assigning an empty function, you can remove the notifications
      -- printed to the cmd
      ["$/progress"] = function(_, result, ctx) end,
      ['language/status'] = function() end,
    },
  })
end

return M
