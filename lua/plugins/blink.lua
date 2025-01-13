return {
  'saghen/blink.cmp',
  dependencies = {
    -- { 'echasnovski/mini.icons', version = '*' },
    -- { 'rafamadriz/friendly-snippets' },
  },
  version = '*',

  opts = {
    -- 'default' for mappings similar to built-in completion
    keymap = { preset = 'super-tab' },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },

    sources = {
      default = { 'lsp', 'buffer' },
    },

    completion = {
      accept = {

      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      menu = {
        -- border = 'single',
        -- Don't show completion menu automatically in cmdline mode
        auto_show = function(ctx) return ctx.mode ~= 'cmdline' end,

        draw = {
          -- columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
          -- components = {
          --   kind_icon = {
          --     ellipsis = false,
          --     text = function(ctx)
          --       local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
          --       return kind_icon
          --     end,
          --     -- Optionally, you may also use the highlights from mini.icons
          --     highlight = function(ctx)
          --       local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
          --       return hl
          --     end,
          --   }
          -- }
        },
      },
      documentation = {
        -- window = { border = 'single' },
        auto_show = true,
        auto_show_delay_ms = 500,
        treesitter_highlighting = false,
      },
    },

    signature = {
      enabled = true,
      -- window = { border = 'single' },
    },

  },
  opts_extend = { "sources.default" }
}
