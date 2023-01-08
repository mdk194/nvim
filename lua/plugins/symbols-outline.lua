local M = {
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
}

function M.config()
  require("symbols-outline").setup({
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = true,
    position = "right",
    relative_width = true,
    width = 25,
    auto_close = false,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = "Pmenu",
    autofold_depth = nil,
    auto_unfold_hover = true,
    keymaps = { -- These keymaps can be a string or a table for multiple keys
      close = { "<Esc>", "K" },
      goto_location = "<Cr>",
      focus_location = "o",
      hover_symbol = "M",
      toggle_preview = "<C-space>",
      rename_symbol = "r",
      code_actions = "a",
      fold = "h",
      unfold = "l",
      fold_all = "W",
      unfold_all = "E",
      fold_reset = "R",
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
  })
end

return M
