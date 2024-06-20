local M = {
  "rcarriga/nvim-notify",
  version = "*",
}

function M.config()
  local notify = require("notify")
  notify.setup({
      timeout = 1500,
      render = "minimal",
      stages = "static",
  })
  -- prepend filename to msg
  vim.notify = function(msg, level, opts)
    msg = vim.trim(msg)
    if msg ~= "" then
      local filename = vim.trim(vim.fn.expand("%:t"))

      if filename ~= "" then
        filename = filename .. ": "
      end

      msg = " " .. filename .. msg
      notify(msg, level, opts)
    end
  end
end

return M
