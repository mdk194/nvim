local M = {
  "olexsmir/gopher.nvim",
  cmd = { "GoTagAdd", "GoTagRm", "GoTestAdd", "GoTestsAll", "GoTestsExp", "GoGenerate", "GoGet", "GoMod", "GoImpl", "GoCmt", "GoIfErr" },
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
