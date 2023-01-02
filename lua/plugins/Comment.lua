local M = {
  "numToStr/Comment.nvim",
  event = 'BufEnter',
}

function M.config()
  require("Comment").setup()
end

return M
