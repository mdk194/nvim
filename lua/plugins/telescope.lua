local M = {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    "nvim-telescope/telescope-ui-select.nvim",
  },
}

function M.config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case" or "smart_case"
      },
      ["ui-select"] = {
        require("telescope.themes").get_cursor(),
      },
    },
    pickers = {
      find_files = {
        -- find_command = { "fd", "--type", "file", "--follow", "--strip-cwd-prefix", "--size", "-1m" },
        find_command = { "fd", "--type", "file", "--follow", "--strip-cwd-prefix" },
      },
      buffers = {
        ignore_current_buffer = true,
        sort_lastused = true,
      },
    },
    defaults = {
      file_ignore_patterns = { "node_modules", ".terraform", "%.jpg", "%.png", ".git" },
      -- used for grep_string and live_grep
      vimgrep_arguments = {
        "rg",
        "--follow",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--no-ignore",
        "--trim",
      },
      mappings = {
        i = {
          ["<esc>"] = actions.close, -- Close on first esc instead of going to normal mode
          ["<C-f>"] = actions.preview_scrolling_up,
          ["<C-b>"] = actions.preview_scrolling_down,
          ['<C-u>'] = false,
          ['<C-d>'] = false,
          -- toggle showing hidden and ignored files while in find_files insert mode
          ["<C-h>"] = require("functions").telescope("find_files", { hidden = true, no_ignore = true }),
        },
      },
      initial_mode = "insert",
      scroll_strategy = "cycle",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "vertical",
      layout_config = {
        width = 0.95,
        height = 0.95,
        preview_cutoff = 1,
        prompt_position = "bottom",
        horizontal = {
          preview_width = function(_, cols, _)
            if cols > 200 then
              return math.floor(cols * 0.4)
            else
              return math.floor(cols * 0.6)
            end
          end,
        },
        vertical = { width = 0.95, height = 0.95, preview_height = 0.6 },
        flex = { horizontal = { preview_width = 0.95 } },
      },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = false,
      use_less = true,
    },
  })

  telescope.load_extension('fzf')
  telescope.load_extension("ui-select")
end

vim.api.nvim_set_keymap('n', '<c-f>', [[<cmd>lua require('functions').telescope('find_files')()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-p>', [[<cmd>lua require('functions').telescope('git_files')()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', [[<cmd>lua require('functions').telescope('grep_string')()<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>g', [[<cmd>lua require('functions').telescope('live_grep')()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>/', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', [[<cmd>lua require('telescope.builtin').treesitter()<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>t', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>tb', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ht', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>o', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', [[<cmd>lua require('telescope.builtin').jumplist()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>c', [[<cmd>lua require('telescope.builtin').command_history()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>m', [[<cmd>lua require('telescope.builtin').marks()<CR>]], { noremap = true, silent = true })

return M
