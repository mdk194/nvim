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
  vim.keymap.set({ 'n', 'x', 'o' }, 'lf', function() move.goto_next_start('@function.outer') end, { desc = 'ts: Next function' })
  vim.keymap.set({ 'n', 'x', 'o' }, 'hf', function() move.goto_previous_start('@function.outer') end, { desc = 'ts: Prev function' })
  vim.keymap.set({ 'n', 'x', 'o' }, 'lo', function() move.goto_next_start('@block.outer') end, { desc = 'ts: Next block' })
  vim.keymap.set({ 'n', 'x', 'o' }, 'ho', function() move.goto_previous_start('@block.outer') end, { desc = 'ts: Prev block' })

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

        -- Get line indent, handling blank lines (border = 'both': use min of neighbors)
        local function get_indent(line)
          local prev = vim.fn.prevnonblank(line)
          local prev_indent = vim.fn.indent(prev)
          if line == prev then return prev_indent end
          local next_indent = vim.fn.indent(vim.fn.nextnonblank(line))
          return math.min(prev_indent, next_indent)
        end

        -- try_as_border (border = 'both'): adjust reference line if on a border
        local prev_indent = get_indent(cur_line - 1)
        local cur_indent = get_indent(cur_line)
        local next_indent = get_indent(cur_line + 1)

        if not (prev_indent <= cur_indent and next_indent <= cur_indent) then
          if prev_indent <= next_indent then
            cur_line = cur_line + 1
          else
            cur_line = cur_line - 1
          end
        end

        -- Compute indent: min of cursor column and line indent (indent_at_cursor)
        local line_indent = get_indent(cur_line)
        local indent = math.min(cur_col, line_indent)
        if indent <= 0 then return nil end

        -- cast ray up
        local from = cur_line
        for l = cur_line - 1, 1, -1 do
          if get_indent(l) < indent then break end
          from = l
        end

        -- cast ray down
        local to = cur_line
        for l = cur_line + 1, vim.fn.line('$') do
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

        local to_col = vim.fn.col({ to, '$' }) - 1
        if to_col < 1 then to_col = 1 end

        return {
          from = { line = from, col = 1 },
          to = { line = to, col = to_col },
          vis_mode = 'V',
        }
      end,
      a = spec_treesitter({ a = '@parameter.outer', i = '@parameter.inner' }), -- function argument
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

