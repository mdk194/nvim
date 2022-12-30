local M = {'nathanaelkane/vim-indent-guides'}

function M.config()
  vim.g.indent_guides_enable_on_vim_startup = 1
  vim.g.indent_guides_auto_colors = 0
end

return M
