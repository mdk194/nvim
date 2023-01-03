local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  -- event = 'BufReadPost',
  version = 'v0.8.0',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'RRethy/nvim-treesitter-endwise',
    'windwp/nvim-ts-autotag',
  },
}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "bash", "c", "cpp", "cmake", "comment", "lua", "rust", "python", "go", "hcl", "html", "java", "javascript", "json", "make", "typescript", "yaml" },
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
        init_selection = "<CR>",
        scope_incremental = "<CR>",
        node_incremental = "<TAB>",
        node_decremental = "<S-TAB>",
      },
    },
    endwise = { enable = true },
    indent = { enable = false },
    autopairs = { enable = true },
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
        enable = true,
        -- border = 'none',
        peek_definition_code = {
          ["<leader>pf"] = "@function.outer",
          ["<leader>pc"] = "@class.outer",
        },
      },
    },
  })

  require("nvim-ts-autotag").setup()

  vim.cmd [[set foldmethod=expr]]
  vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
  vim.cmd [[set foldlevelstart=5]]
end

return M
