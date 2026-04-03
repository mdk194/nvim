local M = {
  'nvim-mini/mini.clue',
  version = false,
  event = 'VeryLazy',
}

function M.config()
  local miniclue = require('mini.clue')
  miniclue.setup({
    window = {
      delay = 300,
      scroll_down = '<C-d>',
      scroll_up = '<C-u>',
      config = {
        width = 'auto',
      },
    },

    triggers = {
      -- Leader triggers
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },

      -- Space triggers (LSP)
      { mode = 'n', keys = '<Space>' },

      -- Built-in completion
      { mode = 'i', keys = '<C-x>' },

      -- `g` key
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },

      -- Marks
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },

      -- Registers
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },

      -- Window commands
      { mode = 'n', keys = '<C-w>' },

      -- `z` key
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },

      -- Brackets
      { mode = 'n', keys = '[' },
      { mode = 'n', keys = ']' },
      { mode = 'x', keys = '[' },
      { mode = 'x', keys = ']' },

      -- Surround (mini.surround)
      { mode = 'n', keys = 's' },
      { mode = 'x', keys = 's' },
    },

    clues = {
      -- Built-in clue enhancers
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),

      -- Leader sub-group descriptions
      { mode = 'n', keys = '<Leader>k', desc = '+Git' },
      { mode = 'n', keys = '<Leader>u', desc = '+UI/Toggle' },
      { mode = 'n', keys = '<Leader>t', desc = '+Test' },
      { mode = 'n', keys = 'gw', desc = '+Workspace' },

      -- Space sub-group descriptions (LSP)
      { mode = 'n', keys = '<Space>',  desc = '+LSP' },

      -- Surround sub-group
      { mode = 'n', keys = 's', desc = '+Surround' },
      { mode = 'x', keys = 's', desc = '+Surround' },

      -- Bracket navigation descriptions
      { mode = 'n', keys = ']h', desc = 'mini.diff: Next hunk' },
      { mode = 'n', keys = '[h', desc = 'mini.diff: Prev hunk' },
      { mode = 'n', keys = ']H', desc = 'mini.diff: Last hunk' },
      { mode = 'n', keys = '[H', desc = 'mini.diff: First hunk' },
      { mode = 'n', keys = ']d', desc = 'lsp: Next diagnostic' },
      { mode = 'n', keys = '[d', desc = 'lsp: Prev diagnostic' },
      { mode = 'n', keys = '[s', desc = 'ts: Go to context' },

      -- mini.bracketed descriptions
      { mode = 'n', keys = ']c', desc = 'mini.bracketed: Next comment' },
      { mode = 'n', keys = '[c', desc = 'mini.bracketed: Prev comment' },
      { mode = 'n', keys = ']o', desc = 'ts: Next block' },
      { mode = 'n', keys = '[o', desc = 'ts: Prev block' },
      { mode = 'n', keys = ']x', desc = 'mini.bracketed: Next conflict' },
      { mode = 'n', keys = '[x', desc = 'mini.bracketed: Prev conflict' },
      { mode = 'n', keys = ']i', desc = 'mini.bracketed: Next indent' },
      { mode = 'n', keys = '[i', desc = 'mini.bracketed: Prev indent' },
      { mode = 'n', keys = ']l', desc = 'mini.bracketed: Next location' },
      { mode = 'n', keys = '[l', desc = 'mini.bracketed: Prev location' },
      { mode = 'n', keys = ']q', desc = 'mini.bracketed: Next quickfix' },
      { mode = 'n', keys = '[q', desc = 'mini.bracketed: Prev quickfix' },
    },
  })
end

return M
