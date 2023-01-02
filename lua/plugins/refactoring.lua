local M = {
  'ThePrimeagen/refactoring.nvim',
  ft = {'java', 'lua', 'go', 'python', 'lua', 'javascript', 'typescript', 'c', 'cpp'},
  dependencies = {
    {'nvim-lua/plenary.nvim'},
    {'nvim-treesitter/nvim-treesitter'},
  }
}

function M.config()
  require('refactoring').setup({
    -- prompt for return type
    prompt_func_return_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
    },
  })
  -- require("telescope").load_extension("refactoring")
  vim.api.nvim_set_keymap("v", "<leader>r", ":lua require('refactoring').select_refactor()<CR>", { noremap = true, silent = true, expr = false })

  vim.api.nvim_set_keymap("n", "<leader>rp", ":lua require('refactoring').debug.printf({below = true})<CR>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>rv", ":lua require('refactoring').debug.print_var({ normal = true })<CR>", { noremap = true })

  vim.api.nvim_set_keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })
end

return M
