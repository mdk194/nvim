M = {}

function M.custom_lsp_attach(_, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'M', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sw', [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]], opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', [[<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gic', [[<cmd>lua require('telescope.builtin').lsp_incoming_calls()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'goc', [[<cmd>lua require('telescope.builtin').lsp_outgoing_calls()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', [[<cmd>lua require('telescope.builtin').diagnostics()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ar', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format { async=true }<CR>', opts)
  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async=true }' ]]
end

return M
