local M = {
  'junegunn/vim-easy-align',
  event = 'VeryLazy',
}

vim.api.nvim_set_keymap('v', 'g=', '<Plug>(EasyAlign)', { noremap = false })
vim.api.nvim_set_keymap('n', 'g=', '<Plug>(EasyAlign)', { noremap = false })

return M
