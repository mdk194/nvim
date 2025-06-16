return {
  'Wansmer/treesj',
  keys = { 'gs', 'gj' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
      max_join_length = 150,
    })
    vim.keymap.set('n', 'gj', require('treesj').join)
    vim.keymap.set('n', 'gs', require('treesj').split)
  end,
}
