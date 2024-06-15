local M = {
  "olexsmir/gopher.nvim",
  ft = "go",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  build = function()
    vim.cmd.GoInstallDeps()
  end,
}

function M.config()
  require("gopher").setup()
end

return M
