return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  ft = { 'markdown', 'md', 'codecompanion' },
  opts = {
    render_modes = { 'n', 'c', 't' },
    debounce = 200,
    max_file_size = 10.0,
    completions = { lsp = { enabled = true } },
    -- checkbox = { checked = { scope_highlight = '@markup.strikethrough' } },
    sign = { enabled = false },
    heading = { icons = { '󰲡  ', '󰲣  ', '󰲥  ', '󰲧  ', '󰲩  ', '󰲫  ' }, position = 'inline' },
    code = { sign = false },
    yaml = { enabled = false },
  },
}
