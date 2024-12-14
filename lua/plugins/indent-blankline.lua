local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  lazy = false,
}

function M.config()
  local highlight = {
    "Whitespace",
    "CursorColumn",
  }

  require("ibl").setup {
    indent = { highlight = highlight, char = "" },
    whitespace = {
      highlight = highlight,
      remove_blankline_trail = false,
    },
    scope = { enabled = false },
  }
end

return M
