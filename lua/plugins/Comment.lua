local M = {
  "numToStr/Comment.nvim",
  keys = {
    { 'gcc', '<Plug>(comment_toggle_linewise_current)' },
    { 'gc', '<Plug>(comment_toggle_linewise)' },
    { 'gc', '<Plug>(comment_toggle_linewise_visual)', mode = 'x' },
  }
}

function M.config()
  require("Comment").setup({
    mappings = {
      basic = false,
      extra = false,
    }
  })
end

return M

