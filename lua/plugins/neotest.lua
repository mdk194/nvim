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
    { "<leader>tr", function() require("neotest").run.run() end, desc = "neotest: Run nearest" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "neotest: Run file" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "neotest: Summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = false }) end, desc = "neotest: Output" },
    { "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "neotest: Output panel" },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "neotest: Debug nearest" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "neotest: Run last" },
    { "[t", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "neotest: Prev failed" },
    { "]t", function() require("neotest").jump.next({ status = "failed" }) end, desc = "neotest: Next failed" },
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
