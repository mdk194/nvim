local M = {
  'echasnovski/mini.diff',
  version = false,
  event = 'VeryLazy',
}

function M.config()
  require('mini.diff').setup({
    view = {
      -- Visualization style. Possible values are 'sign' and 'number'.
      -- Default: 'number' if line numbers are enabled, 'sign' otherwise.
      -- style = vim.go.number and 'number' or 'sign',
      style = 'sign',

      -- Signs used for hunks with 'sign' view
      signs = { add = '▒', change = '▒', delete = '▒' },

      -- Priority of used visualization extmarks
      priority = 199,
    },
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Apply hunks inside a visual/operator region
      apply = 'gh',

      -- Reset hunks inside a visual/operator region
      reset = 'gH',

      -- Hunk range textobject to be used inside operator
      -- Works also in Visual mode if mapping differs from apply and reset
      textobject = 'gh',

      -- Go to hunk range in corresponding direction
      goto_first = '[H',
      goto_prev = '[h',
      goto_next = ']h',
      goto_last = ']H',
    },
    -- Various options
    options = {
      -- Diff algorithm. See `:h vim.diff()`.
      algorithm = 'patience',

      -- Whether to use "indent heuristic". See `:h vim.diff()`.
      indent_heuristic = true,

      -- The amount of second-stage diff to align lines
      linematch = 60,

      -- Whether to wrap around edges during hunk navigation
      wrap_goto = false,
    },
  })
end

return M

