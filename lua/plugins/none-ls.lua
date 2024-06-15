local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  ft = { "go" }
}

function M.config()
  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      null_ls.builtins.code_actions.gomodifytags,
      null_ls.builtins.code_actions.impl,
      null_ls.builtins.diagnostics.staticcheck,
      -- null_ls.builtins.diagnostics.golangci_lint,
    },
  })
end

return M
