local nvim_lsp = require("lspconfig")
local utils = require("plugins.lsp.utils")
local languages = require("plugins.lsp.languages")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autoclompletion via nvim-cmp
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    signs = true,
    virtual_text = false,
    update_in_insert = false,
  }
)

local servers = {
  "bashls",
  "jsonls",
  "pyright",
  "tsserver",
  "yamlls",
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = function(client, bufnr)
      utils.custom_lsp_attach(client, bufnr)
    end,
    before_init = function(_, config)
      if lsp == "pyright" then
        config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
      end
    end,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = {
      json = languages.json,
      redhat = { telemetry = { enabled = false } },
      yaml = languages.yaml,
    },
  })
end

nvim_lsp.gopls.setup {
    on_attach = function(client, bufnr)
      utils.custom_lsp_attach(client, bufnr)
    end,
    capabilities = capabilities,
    filetypes = { 'go', 'gomod', 'gotmpl' },
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
}

nvim_lsp.tsserver.setup {
    on_attach = function(client, bufnr)
      utils.custom_lsp_attach(client, bufnr)
    end,
    capabilities = capabilities,
    filetypes = {"javascript", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact"},
    cmd = {"typescript-language-server", "--stdio"},
}
