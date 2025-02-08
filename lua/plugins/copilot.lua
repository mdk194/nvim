local M = {
  "zbirenbaum/copilot.lua",
  cmd = { "Copilot" },
  keys = {
    { '<leader>co', [[<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<CR>]] },
  },
}

function M.config()
  require('copilot').setup({
  panel = {
    enabled = false,
    auto_refresh = false,
    keymap = {
      jump_prev = "<C-b>",
      jump_next = "<C-f>",
      accept = "<C-y>",
      refresh = "<leader>r",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right | horizontal | vertical
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    hide_during_completion = true,
    debounce = 75,
    keymap = {
      accept = "<C-y>",
      accept_word = false,
      accept_line = false,
      next = "<C-f>",
      prev = "<C-b>",
      dismiss = "<C-e>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 18.x
  server_opts_overrides = {},
})
end

return M
