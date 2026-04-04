local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  cond = require("functions").is_small_file,
  dependencies = {
    "saghen/blink.cmp",
  },
}

local function server_config()
  local capabilities = require('blink.cmp').get_lsp_capabilities({
    general = {
      positionEncodings = { "utf-8" },
    },
    textDocument = {
      completion = { completionItem = { snippetSupport = false } },
    },
  })

  vim.diagnostic.config({
    virtual_text = false,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
    },
  })

  local defaults = {
    capabilities = capabilities,
    showMessage = { messageActionItem = { additionalPropertiesSupport = true } },
    flags = { debounce_text_changes = 150 },
  }

  local servers = {
    bashls = {},
    clangd = {},
    lua_ls = require("plugins.lsp.lua"),
    jsonls = require("plugins.lsp.json"),
    gopls = require("plugins.lsp.gopls"),
    graphql = require("plugins.lsp.graphql"),
    ruff = require("plugins.lsp.ruff"),
    ty = {},
  }

  for name, opts in pairs(servers) do
    vim.lsp.config(name, vim.tbl_deep_extend("force", defaults, opts))
    vim.lsp.enable(name)
  end
end

function M.config()
  -- Remove default LSP keymaps (0.11+) that conflict with custom mappings
  for _, keys in ipairs({ 'grr', 'grn', 'gra', 'gri', 'grt', 'grx', 'gO' }) do
    pcall(vim.keymap.del, 'n', keys)
  end

  server_config()

  -- Patch codelens to display inline (eol) instead of virtual line above
  local Provider = getmetatable(vim.lsp.codelens._Provider) or {}
  if not Provider.__index then
    -- Get the Provider metatable by patching on_win via the module internals
    local codelens_mod = require('vim.lsp.codelens')
    -- Monkey-patch nvim_buf_set_extmark for codelens namespaces
    local orig_set_extmark = vim.api.nvim_buf_set_extmark
    vim.api.nvim_buf_set_extmark = function(bufnr, ns_id, row, col, opts)
      if opts and opts.virt_lines and opts.virt_lines_above then
        local ns_name = ''
        for name, id in pairs(vim.api.nvim_get_namespaces()) do
          if id == ns_id then ns_name = name break end
        end
        if ns_name:match('vim%.lsp%.codelens') then
          -- Convert virt_lines to eol virt_text
          local chunks = {}
          for _, chunk in ipairs(opts.virt_lines[1] or {}) do
            if chunk[1] ~= '' and not chunk[1]:match('^%s+$') then
              table.insert(chunks, chunk)
            end
          end
          if #chunks > 0 then
            table.insert(chunks, 1, { '  ', 'LspCodeLensSeparator' })
          end
          return orig_set_extmark(bufnr, ns_id, row, col, {
            virt_text = chunks,
            virt_text_pos = 'eol',
            hl_mode = 'combine',
          })
        end
      end
      return orig_set_extmark(bufnr, ns_id, row, col, opts)
    end
  end

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'lsp: ' .. desc })
      end

      -- K = hover is neovim 0.11+ default

      map('gwa', vim.lsp.buf.add_workspace_folder, 'Add folder')
      map('gwr', vim.lsp.buf.remove_workspace_folder, 'Remove folder')
      map('gwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'List folders')
      -- map('<leader>sw', [[<cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>]], 'Workspace symbols')
      map('gws', function() Snacks.picker.lsp_workspace_symbols() end, 'Workspace symbols')

      -- map('<leader>s', [[<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>]], 'Document symbols')
      map('<space>s', function() Snacks.picker.lsp_symbols({tree = false}) end, 'Document symbols')

      -- map('gD', vim.lsp.buf.declaration, 'Declaration')
      map('gD', function() Snacks.picker.lsp_declarations() end, 'Declaration')

      -- map('gd', [[<cmd>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<CR>]], 'Definition')
      map('gd', function() Snacks.picker.lsp_definitions() end, 'Definition')

      -- map('gt', vim.lsp.buf.type_definition, 'Type definition')
      map('gt', function() Snacks.picker.lsp_type_definitions() end, 'Type definition')
      -- map('gi', vim.lsp.buf.implementation, 'Implementation')
      map('gii', function() Snacks.picker.lsp_implementations() end, 'Implementation')

      map('gr', function() Snacks.picker.lsp_references() end, 'References')
      map('gic', function() Snacks.picker.lsp_incoming_calls() end, 'Incoming calls')
      map('goc', function() Snacks.picker.lsp_outgoing_calls() end, 'Outgoing calls')

      map('<space>D', function() Snacks.picker.diagnostics_buffer() end, 'Buffer diagnostics')

      map('[d', vim.diagnostic.goto_prev, 'Prev diagnostic')
      map(']d', vim.diagnostic.goto_next, 'Next diagnostic')

      map('<space>r', vim.lsp.buf.rename, 'Rename')
      map('<space>a', vim.lsp.buf.code_action, 'Code action')
      map('<space>S', function() vim.lsp.buf.signature_help({ border = "rounded" }) end, 'Signature help')
      map('<space>f', '<cmd>lua vim.lsp.buf.format { async=true }<CR>', 'Format')
      -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async=true }' ]]

      -- codelens (inline at end of line instead of virtual line above)
      if client.server_capabilities.codeLensProvider then
        vim.lsp.codelens.enable(true, { bufnr = event.buf })
        map("<space>x", vim.lsp.codelens.run, 'Codelens')
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
