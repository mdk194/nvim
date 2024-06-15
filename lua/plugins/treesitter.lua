local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  -- version = 'v0.8.5.2',
  cond = IS_SMALL_FILE,
  event = { "BufReadPost", "BufNewFile" },
  pin = true,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'RRethy/nvim-treesitter-endwise',
    'windwp/nvim-ts-autotag',
  },
}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "bash", "c", "cpp", "cmake", "comment", "lua", "rust", "python", "go", "gomod", "proto", "help", "http", "hcl", "html", "java", "javascript", "json", "jsdoc", "make", "yaml", "graphql", "css", "diff", "markdown", "markdown_inline", "sql", "toml", "tsx", "typescript", "vue", "regex" },
    ignore_install = {},
    highlight = {
      enable = true,
      disable = function(_, bufnr)
        return vim.api.nvim_buf_line_count(bufnr) > 3000
      end,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<a-v>",
        scope_incremental = "gss",
        node_incremental = "gsn",
        node_decremental = "<BS>",
      },
    },
    endwise = { enable = true },
    indent = { enable = false },
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ib"] = "@block.inner",
          ["ab"] = "@block.outer",
          ["ir"] = "@parameter.inner",
          ["ar"] = "@parameter.outer",
        },
      },
      swap = {
        enable = false,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      -- show textobject surrounding definition as determined
      -- using Neovim's built-in LSP in a floating windows
      -- Press shortcut twice to enter the floating window
      lsp_interop = {
        enable = false,
        -- border = 'none',
        peek_definition_code = {
          ["<leader>pf"] = "@function.outer",
          ["<leader>pc"] = "@class.outer",
        },
      },
    },
  })

  require('treesitter-context').setup{
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

  -- jump to context
  vim.keymap.set("n", "[s", function() require("treesitter-context").go_to_context(vim.v.count1) end, { silent = true })
  vim.cmd([[highlight TreesitterContext gui=bold guibg=#203F2A]])

  require("nvim-ts-autotag").setup()

end

return M
