return {
  "savq/melange-nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    vim.cmd([[colorscheme melange]])
    vim.cmd([[highlight IndentGuidesOdd guifg=#524D4A guibg=#2A2520]])
    vim.cmd([[highlight IndentGuidesEven guifg=#2A2520 guibg=#352F2A]])
    vim.cmd([[highlight DiagnosticInfo gui=italic]])
    vim.cmd([[highlight DiagnosticHint gui=bold,italic]])
    vim.cmd([[highlight DiagnosticWarn gui=bold,underdotted]])
    vim.cmd([[highlight DiagnosticError gui=bold,standout]])
  end,
}
