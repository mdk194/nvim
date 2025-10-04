local M = {
  "zbirenbaum/copilot.lua",
  cmd = { "Copilot" },
  event = "InsertEnter",
  -- keys = {
  --   { '<leader>co', function ()
  --       require('copilot.suggestion').toggle_auto_trigger()
  --       vim.notify(tostring(vim.b.copilot_suggestion_auto_trigger), "info", {
  --         id = "copilot",
  --         title = "Copilot auto trigger",
  --       })
  --     end
  --   },
  -- },
}

function M.config()
  require('copilot').setup({
  panel = {
    enabled = false,
    auto_refresh = false,
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = true,
    debounce = 75,
    keymap = {
      accept = "<C-y>",
      accept_word = false,
      accept_line = "<C-l>",
      next = "<C-j>",
      prev = "<C-k>",
      dismiss = "<C-e>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = true,
    help = true,
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
