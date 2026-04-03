local M = {
  'nvim-mini/mini.ai',
  version = false,
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
}

function M.config()
  local move = require('nvim-treesitter-textobjects.move')
  vim.keymap.set({ 'n', 'x', 'o' }, ']f', function() move.goto_next_start('@function.outer') end, { desc = 'ts: Next function' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[f', function() move.goto_previous_start('@function.outer') end, { desc = 'ts: Prev function' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']o', function() move.goto_next_start('@block.outer') end, { desc = 'ts: Next block' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[o', function() move.goto_previous_start('@block.outer') end, { desc = 'ts: Prev block' })

  local spec_treesitter = require('mini.ai').gen_spec.treesitter
  require('mini.ai').setup({
    -- Table with textobject id as fields, textobject specification as values.
    -- Also use this to disable builtin textobjects. See |MiniAi.config|.
    custom_textobjects = {
      F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
      o = spec_treesitter({
        a = { '@block.outer', '@conditional.outer', '@loop.outer' },
        i = { '@block.inner', '@conditional.inner', '@loop.inner' },
      }),
      d = { "%f[%d]%d+" }, -- digits
      e = { -- Word with case
        { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
        "^().*()$",
      },
    },

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Main textobject prefixes
      around = 'a',
      inside = 'i',

      around_next = '',
      inside_next = '',
      around_last = '',
      inside_last = '',

      -- Move cursor to corresponding edge of `a` textobject
      goto_left = 'g[',
      goto_right = 'g]',
    },

    -- Number of lines within which textobject is searched
    n_lines = 100,

    -- How to search for object (first inside current line, then inside
    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
    -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
    search_method = 'cover_or_next',
  })
end

return M

