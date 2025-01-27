local M = {
  "ibhagwan/fzf-lua",
  keys = {
    { '<c-f>', [[<cmd>lua require('fzf-lua').files()<CR>]] },
    { '<c-p>', [[<cmd>lua require('functions').fzf('files')()<CR>]] },

    { '<leader>f', [[<cmd>lua require('fzf-lua').resume()<CR>]] },
    { '<leader>b', [[<cmd>lua require('fzf-lua').buffers()<CR>]]},
    { '<leader>g', [[<cmd>lua require('functions').fzf('live_grep_glob')()<CR>]] },
    { '<leader>/', [[<cmd>lua require('fzf-lua').blines()<CR>]] },
    { '<leader>ht', [[<cmd>lua require('fzf-lua').helptags()<CR>]] },
    { '<leader>o', [[<cmd>lua require('fzf-lua').oldfiles()<CR>]] },
    { '<leader>c', [[<cmd>lua require('fzf-lua').changes()<CR>]] },
    { '<leader>m', [[<cmd>lua require('fzf-lua').marks()<CR>]] },
    { '<leader>j', [[<cmd>lua require('fzf-lua').jumps()<CR>]] },
    { '<leader>p', [[<cmd>lua require('functions').fzf_dirs()<CR>]] },

    -- { '<space>g', [[<cmd>Telescope ast_grep<CR>]] },
    { '<leader>z', [[<cmd>lua require('fzf-lua').zoxide()<CR>]] },
  },
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
        preview = { default = "bat_native", layout = "horizontal", horizontal = "up:60%" },
        treesitter = {
          enabled = false,
        }
      },
    },
    previewers = {
      bat = {
        theme = 'gruvbox-dark',
      },
    },
    keymap = {
      builtin = {
        ["<F1>"]  = "toggle-help",
        ["<F2>"]  = "toggle-fullscreen",
        ["<C-t>"] = "toggle-preview",
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
      },
      fzf = {
        ["ctrl-z"] = "abort",
        -- ["ctrl-a"]         = "beginning-of-line",
        ["ctrl-e"] = "end-of-line",
        ["shift-tab"] = "toggle-all",
        ["ctrl-a"] = "select-all+accept", -- select all and send to quickfix list
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
        ["ctrl-t"] = "toggle-preview",
      },
      buffers = {
        ["default"] = actions.buf_edit,
        ["ctrl-s"]  = actions.buf_split,
        ["ctrl-v"]  = actions.buf_vsplit,
        ["ctrl-]"]  = actions.buf_tabedit,
        ["ctrl-t"] = "toggle-preview",
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
      cwd_header = true,
      cwd_prompt_shorten_len = 32,
      find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
      rg_opts   = [[--color=never --files --follow -g "!.git"]],
      fd_opts   = [[--color=never --type f --follow]],
      actions = {
        ["ctrl-g"] = { actions.toggle_ignore },
        ["ctrl-h"] = { actions.toggle_hidden },
      },
      winopts = { preview = { hidden = "hidden" } },
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
      },
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

  fzf.register_ui_select(function(_, items)
    local min_h, max_h = 0.15, 0.70
    local h = (#items + 4) / vim.o.lines
    if h < min_h then
      h = min_h
    elseif h > max_h then
      h = max_h
    end
    return { winopts = { height = h, width = 0.60, row = 0.40 } }
  end)

end

return M
