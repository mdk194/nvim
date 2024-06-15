vim.g.rustaceanvim = {
  tools = {
    inlay_hints = {
      show_parameter_hints = true,
      -- default: "=>"
      other_hints_prefix = "=> ",
      -- default: "<-"
      parameter_hints_prefix = "",
    },
  },
  server = {
    on_attach = function(client, bufnr)
      require("plugins.lsp.utils").custom_lsp_attach(client, bufnr)
    end,
    default_settings = {
      ['rust-analyzer'] = {
        inlayHints = { locationLinks = false },
        checkOnSave = {
          command = "clippy",
        }
      },
    },
  },
  dap = {
  },
}

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<space>a",
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr }
)
