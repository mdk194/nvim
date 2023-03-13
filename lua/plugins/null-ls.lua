local M = {
  'jose-elias-alvarez/null-ls.nvim',
  event = 'VeryLazy',
  cond = IS_SMALL_FILE,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/prettier.nvim',
  },
}

function M.config()
  local nls = require('null-ls')
  nls.setup({
    sources = {
      -- nls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2", "column_width", "300" } }),
      nls.builtins.diagnostics.eslint_d,
      nls.builtins.formatting.prettier.with({
        extra_args = { "--single-quote", "true", "--no-bracket-spacing", "false" },
      }),
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.gofumpt,
      nls.builtins.code_actions.shellcheck,
      nls.builtins.diagnostics.pylint,
      -- nls.builtins.diagnostics.vale,
      -- nls.builtins.diagnostics.commitlint,
      -- nls.builtins.diagnostics.golangci_lint,
      -- nls.builtins.diagnostics.ktlint,
    },
    on_attach = function(client, bufnr)
      require('plugins.lsp.utils').custom_lsp_attach(client, bufnr)
    end,
  })

  vim.cmd([[ command! DisableNullLs execute 'lua require("null-ls").disable({})' ]])
  vim.cmd([[ command! EnableNullLs execute 'lua require("null-ls").enable({})' ]])
end

return M
