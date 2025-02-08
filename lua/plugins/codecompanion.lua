local M = {
  "olimorris/codecompanion.nvim",
  cmd = { "CodeCompanionChat", "CodeCompanionActions" },
  keys = {
    { '<leader>i', [[<cmd>lua require('codecompanion').chat()<CR>]] },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  }
}

function M.config()
  require("codecompanion").setup({
    strategies = {
      chat = {
        adapter = "copilot",
        slash_commands = {
          ["file"] = {
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
          ["symbols"] = {
            opts = {
              provider = "snacks",
            },
          },
          ["buffer"] = {
            opts = {
              provider = "snacks",
            },
          },
          ["help"] = {
            opts = {
              provider = "snacks",
            },
          },
        },
      },
      inline = {
        adapter = "copilot",
      },
    },
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "claude-3.5-sonnet",
            },
          },
        })
      end,
    },
  })
end

return M

