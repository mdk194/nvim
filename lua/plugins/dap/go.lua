local M = {}

function M.setup()
  require("dap-go").setup({
    -- dlv debug -l 127.0.0.1:38697 --headless ./main.go -- subcommand --myflag=xyz
    dap_configurations = {
      {
        -- Must be "go" or it will be ignored by the plugin
        type = "go",
        name = "Attach remote",
        mode = "remote",
        request = "attach",
      },
    },
  })

  vim.keymap.set('n', '<leader>dt', require('dap-go').debug_test)

end

return M
