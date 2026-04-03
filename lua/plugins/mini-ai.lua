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
      i = function(ai_type) -- indent scope (matches mini.indentscope behavior)
        local curpos = vim.fn.getcurpos()
        local cur_line = curpos[2]
        local cur_col = curpos[5] -- curswant, handles blank lines

        -- Get line indent, handling blank lines like mini.indentscope
        local function get_indent(line)
          local prev = vim.fn.prevnonblank(line)
          local prev_indent = vim.fn.indent(prev)
          if line == prev then return prev_indent end
          -- blank line: use min of surrounding non-blank indents (border = 'both')
          local next_indent = vim.fn.indent(vim.fn.nextnonblank(line))
          return math.min(prev_indent, next_indent)
        end

        local line_indent = get_indent(cur_line)
        -- indent_at_cursor: use cursor column if less than line indent
        local indent = math.min(cur_col, line_indent)
        if indent <= 0 then return nil end

        -- try_as_border: if current line has less indent than body below,
        -- treat it as border and use the body's scope
        local next_nb = vim.fn.nextnonblank(cur_line + 1)
        if next_nb > 0 and vim.fn.indent(next_nb) > indent then
          indent = vim.fn.indent(next_nb)
          cur_line = next_nb
        end

        -- cast ray up
        local from = cur_line
        local last_line = vim.fn.line('$')
        for l = cur_line - 1, 1, -1 do
          if get_indent(l) < indent then break end
          from = l
        end

        -- cast ray down
        local to = cur_line
        for l = cur_line + 1, last_line do
          if get_indent(l) < indent then break end
          to = l
        end

        -- trim trailing blank lines from body
        while to > from and vim.fn.getline(to):match('^%s*$') do to = to - 1 end
        -- trim leading blank lines from body
        while from < to and vim.fn.getline(from):match('^%s*$') do from = from + 1 end

        if ai_type == 'a' then
          -- include border line above (skip blank lines)
          for l = from - 1, 1, -1 do
            if not vim.fn.getline(l):match('^%s*$') then
              from = l
              break
            end
          end
        end

        -- Use linewise selection via region_type
        local to_col = vim.fn.col({ to, '$' }) - 1
        if to_col < 1 then to_col = 1 end

        return {
          from = { line = from, col = 1 },
          to = { line = to, col = to_col },
          vis_mode = 'V',
        }
      end,
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

