local M = {
  "olexsmir/gopher.nvim",
  ft = "go",
}

function M.config()
  require("gopher").setup()
end

return M
