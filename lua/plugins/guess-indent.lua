local M = {
  'nmac427/guess-indent.nvim',
  lazy = false,
}

function M.config()
  require('guess-indent').setup({})
end

return M


