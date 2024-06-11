local M = {
  'echasnovski/mini.bracketed',
  version = false,
}

function M.config()
  local bracketed = require('mini.bracketed')
  bracketed.setup({
    buffer     = { suffix = '', options = {} },
    comment    = { suffix = '', options = {} },
    conflict   = { suffix = 'x', options = {} },
    diagnostic = { suffix = '', options = {} },
    file       = { suffix = 'e', options = {} },
    indent     = { suffix = 'i', options = {} },
    jump       = { suffix = '', options = {} },
    location   = { suffix = 'l', options = {} },
    oldfile    = { suffix = 'o', options = {} },
    quickfix   = { suffix = 'q', options = {} },
    treesitter = { suffix = 't', options = {} },
    undo       = { suffix = '', options = {} },
    window     = { suffix = '', options = {} },
    yank       = { suffix = '', options = {} },
  })
end

return M

