local M = {'tpope/vim-surround'}

function M.config()
  vim.g.surround_indent = 1
  vim.g.surround_no_insert_mappings = 1
end

return M
