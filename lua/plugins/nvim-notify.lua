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

  -- override global print to notify
  _G.print = function(...)
    local print_safe_args = {}
    local _ = {...}
    for i=1, #_ do
        table.insert(print_safe_args, tostring(_[i]))
    end
    local message = table.concat(print_safe_args, ' ')
    vim.notify(message, vim.log.levels.INFO)
  end
end

return M
