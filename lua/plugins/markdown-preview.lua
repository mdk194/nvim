local M = {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' },
  build = 'cd app && npm install',
}

function M.config()
  vim.g.mkdp_filetypes = { "markdown" }
  vim.g.mkdp_theme = 'dark'
end

return M
