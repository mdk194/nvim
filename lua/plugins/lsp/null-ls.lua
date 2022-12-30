local nls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

nls.setup({
  sources = {
    nls.builtins.diagnostics.eslint_d,
    nls.builtins.formatting.prettier.with({
      extra_args = { "--single-quote", "false" },
    }),
    nls.builtins.formatting.goimports,
    nls.builtins.formatting.gofumpt,
    nls.builtins.code_actions.shellcheck,
    nls.builtins.diagnostics.vale,
    -- nls.builtins.diagnostics.commitlint,
    -- nls.builtins.diagnostics.golangci_lint,
    -- nls.builtins.diagnostics.ktlint,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = true })
        end,
      })
    end
  end,
})
