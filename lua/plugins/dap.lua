local M = {
  "mfussenegger/nvim-dap",
  ft = { "go", "rust", "java", "python" },
  dependencies = {
    "mfussenegger/nvim-dap-python",
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
  },
}

function M.config()
  require("nvim-dap-virtual-text").setup({
    commented = true,
  })

  local dap, dapui = require("dap"), require("dapui")
  dapui.setup({})

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
  end

  require("plugins.dap.python").setup()
  require("plugins.dap.go").setup()

  vim.keymap.set('n', '<F5>', require('dap').continue)
  vim.keymap.set('n', '<F6>', require('dap').toggle_breakpoint)
  vim.keymap.set('n', '<F7>', require('dap').step_over)
  vim.keymap.set('n', '<F8>', require('dap').step_into)
  vim.keymap.set('n', '<F9>', require('dap').step_out)
  -- vim.keymap.set('n', '<leader>db', require('dap').set_breakpoint)
  vim.keymap.set('n', '<leader>dp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
  vim.keymap.set('n', '<leader>dr', require('dap').repl.open)
  vim.keymap.set('n', '<leader>dl', require('dap').run_last)

  vim.keymap.set('n', '<leader>dw', require("dapui").toggle)
end

return M
