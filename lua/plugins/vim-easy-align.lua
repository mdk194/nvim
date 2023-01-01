local M = { 'junegunn/vim-easy-align' }

vim.api.nvim_set_keymap('v', '<Enter>', '<Plug>(EasyAlign)', { noremap = false })
vim.api.nvim_set_keymap('n', 'g=', '<Plug>(EasyAlign)', { noremap = false })

return M
