local M = {
  'simrat39/rust-tools.nvim',
  ft = 'rust',
  dependencies = {'rust-lang/rust.vim'}
}

function M.config()
  local rust_tools_opts = {
    tools = { -- rust-tools options
      inlay_hints = {
        show_parameter_hints = true,
        -- default: "=>"
        other_hints_prefix = "=> ",
        -- default: "<-"
        parameter_hints_prefix = "",
      },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
      on_attach = function(client, bufnr)
        require('plugins.lsp.utils').custom_lsp_attach(client, bufnr)
      end,
      -- capabilities = capabilities,
      settings = {
        -- to enable rust-analyzer settings visit:
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {
          inlayHints = { locationLinks = false },
          -- enable clippy on save
          checkOnSave = {
            command = "clippy"
          },
        }
      }
    },
  }

  require('rust-tools').setup(rust_tools_opts)
end

return M
