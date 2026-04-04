local M = {
  'nvim-mini/mini.bracketed',
  version = false,
  event = 'VeryLazy',
}

function M.config()
  local bracketed = require('mini.bracketed')
  -- Disable built-in [/] mappings, use (/)) instead
  bracketed.setup({
    buffer     = { suffix = '', options = {} },
    comment    = { suffix = '', options = {} },
    conflict   = { suffix = '', options = {} },
    diagnostic = { suffix = '', options = {} },
    file       = { suffix = '', options = {} },
    indent     = { suffix = '', options = {} },
    jump       = { suffix = '', options = {} },
    location   = { suffix = '', options = {} },
    oldfile    = { suffix = '', options = {} },
    quickfix   = { suffix = '', options = {} },
    treesitter = { suffix = '', options = {} },
    undo       = { suffix = '', options = {} },
    window     = { suffix = '', options = {} },
    yank       = { suffix = '', options = {} },
  })

  local map = vim.keymap.set
  local modes = { 'n', 'x', 'o' }
  map(modes, 'lc', function() bracketed.comment('forward') end, { desc = 'mini.bracketed: Next comment' })
  map(modes, 'hc', function() bracketed.comment('backward') end, { desc = 'mini.bracketed: Prev comment' })
  map(modes, 'lx', function() bracketed.conflict('forward') end, { desc = 'mini.bracketed: Next conflict' })
  map(modes, 'hx', function() bracketed.conflict('backward') end, { desc = 'mini.bracketed: Prev conflict' })
  map(modes, 'li', function() bracketed.indent('forward') end, { desc = 'mini.bracketed: Next indent' })
  map(modes, 'hi', function() bracketed.indent('backward') end, { desc = 'mini.bracketed: Prev indent' })
  map(modes, 'll', function() bracketed.location('forward') end, { desc = 'mini.bracketed: Next location' })
  map(modes, 'hl', function() bracketed.location('backward') end, { desc = 'mini.bracketed: Prev location' })
  map(modes, 'lq', function() bracketed.quickfix('forward') end, { desc = 'mini.bracketed: Next quickfix' })
  map(modes, 'hq', function() bracketed.quickfix('backward') end, { desc = 'mini.bracketed: Prev quickfix' })
end

return M

