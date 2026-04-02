local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- adapters
    "fredrikaverpil/neotest-golang",
    "nvim-neotest/neotest-python",
    "marilari88/neotest-vitest",
    "rcasia/neotest-java",
  },
  keys = {
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run nearest test" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = false }) end, desc = "Show test output" },
    { "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run last test" },
    { "[t", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Prev failed test" },
    { "]t", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Next failed test" },
  },
}

function M.config()
  require("neotest").setup({
    floating = {
      border = "rounded",
    },
    adapters = {
      require("neotest-golang")({}),
      require("neotest-python")({}),
      require("neotest-vitest")({}),
      require("neotest-java")({}),
      require("rustaceanvim.neotest"),
    },
  })
end

return M
