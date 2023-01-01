local M = {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    -- "hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    -- "hrsh7th/cmp-cmdline',
    -- "lukas-reineke/cmp-rg',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'ray-x/cmp-treesitter',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    {'L3MON4D3/LuaSnip', version = 'v1.*'} -- Snippets plugin
  },
}

function M.config()
  local cmp = require('cmp')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local luasnip = require('luasnip')
  require('luasnip.loaders.from_vscode').lazy_load()
  local icons = require('icons')

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    formatting = {
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format('%s', icons.code[vim_item.kind])
        -- Source
        vim_item.menu = ({
          buffer = "B",
          nvim_lsp = "LSP",
          luasnip = "Snip",
          nvim_lua = "Lua",
          latex_symbols = "LaTeX",
          nvim_lsp_signature_help = "S",
          path = "P",
          treesitter = "TS",
        })[entry.source.name]
        return vim_item
      end
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = "nvim_lsp_signature_help" },
      { name = 'treesitter' },
      { name = 'luasnip'},
      { name = 'path' },
      -- { name = "buffer", keyword_length = 5 },
      -- { name = "rg", keyword_length = 5 },
    })
  })

  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return M
