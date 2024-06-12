local M = {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  main = "ibl",
}

function M.config()
  local highlight = {
    "Whitespace",
    "CursorColumn",
  }

  require("ibl").setup {
    indent = {
      priority = 1,
      highlight = highlight,
      char = ""
    },
    whitespace = {
      highlight = highlight,
      remove_blankline_trail = false,
    },
    scope = { enabled = false },
  }
end

return M
