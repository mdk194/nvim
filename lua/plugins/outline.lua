local M = {
  "hedyhli/outline.nvim",
  cmd = "Outline",
  keys = {
    { "<F4>", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
}

function M.config()
  require("outline").setup({
    keymaps = {
      show_help = '?',
      close = {'<Esc>', 'q', 'K'},
      -- Jump to symbol under cursor.
      -- It can auto close the outline window when triggered, see
      -- 'auto_close' option above.
      goto_location = '<Cr>',
      -- Jump to symbol under cursor but keep focus on outline window.
      peek_location = 'o',
      -- Visit location in code and close outline immediately
      goto_and_close = '<S-Cr>',
      -- Change cursor position of outline window to match current location in code.
      -- 'Opposite' of goto/peek_location.
      restore_location = '<C-g>',
      -- Open LSP/provider-dependent symbol hover information
      hover_symbol = '<C-space>',
      -- Preview location code of the symbol under cursor
      toggle_preview = 'M',
      rename_symbol = 'r',
      code_actions = 'a',
      -- These fold actions are collapsing tree nodes, not code folding
      fold = 'h',
      unfold = 'l',
      fold_toggle = '<Tab>',
      -- Toggle folds for all nodes.
      -- If at least one node is folded, this action will fold all nodes.
      -- If all nodes are folded, this action will unfold all nodes.
      fold_toggle_all = '<S-Tab>',
      fold_all = 'W',
      unfold_all = 'E',
      fold_reset = 'R',
      -- Move down/up by one line and peek_location immediately.
      -- You can also use outline_window.auto_jump=true to do this for any
      -- j/k/<down>/<up>.
      down_and_jump = '<C-j>',
      up_and_jump = '<C-k>',
    },
    preview_window = {
      auto_preview = true,
      -- Automatically open hover_symbol when opening preview (see keymaps for
      -- hover_symbol).
      -- If you disable this you can still open hover_symbol using your keymap
      -- below.
      open_hover_on_preview = true,
      width = 50,     -- Percentage or integer of columns
      min_width = 50, -- This is the number of columns
      -- Whether width is relative to the total width of nvim.
      -- When relative_width = true, this means take 50% of the total
      -- screen width for preview window, ensure the result width is at least 50
      -- characters wide.
      relative_width = true,
      -- Border option for floating preview window.
      -- Options include: single/double/rounded/solid/shadow or an array of border
      -- characters.
      -- See :help nvim_open_win() and search for "border" option.
      border = 'single',
      -- winhl options for the preview window, see ':h winhl'
      winhl = 'NormalFloat:',
      -- Pseudo-transparency of the preview window, see ':h winblend'
      winblend = 0,
      -- Experimental feature that let's you edit the source content live
      -- in the preview window. Like VS Code's "peek editor".
      live = false
    },
  })
end

return M
