return {
  filetypes = { "go", "gomod" },
  message_level = vim.lsp.protocol.MessageType.Error,
  flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
  settings = {
    gopls = {
      hints = {
        rangeVariableTypes = true,
        parameterNames = true,
        constantValues = true,
        assignVariableTypes = false,
        compositeLiteralFields = true,
        compositeLiteralTypes = false,
        functionTypeParameters = true,
      },
      codelenses = {
        tidy = true,
        upgrade_dependency = true,
        generate = true,
        gc_details = true,
        test = true,
        vendor = false,
        regenerate_cgo = true,
        run_govulncheck = false,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules", "-.nvim" },
      semanticTokens = true,
    },
  },
}
