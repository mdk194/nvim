return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    explorer = {
      enabled = false,
    },
    picker = {
      enabled = true,
      ui_select = true,
      debug = {
        scores = false,
        grep = false,
        files = false,
      },
      formatters = {
        file = {
          truncate = 90, -- truncate the file path to (roughly) this length
        },
      },
      layout = {
        cycle = false,
        reverse = true,
        layout = {
          box = "vertical",
          backdrop = false,
          row = -1,
          width = 0,
          height = 0.6,
          border = "none",
          {
            win = "preview", title = "{preview:Preview}", width = 0, height = 0.5, border = "top", title_pos = "left",
            wo = { winhighlight = "NormalFloat:Normal", scrolloff = 0 },
          },
          {
            box = "vertical",
            {
              win = "list", title_pos = "left", border = "top",
              wo = { winhighlight = "NormalFloat:Normal", number = false, scrolloff = 0 },
            },
            {
              win = "input", height = 1, border = "top", title = "{title} {live} {flags}", title_pos = "left",
              wo = { winhighlight = "NormalFloat:Normal", number = false },
            },
          }
        },
      },
      win = {
        -- input window
        input = {
          keys = {
            -- to close the picker on ESC instead of going to normal mode,
            -- add the following keymap to your config
            -- ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["/"] = "toggle_focus",
            ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
            ["<C-Up>"] = { "history_back", mode = { "i", "n" } },
            ["<C-c>"] = { "close", mode = "i" },
            ["<CR>"] = { "confirm", mode = { "n", "i" } },
            ["<Down>"] = { "list_down", mode = { "i", "n" } },
            ["<Esc>"] = "close",
            ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
            ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
            ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
            ["<Up>"] = { "list_up", mode = { "i", "n" } },
            ["<c-x>"] = { "inspect", mode = { "n", "i" } },
            ["<c-f>"] = { "toggle_follow", mode = { "i", "n" } },
            ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<c-g>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<c-space>"] = { "toggle_maximize", mode = { "i", "n" } },
            ["<c-t>"] = { "toggle_preview", mode = { "i", "n" } },
            ["<c-w>"] = { "cycle_win", mode = { "i", "n" } },
            ["<c-a>"] = { "select_all", mode = { "n", "i" } },
            ["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
            ["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
            ["<c-l>"] = { "toggle_live", mode = { "i", "n" } },
            ["<c-n>"] = { "list_down", mode = { "i", "n" } },
            ["<c-p>"] = { "list_up", mode = { "i", "n" } },
            ["<c-q>"] = { "qflist", mode = { "i", "n" } },
            ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
            ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
            ["?"] = "toggle_help_input",
            ["G"] = "list_bottom",
            ["gg"] = "list_top",
            ["n"] = "list_down",
            ["p"] = "list_up",
            ["j"] = "preview_scroll_down",
            ["k"] = "preview_scroll_up",
            ["q"] = "close",

            -- disable
            ["<a-h>"] = false, -- disable
            ["<a-d>"] = false, -- disable
            ["<a-f>"] = false, -- disable
            ["<a-i>"] = false, -- disable
            ["<a-m>"] = false, -- disable
            ["<a-p>"] = false, -- disable
            ["<a-w>"] = false, -- disable
            ["<c-b>"] = false, -- disable
            ["<c-w>H"] = false, -- disable
            ["<c-w>J"] = false, -- disable
            ["<c-w>K"] = false, -- disable
            ["<c-w>L"] = false, -- disable
          },
        },
        -- result list window
        list = {
          keys = {
            ["/"] = "toggle_focus",
            ["<2-LeftMouse>"] = "confirm",
            ["<CR>"] = "confirm",
            ["<Down>"] = "list_down",
            ["<Esc>"] = "close",
            ["<S-CR>"] = { { "pick_win", "jump" } },
            ["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
            ["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
            ["<Up>"] = "list_up",
            ["<c-x>"] = "inspect",
            ["<c-f>"] = "toggle_follow",
            ["<c-h>"] = "toggle_hidden",
            ["<c-g>"] = "toggle_ignored",
            ["<c-space>"] = "toggle_maximize",
            ["<c-t>"] = "toggle_preview",
            ["<c-w>"] = "cycle_win",
            ["<c-a>"] = "select_all",
            ["<c-k>"] = "preview_scroll_up",
            ["<c-j>"] = "preview_scroll_down",
            ["<c-d>"] = "list_scroll_down",
            ["<c-n>"] = "list_down",
            ["<c-p>"] = "list_up",
            ["<c-s>"] = "edit_split",
            ["<c-u>"] = "list_scroll_up",
            ["<c-v>"] = "edit_vsplit",
            ["?"] = "toggle_help_list",
            ["G"] = "list_bottom",
            ["gg"] = "list_top",
            ["i"] = "focus_input",
            ["j"] = "list_down",
            ["k"] = "list_up",
            ["q"] = "close",
            ["zb"] = "list_scroll_bottom",
            ["zt"] = "list_scroll_top",
            ["zz"] = "list_scroll_center",

            -- disable
            ["<a-h>"] = false, -- disable
            ["<a-d>"] = false, -- disable
            ["<a-f>"] = false, -- disable
            ["<a-i>"] = false, -- disable
            ["<a-m>"] = false, -- disable
            ["<a-p>"] = false, -- disable
            ["<a-w>"] = false, -- disable
            ["<c-b>"] = false, -- disable
            ["<c-w>H"] = false, -- disable
            ["<c-w>J"] = false, -- disable
            ["<c-w>K"] = false, -- disable
            ["<c-w>L"] = false, -- disable
          },
        },
        -- preview window
        preview = {
          keys = {
            ["<Esc>"] = "close",
            ["q"] = "close",
            ["i"] = "focus_input",
            ["<ScrollWheelDown>"] = "list_scroll_wheel_down",
            ["<ScrollWheelUp>"] = "list_scroll_wheel_up",
            ["<c-w>"] = "cycle_win",
          },
        },
      },
      sources = {
        explorer = {
          config = function(opts)
            opts.layout = { reverse = false, preset = "sidebar", preview = false, auto_hide = {"input"} }
          end,
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
      notify = false, -- show notification when big file detected
      size = 512 * 1024, -- 512KB
      line_length = 1000,
    },
    notifier = {
      enabled = true,
      timeout = 2000,
      top_down = false,
      style = "compact",
    },
    input = { enabled = true },
    indent = { enabled = false, only_scope = true },
    chunk = { enabled = false },
    scope = { enabled = false },
    quickfile = { enabled = false },
    statuscolumn = { enabled = false },
    words = {
      enabled = false,
      debounce = 250, -- time in ms to wait before updating
    },
    lazygit = { enabled = true },
    git = { enabled = true },
    gitbrowse = {
      enabled = true,
      open = function(url)
        vim.fn.setreg("+", url)
        vim.notify("Copied: " .. url, "info", { id = "gitbrowse" })
      end,
      notify = false
    },
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
    { "<leader>uu", function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<leader>uh",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    -- { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>ug", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    -- { "<leader>e",  function() Snacks.explorer.open() end, desc = "Explorer", mode = { "n", "t" } },
    { "<c-f>",      function() Snacks.picker.files({matcher = {frecency = true, history_bonus = true}}) end, desc = "Find Files" },
    { "<c-p>",      function() require('functions').snack_picker('files', {matcher = {frecency = true, history_bonus = true}})() end, desc = "Find Files" },
    { "<leader>b",  function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>g",  function() require('functions').snack_picker('grep')() end, desc = "Grep" },
    { "<leader>/",  function() Snacks.picker.lines({layout = {reverse = false}}) end, desc = "Buffer Lines" },
    { "<leader>o", function() Snacks.picker.smart({multi = {"recent", "projects", "zoxide"}}) end, desc = "Recent files + project + zoxide" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>m", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>j", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>hh", function() Snacks.lazygit() end, desc = "LazyGits" },
    { "<leader>hu", function() Snacks.gitbrowse() end, desc = "Git browse" },
    { "<leader>hl", function() Snacks.git.blame_line() end, desc = "Git blame line" },
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

        -- _G.dd(Snacks.picker.config.get().win)
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

