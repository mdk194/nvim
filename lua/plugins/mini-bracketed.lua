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
  map(modes, ')c', function() bracketed.comment('forward') end, { desc = 'mini.bracketed: Next comment' })
  map(modes, '(c', function() bracketed.comment('backward') end, { desc = 'mini.bracketed: Prev comment' })
  map(modes, ')x', function() bracketed.conflict('forward') end, { desc = 'mini.bracketed: Next conflict' })
  map(modes, '(x', function() bracketed.conflict('backward') end, { desc = 'mini.bracketed: Prev conflict' })
  map(modes, ')i', function() bracketed.indent('forward') end, { desc = 'mini.bracketed: Next indent' })
  map(modes, '(i', function() bracketed.indent('backward') end, { desc = 'mini.bracketed: Prev indent' })
  map(modes, ')l', function() bracketed.location('forward') end, { desc = 'mini.bracketed: Next location' })
  map(modes, '(l', function() bracketed.location('backward') end, { desc = 'mini.bracketed: Prev location' })
  map(modes, ')q', function() bracketed.quickfix('forward') end, { desc = 'mini.bracketed: Next quickfix' })
  map(modes, '(q', function() bracketed.quickfix('backward') end, { desc = 'mini.bracketed: Prev quickfix' })
end

return M

