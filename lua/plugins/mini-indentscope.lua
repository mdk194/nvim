local M = {
  'echasnovski/mini.indentscope',
  event = 'VeryLazy',
  version = false,
}

function M.config()
  local indentscope = require('mini.indentscope')
  indentscope.setup({
    -- Which character to use for drawing scope indicator
    symbol = '▏',
    draw = {
      -- Delay (in ms) between event and start of drawing scope indicator
      delay = 100,
      animation = indentscope.gen_animation.none(),
      -- Symbol priority. Increase to display on top of more symbols.
      priority = 2,
    },

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Textobjects
      object_scope = 'ii',
      object_scope_with_border = 'ai',

      -- Motions (jump to respective border line; if not present - body line)
      goto_top = '[i',
      goto_bottom = ']i',
    },

    -- Options which control scope computation
    options = {
      -- Type of scope's border: which line(s) with smaller indent to
      -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
      border = 'both',

      -- Whether to use cursor column when computing reference indent.
      -- Useful to see incremental scopes with horizontal cursor movements.
      indent_at_cursor = true,

      -- Whether to first check input line to be a border of adjacent scope.
      -- Use it if you want to place cursor on function header to get scope of
      -- its body.
      try_as_border = true,
    },
  })

  vim.cmd.highlight('MiniIndentscopeSymbol guifg=#f6fa05')
end

return M
