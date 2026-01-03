local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  cond = require("functions").is_small_file,
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },
}

function M.config()
  require("mason-lspconfig").setup({
    automatic_enable = false,
    ensure_installed = {
      "bashls",
      "clangd",
      "jsonls",
      "lua_ls",
      "graphql",
      "rust_analyzer",
      "basedpyright",
      "ruff",
      "kotlin_language_server",
    }
  })

  require("plugins.lsp.lsp")

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('M', vim.lsp.buf.hover, 'Hover Documentation')

      map('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
      map('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
      map('<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'List workspace folders')
      -- map('<leader>sw', [[<cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>]], '[W]orkspace [S]ymbols')
      map('<leader>ws', function() Snacks.picker.lsp_workspace_symbols() end, '[W]orkspace [S]ymbols')

      -- map('<leader>s', [[<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>]], 'Document [S]ymbols')
      map('<leader>s', function() Snacks.picker.lsp_symbols({tree = false}) end, 'Document [S]ymbols')

      -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      map('gD', function() Snacks.picker.lsp_declarations() end, '[G]oto [D]eclaration')

      -- map('gd', [[<cmd>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<CR>]], '[G]oto [D]efinition')
      map('gd', function() Snacks.picker.lsp_definitions() end, '[G]oto [D]efinition')

      -- map('gt', vim.lsp.buf.type_definition, '[T]ype Definition')
      map('gt', function() Snacks.picker.lsp_type_definitions() end, '[T]ype Definition')
      -- map('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      map('gi', function() Snacks.picker.lsp_implementations() end, '[G]oto [I]mplementation')

      -- map('gr', [[<cmd>lua require('fzf-lua').lsp_references({ jump_to_single_result = true, includeDeclaration = false })<CR>]], '[G]oto [R]eferences')
      map('gr', function() Snacks.picker.lsp_references() end, '[G]oto [R]eferences')
      map('gic', function() Snacks.picker.lsp_incoming_calls() end, 'Calls [i]ncoming')
      map('goc', function() Snacks.picker.lsp_outgoing_calls() end, 'Calls [o]utgoing')
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

      map('<leader>d', function() Snacks.picker.diagnostics_buffer() end, 'Diagnostics document')
      -- map('<leader>ss', function() Snacks.picker.lsp_symbols() end, 'LSP Symbols')
      -- map('<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, 'LSP Workspace Symbols')

      map('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
      map(']d', vim.diagnostic.goto_next, 'Next diagnostic')

      map('<space>a', vim.lsp.buf.code_action, 'Code Action')
      map('<space>s', vim.lsp.buf.signature_help, 'Signature Help')
      map('<space>f', '<cmd>lua vim.lsp.buf.format { async=true }<CR>', 'Format')
      -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async=true }' ]]

      -- inlay hints
      if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, '[T]oggle Inlay [H]ints')
      end

      -- codelens
      if client.server_capabilities.codeLensProvider then
        -- trigger now
        vim.lsp.codelens.refresh()

        -- trigger refresh on events as well
        vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
          buffer = event.buf,
          callback = vim.lsp.codelens.refresh,
        })

        map("<leader>a", vim.lsp.codelens.run, 'Codelen')
      end

      -- fold method
      if client:supports_method('textDocument/foldingRange') then
        local win = vim.api.nvim_get_current_win()
        vim.wo[win][0].foldmethod = 'expr'
        vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
      end
    end,
  })

  -- auto fold import
  vim.api.nvim_create_autocmd('LspNotify', {
    callback = function(args)
      if args.data.method == 'textDocument/didOpen' then
        vim.lsp.foldclose('imports', vim.fn.bufwinid(args.buf))
      end
    end,
  })
end

return M
