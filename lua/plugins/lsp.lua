local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  cond = require("functions").is_small_file,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },
}

function M.config()
  require("mason-lspconfig").setup({})

  require("plugins.lsp.lsp")

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      -- setup mini-completion
      vim.bo[event.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'

      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('M', vim.lsp.buf.hover, 'Hover Documentation')

      map('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
      map('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
      map('<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'List workspace folders')

      map('<leader>s', [[<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>]], 'Document [S]ymbols')
      map('<leader>sw', [[<cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>]], '[W]orkspace [S]ymbols')

      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      map('gd', [[<cmd>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<CR>]], '[G]oto [D]efinition')
      map('gt', vim.lsp.buf.type_definition, '[T]ype Definition')
      map('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      map('gr', [[<cmd>lua require('fzf-lua').lsp_references({ jump_to_single_result = true, includeDeclaration = false })<CR>]], '[G]oto [R]eferences')
      map('gic', [[<cmd>lua require('fzf-lua').lsp_incoming_calls()<CR>]], '[G]o to [I]ncoming [C]all')
      map('goc', [[<cmd>lua require('fzf-lua').lsp_outgoing_calls()<CR>]], '[G]o to [O]utgoing [C]all')
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

      map('<leader>d', [[<cmd>lua require('fzf-lua').diagnostics_document()<CR>]], 'Diagnostics document')
      map('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
      map(']d', vim.diagnostic.goto_next, 'Next diagnostic')

      map('<space>a', vim.lsp.buf.code_action, 'Code Action')
      map('<space>s', vim.lsp.buf.signature_help, 'Signature Help')
      -- map('<space>f', '<cmd>lua vim.lsp.buf.format { async=true }<CR>', 'Format')
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
    end,
  })
end

return M
