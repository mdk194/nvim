local M = {
  "j-hui/fidget.nvim",
  tag = 'v1.4.5',
  event = 'LspAttach',
}

function M.config()
  local fidget = require("fidget")
  fidget.setup({
    progress = {
      suppress_on_insert = false,   -- Suppress new messages while in insert mode
      ignore_done_already = true,  -- Ignore new tasks that are already complete
      ignore_empty_message = true, -- Ignore new tasks that don't contain a message
    },
    notification = {
      filter = vim.log.levels.INFO,
      history_size = 32,             -- Number of removed messages to retain in history
      override_vim_notify = false,   -- Automatically override vim.notify() with Fidget
      window = {
        align = 'bottom',
        relative = 'win',
      }
    },
    integration = {
      ["nvim-tree"] = {
        enable = false,
      },
      ["xcodebuild-nvim"] = {
        enable = false,
      },
    }
  })

end

return M
