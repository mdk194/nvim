local M = {
  'echasnovski/mini.completion',
  version = '*',
}

function M.config()
  local completion = require('mini.completion')
  completion.setup({
    -- Delay (debounce type, in ms) between certain Neovim event and action.
    -- This can be used to (virtually) disable certain automatic actions by
    -- setting very high delay time (like 10^7).
    delay = { completion = 100, info = 100, signature = 50 },

    -- Configuration for action windows:
    -- - `height` and `width` are maximum dimensions.
    -- - `border` defines border (as in `nvim_open_win()`).
    window = {
      info = { height = 25, width = 80, border = 'rounded' },
      signature = { height = 25, width = 80, border = 'rounded' },
    },

    -- Way of how module does LSP completion
    lsp_completion = {
      -- `source_func` should be one of 'completefunc' or 'omnifunc'.
      source_func = 'completefunc',

      -- `auto_setup` should be boolean indicating if LSP completion is set up
      -- on every `BufEnter` event.
      auto_setup = true,

      -- `process_items` should be a function which takes LSP
      -- 'textDocument/completion' response items and word to complete. Its
      -- output should be a table of the same nature as input items. The most
      -- common use-cases are custom filtering and sorting. You can use
      -- default `process_items` as `MiniCompletion.default_process_items()`.
      -- process_items = --<function: filters out snippets; sorts by LSP specs>,
    },

    -- Fallback action. It will always be run in Insert mode. To use Neovim's
    -- built-in completion (see `:h ins-completion`), supply its mapping as
    -- string. Example: to use 'whole lines' completion, supply '<C-x><C-l>'.
    fallback_action = '<C-x><C-i>', -- current and included files

    -- Module mappings. Use `''` (empty string) to disable one. Some of them
    -- might conflict with system mappings.
    mappings = {
      force_twostep = '<C-Space>', -- Force two-step completion
      force_fallback = '<A-Space>', -- Force fallback completion
    },

    -- Whether to set Vim's settings for better experience (modifies
    -- `shortmess` and `completeopt`)
    set_vim_settings = true,
  })
end

vim.keymap.set('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { expr = true })
vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

local keys = {
  ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
  ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
  ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
}

_G.cr_action = function()
  if vim.fn.pumvisible() ~= 0 then
    -- If popup is visible, confirm selected item or add new line otherwise
    local item_selected = vim.fn.complete_info()['selected'] ~= -1
    return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
  else
    -- If popup is not visible, use plain `<CR>`. You might want to customize
    -- according to other plugins. For example, to use 'mini.pairs', replace
    -- next line with `return require('mini.pairs').cr()`
    return keys['cr']
  end
end

vim.keymap.set('i', '<CR>', 'v:lua._G.cr_action()', { expr = true })

return M

