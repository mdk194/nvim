local M = {
  "ibhagwan/fzf-lua",
  event = 'VeryLazy',
}

function M.config()
  local fzf = require('fzf-lua')
  local actions = require('fzf-lua.actions')

  fzf.setup({
    manpages = { previewer = "man_native" },
    helptags = { previewer = "help_native" },
    defaults = {
      git_icons = false,
      file_icons = false,
      winopts = {
        -- split = "belowright 20new",
        height  = 0.90,
        width   = 1,
        row     = 0.35,
        col     = 0.55,
        border  = "rounded",
        preview = { default = "bat_native", hidden = "hidden", layout = "horizontal", horizontal = "up:60%" },
      },
    },
    previewers = {
      bat = {
        theme = 'gruvbox-dark',
      },
    },
    keymap = {
      builtin = {
        ["<F1>"] = "toggle-help",
        ["<F2>"] = "toggle-fullscreen",
      },
      fzf = {
        ["ctrl-z"] = "abort",
        -- ["ctrl-a"]         = "beginning-of-line",
        ["ctrl-e"] = "end-of-line",
        ["ctrl-a"] = "toggle-all",
        ["ctrl-w"] = "toggle-preview-wrap",
        ["ctrl-t"] = "toggle-preview",
        ["ctrl-u"] = "preview-page-up",
        ["ctrl-d"] = "preview-page-down",
        ["ctrl-f"] = "preview-down",
        ["ctrl-b"] = "preview-up",
      },
    },
    actions = {
      files = {
        ["default"] = actions.file_edit_or_qf,
        ["ctrl-s"]  = actions.file_split,
        ["ctrl-v"]  = actions.file_vsplit,
        ["ctrl-]"]  = actions.file_tabedit,
        ["ctrl-q"]  = actions.file_sel_to_qf,
        ["ctrl-l"]  = actions.file_sel_to_ll,
      },
      buffers = {
        ["default"] = actions.buf_edit,
        ["ctrl-s"]  = actions.buf_split,
        ["ctrl-v"]  = actions.buf_vsplit,
        ["ctrl-]"]  = actions.buf_tabedit,
      }
    },
    fzf_opts = {
      -- options are sent as `<left>=<right>`
      -- set to `false` to remove a flag
      -- set to `true` for a no-value flag
      -- for raw args use `fzf_args` instead
      ["--ansi"]           = true,
      ["--info"]           = "inline-right", -- fzf < v0.42 = "inline"
      ["--height"]         = "100%",
      ["--layout"]         = "default",
      ["--border"]         = "none",
      -- ["--preview-window"] = "up:60%:hidden",
      ["--highlight-line"] = true,           -- fzf >= v0.53
    },
    files = {
      previewer = "bat",
      cwd_header = true,
      cwd_prompt_shorten_len = 32,
      find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
      rg_opts   = [[--color=never --files --follow -g "!.git"]],
      fd_opts   = [[--color=never --type f --follow]],
      actions = {
        ["ctrl-g"] = { actions.toggle_ignore },
        ["ctrl-h"] = { actions.toggle_hidden },
      }
    },
    grep = {
      rg_opts        = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
      rg_glob        = false,        -- default to glob parsing?
      glob_flag      = "--iglob",    -- for case sensitive globs use '--glob'
      glob_separator = "%s%-%-",     -- query separator pattern (lua): ' --'
      actions = {
        -- this action toggles between 'grep' and 'live_grep'
        ["ctrl-l"] = { actions.grep_lgrep },
        ["ctrl-g"] = { actions.toggle_ignore },
        ["ctrl-h"] = { actions.toggle_hidden },
      },
    },
    args = {
      files_only = true,
      actions    = { ["ctrl-x"] = { fn = actions.arg_del, reload = true } },
    },
    buffers = {
      sort_lastused     = true,        -- sort buffers() by last used
      show_unloaded     = false,
      cwd_only          = false,        -- buffers for the cwd only
      cwd               = nil,          -- buffers list for a given dir
      actions = {
        ["ctrl-x"]      = { fn = actions.buf_del, reload = true },
      }
    },
    quickfix = {
      file_icons        = false,
      git_icons         = false,
      only_valid        = false, -- select among only the valid quickfix entries
    },
    diagnostics = {
      diag_source       = true,   -- display diag source (e.g. [pycodestyle])
      multiline         = false,
    },
    lsp = {
      async_or_timeout  = 5000,       -- timeout(ms) or 'true' for async calls
      file_icons        = false,
      git_icons         = false,
      -- settings for 'lsp_{document|workspace|lsp_live_workspace}_symbols'
      symbols = {
        async_or_timeout  = true,
        symbol_style      = 1,
      },
      code_actions = { previewer = "codeaction_native" },
    },
  })

  fzf.register_ui_select()

  vim.api.nvim_set_keymap('n', '<c-f>', [[<cmd>lua require('fzf-lua').files()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<c-p>', [[<cmd>lua require('functions').fzf('files')()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>lua require('fzf-lua').resume()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>b', [[<cmd>lua require('fzf-lua').buffers()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>g', [[<cmd>lua require('functions').fzf('live_grep_glob')()<CR>]], { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', '<space>g', [[<cmd>Telescope ast_grep<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>/', [[<cmd>lua require('fzf-lua').blines()<CR>]], { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', '<leader>t', [[<cmd>lua require('telescope.builtin').treesitter()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ht', [[<cmd>lua require('fzf-lua').helptags()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>o', [[<cmd>lua require('fzf-lua').oldfiles()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>c', [[<cmd>lua require('fzf-lua').changes()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>m', [[<cmd>lua require('fzf-lua').marks()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>j', [[<cmd>lua require('fzf-lua').jumps()<CR>]], { noremap = true, silent = true })

  vim.api.nvim_set_keymap('n', '<leader>p', [[<cmd>lua require('functions').fzf_dirs()<CR>]], { noremap = true, silent = true })
end

return M
