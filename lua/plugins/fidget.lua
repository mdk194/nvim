local M = {
  "j-hui/fidget.nvim",
  event = 'VeryLazy',
}

function M.config()
  require("fidget").setup({
    text = {
      spinner = "bouncing_bar", -- noise
    },
  })
end

return M
