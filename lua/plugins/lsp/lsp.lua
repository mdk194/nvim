local nvim_lsp = require("lspconfig")
local utils = require("plugins.lsp.utils")
local languages = require("plugins.lsp.languages")

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

local servers = {
  "bashls",
  "clangd",
  "jsonls",
  "yamlls",
  "lua_ls",
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = function(client, bufnr)
      utils.custom_lsp_attach(client, bufnr)
    end,
    before_init = function(_, _) end,
    flags = { debounce_text_changes = 150 },
    settings = {
      Lua = languages.lua,
      json = languages.json,
      redhat = { telemetry = { enabled = false } },
      yaml = languages.yaml,
    },
  })
end

nvim_lsp.pylsp.setup({
  on_attach = function(client, bufnr)
    utils.custom_lsp_attach(client, bufnr)
  end,
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
  on_attach = function(client, bufnr)
    utils.custom_lsp_attach(client, bufnr)
  end,
  filetypes = { "go", "gomod", "gotmpl" },
  message_level = vim.lsp.protocol.MessageType.Error,
  flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
  settings = {
    gopls = {
      codelenses = {
        tidy = true,
        upgrade_dependency = true,
        generate = false,
        gc_details = false,
        test = false,
        vendor = false,
      },
    },
  },
})

nvim_lsp.graphql.setup({
  on_attach = function(client, bufnr)
    utils.custom_lsp_attach(client, bufnr)
  end,
  filetypes = { "graphql", "javascript", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact" },
})

