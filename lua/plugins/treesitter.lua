local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  cond = require("functions").is_small_file,
  branch = 'main',
  lazy = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    'windwp/nvim-ts-autotag',
  },
}

function M.config()
  require("nvim-treesitter").setup()

  local parsers = { "bash", "c", "cpp", "cmake", "comment", "lua", "rust", "python", "go", "gomod", "proto", "http", "hcl", "html", "java", "javascript", "json", "jsdoc", "make", "yaml", "graphql", "css", "diff", "markdown", "markdown_inline", "sql", "toml", "tsx", "typescript", "vue", "regex", "query", "vimdoc" }
  require("nvim-treesitter").install(parsers)

  -- highlight is enabled by default in nvim 0.12, configure disable for large files
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      if vim.api.nvim_buf_line_count(args.buf) > 3000 then
        vim.treesitter.stop(args.buf)
      end
    end,
  })

  local tsc = require('treesitter-context')
  tsc.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 3, -- Maximum number of lines to show for a single context
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20, -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
  }
  Snacks.toggle({
    name = "Treesitter Context",
    get = tsc.enabled,
    set = function(state)
      if state then
        tsc.enable()
      else
        tsc.disable()
      end
    end,
  }):map("<leader>ut")

  -- jump to context
  vim.keymap.set("n", "(s", function() require("treesitter-context").go_to_context(vim.v.count1) end, { silent = true, desc = "ts: Go to context" })
  vim.cmd([[highlight TreesitterContext gui=bold guibg=#203F2A]])

  require("nvim-ts-autotag").setup()

end

return M
