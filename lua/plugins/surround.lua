local M = {
  'kylechui/nvim-surround',
  version = '*',
}

function M.config()
  require("nvim-surround").setup({
    aliases = {
      ["a"] = ">",
      ["p"] = ")",
      ["c"] = "}",
      ["b"] = "]",
      ["q"] = { '"', "'", "`" },
      ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
    },
    keymaps = {
      -- key end in _line -> new line, end in _cur -> current line
      insert = "<C-g>s",
      insert_line = "<C-g>S",
      normal = "s",
      normal_cur = "ss",
      normal_line = "S",
      normal_cur_line = "SS",
      visual = "s",
      visual_line = "ss",
      delete = "ds",
      change = "cs",
    },
  })
end

return M
