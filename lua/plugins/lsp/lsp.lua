local nvim_lsp = require("lspconfig")
local languages = require("plugins.lsp.languages")

local capabilities = require('blink.cmp').get_lsp_capabilities({
  textDocument = {
    completion = { completionItem = { snippetSupport = false } }, -- disable all snippets
    -- foldingRange = {
    --   dynamicRegistration = false,
    --   lineFoldingOnly = true,
    -- },
  },
})

local lsp_ui = {
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
  },
  diagnostic = {
    virtual_text = false,
    -- virtual_text = { spacing = 4, prefix = "●" },
    underline = false,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
    },
  },
}

vim.diagnostic.config(lsp_ui.diagnostic)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, lsp_ui.float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, lsp_ui.float)

local showMessage = {
  messageActionItem = {
    additionalPropertiesSupport = true,
  },
}

local servers = {
  "bashls",
  "clangd",
  "jsonls",
  "lua_ls",
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    before_init = function(_, _) end,
    capabilities = capabilities,
    showMessage = showMessage,
    flags = { debounce_text_changes = 150 },
    settings = {
      Lua = languages.lua,
      json = languages.json,
      redhat = { telemetry = { enabled = false } },
    },
  })
end

nvim_lsp.pylsp.setup({
  capabilities = capabilities,
  showMessage = showMessage,
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = false },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = true },
      },
    },
  },
})

nvim_lsp.gopls.setup({
  capabilities = capabilities,
  showMessage = showMessage,
  filetypes = { "go", "gomod", "gotmpl" },
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
})

nvim_lsp.graphql.setup({
  filetypes = { "graphql", "javascript", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact" },
})
