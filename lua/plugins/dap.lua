local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
  },
  keys = {
    { '<F5>', function() require('dap').continue() end },
    { '<F6>', function() require('dap').toggle_breakpoint() end },
    { '<F7>', function() require('dap').step_over() end },
    { '<F8>', function() require('dap').step_into() end },
    { '<F9>', function() require('dap').step_out() end },
    { '<leader>dp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end },
    { '<leader>dr', function() require('dap').repl.open() end },
    { '<leader>dl', function() require('dap').run_last() end },
    { '<leader>dw', function() require('dapui').toggle() end },
  }
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
end

return M
