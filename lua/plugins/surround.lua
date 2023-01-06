local M = {
  'kylechui/nvim-surround',
  version = '*',
  event = 'VeryLazy',
}

function M.config()
  require("nvim-surround").setup({
    aliases = {
      ["a"] = ">",
      ["b"] = ")",
      ["B"] = "}",
      ["r"] = "]",
      ["q"] = { '"', "'", "`" },
      ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
    },
    keymaps = {
      -- key end in _line -> new line, end in _cur -> current line
      insert = "<c-g>s",
      insert_line = "<C-g>S",
      normal = "ys",
      normal_cur = "yss",
      normal_line = "yS",
      normal_cur_line = "ySS",
      visual = "S",
      visual_line = "gS",
      delete = "ds",
      change = "cs",
    },
  })
end

return M
