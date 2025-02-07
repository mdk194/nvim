return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    explorer = {
      enabled = true,
    },
    picker = {
      enabled = false,
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["<BS>"] = "explorer_up",
                ["l"] = "confirm",
                ["h"] = "explorer_close", -- close directory
                ["a"] = "explorer_add",
                ["d"] = "explorer_del",
                ["r"] = "explorer_rename",
                ["c"] = "explorer_copy",
                ["m"] = "explorer_move",
                ["o"] = "explorer_open", -- open with system application
                ["P"] = "toggle_preview",
                ["y"] = "explorer_yank",
                ["u"] = "explorer_update",
                ["<CR>"] = "tcd",
                ["."] = "explorer_focus",
                ["I"] = "toggle_ignored",
                ["H"] = "toggle_hidden",
                ["Z"] = "explorer_close_all",
                ["]g"] = "explorer_git_next",
                ["[g"] = "explorer_git_prev",
              },
            },
          },
        }
      }
    },
    bigfile = {
      enabled = true,
      notify = true, -- show notification when big file detected
      size = 512 * 1024, -- 512KB
    },
    notifier = {
      enabled = true,
      timeout = 2000,
      top_down = false,
      style = "compact",
    },
    input = {},
    indent = {
      enabled = false,
      only_scope = true,
      chunk = { enabled = false },
    },
    scope = {
      enabled = false,
      -- absolute minimum size of the scope.
      -- can be less if the scope is a top-level single line scope
      min_size = 2,
      -- try to expand the scope to this size
      max_size = nil,
      edge = true, -- include the edge of the scope (typically the line above and below with smaller indent)
      siblings = false, -- expand single line scopes with single line siblings
      -- what buffers to attach to
      filter = function(buf)
        return vim.bo[buf].buftype == ""
      end,
      -- debounce scope detection in ms
      debounce = 30,
      treesitter = {
        -- detect scope based on treesitter.
        -- falls back to indent based detection if not available
        enabled = true,
        ---@type string[]|false
        blocks = {
          "function_declaration",
          "function_definition",
          "method_declaration",
          "method_definition",
          "class_declaration",
          "class_definition",
          "do_statement",
          "while_statement",
          "repeat_statement",
          "if_statement",
          "for_statement",
        },
      },
      -- These keymaps will only be set if the `scope` plugin is enabled.
      -- Alternatively, you can set them manually in your config,
      -- using the `Snacks.scope.textobject` and `Snacks.scope.jump` functions.
      keys = {
        textobject = {
          ii = {
            min_size = 1, -- allow single line scopes
            edge = false, -- don't include the edge
            treesitter = { enabled = false },
            desc = "inner scope",
          },
          ai = {
            min_size = 1, -- allow single line scopes
            edge = true, -- include the edge
            treesitter = { enabled = false },
            desc = "scope with edge",
          },
        },
        jump = {
          ["[i"] = {
            min_size = 1, -- allow single line scopes
            bottom = false,
            edge = true,
            treesitter = { enabled = false },
            desc = "jump to top edge of scope",
          },
          ["]i"] = {
            min_size = 1, -- allow single line scopes
            bottom = true,
            edge = true,
            treesitter = { enabled = false },
            desc = "jump to bottom edge of scope",
          },
        },
      },
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = false },
    words = {
      enabled = false,
      debounce = 250, -- time in ms to wait before updating
    },
    lazygit = { enabled = false },
    gitbrowse = { enabled = false },
    rename = { enabled = false },
    scratch = { enabled = false },
    terminal = { enabled = false },
    toggle = { enabled = false },
    dashboard = { enabled = false },
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      }
    },
  },
  keys = {
    { "<leader>uh",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    -- { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>ug", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    { "<leader>e",  function() Snacks.explorer.open() end, desc = "Explorer", mode = { "n", "t" } },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>ul")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>uL")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>ut")
        -- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>ui")
      end,
    })
    vim.api.nvim_create_autocmd("LspProgress", {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(vim.lsp.status(), "info", {
          id = "lsp_progress",
          title = "LSP Progress",
          opts = function(notif)
            notif.icon = ev.data.params.value.kind == "end" and " "
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
}

