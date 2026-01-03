local M = {
  "olimorris/codecompanion.nvim",
  lazy = false,
  cmd = { "CodeCompanionChat", "CodeCompanionActions" },
  keys = {
    { '<leader>i', [[<cmd>lua require('codecompanion').chat()<CR>]] },
    { '<leader>a', [[<cmd>lua require('codecompanion').actions()<CR>]] },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  }
}

function M.config()
  require("codecompanion").setup({
    display = {
      chat = {
        intro_message = "✨! Press ? for options",
        icons = {
          chat_context = "📎️", -- You can also apply an icon to the fold
          chat_fold = " ",
        },
        auto_scroll = false,
        fold_context = true,
        fold_reasoning = true,
        show_settings = false,
      },
      inline = {
        layout = "vertical", -- vertical|horizontal|buffer
      },
    },
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
        keymaps = {
          accept_change = {
            modes = { n = "ga" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "gr" },
            opts = { nowait = true },
            description = "Reject the suggested change",
          },
        },
      },
    },
    adapters = {
      http = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-sonnet-4",
                -- default = "gemini-2.5-pro",
              },
            },
          })
        end,
      },
    },
  })

  local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", { clear = true })
  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanion*",
    group = group,
    callback = function(request)
      if request.match == "CodeCompanionChatSubmitted" then
        return
      end

      local msg

      -- msg = "[CodeCompanion] " .. request.match:gsub("CodeCompanion", "")
      msg = request.match:gsub("CodeCompanion", "")

      if msg == "ContextChanged" then
        return
      end

      vim.notify(msg, "info", {
        timeout = 1000,
        keep = function()
          return vim.iter({ "InlineStarted" }):fold(
            false,
            function(acc, cond)
              return acc or vim.endswith(request.match, cond)
            end)
        end,
        id = "code_companion_status",
        title = "CodeCompanion",
        opts = function(notif)
          notif.icon = ""
          if vim.endswith(request.match, "Started") then
            ---@diagnostic disable-next-line: undefined-field
            notif.icon = spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          elseif vim.endswith(request.match, "Finished") then
            notif.icon = " "
          end
        end,
      })
    end,
  })

  -- Expand 'cc' into 'CodeCompanion' in the command line
  vim.cmd([[cab cc CodeCompanion]])
end

return M

