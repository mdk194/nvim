local M = {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  cmd = {
    "MasonToolsInstall",
    "MasonToolsInstallSync",
    "MasonToolsUpdate",
    "MasonToolsUpdateSync",
  },
}

function M.config()
  require("mason-tool-installer").setup({

    -- a list of all tools you want to ensure are installed upon
    -- start; they should be the names Mason uses for each tool
    ensure_installed = {
      -- LSP
      "bash-language-server",
      "clangd",
      -- "dockerfile-language-server",
      "json-lsp",
      "graphql-language-service-cli",
      -- "ltex-ls",
      "lua-language-server",
      -- "terraform-ls",
      -- "yaml-language-server",
      -- { "jdtls", version = "v1.36.0" },
      "jdtls",
      -- Formatter
      "gofumpt",
      "goimports",
      "google-java-format",
      "prettierd",
      "stylua",
      -- Linter
      "eslint_d",
      "shellcheck",
      "vale",
      "yamllint",
      "pylint",
      -- DAP
      "debugpy",
    },

    -- if set to true this will check each tool for updates. If updates
    -- are available the tool will be updated. This setting does not
    -- affect :MasonToolsUpdate or :MasonToolsInstall.
    -- Default: false
    auto_update = false,

    -- automatically install / update on startup. If set to false nothing
    -- will happen on startup. You can use :MasonToolsInstall or
    -- :MasonToolsUpdate to install tools and check for updates.
    -- Default: true
    run_on_start = false,

    -- set a delay (in ms) before the installation starts. This is only
    -- effective if run_on_start is set to true.
    -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
    -- Default: 0
    start_delay = 3000, -- 3 second delay
  })
end

return M
