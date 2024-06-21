local M = {
  'nathanaelkane/vim-indent-guides',
  lazy = false,
}

function M.init()
  vim.g.indent_guides_enable_on_vim_startup = 1
  vim.g.indent_guides_auto_colors = 0
  vim.g.indent_guides_exclude_buftype = 1
  --vim.g.indent_guides_exclude_filetypes = ['help', 'nerdtree']
end

return M
