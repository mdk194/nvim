-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tex" },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = "en_us"
  end,
})

-- Disable fold for big file
vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    if vim.api.nvim_buf_line_count(0) > 3000 then
      vim.opt_local.foldexpr = ''
      vim.opt_local.foldmethod = 'manual'
      vim.schedule(function() vim.cmd('normal! zX') end)
    end
  end
})

function Nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command("augroup " .. group_name)
    vim.api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command("augroup END")
  end
end

local autocmds = {
  filetype = {
    { "FileType make,gitconfig setlocal noexpandtab sw=8 sts=8 ts=8" },
    { "FileType gitcommit setlocal spell! spelllang=en_us" },
    { "FileType yaml,json setlocal expandtab sw=2 sts=2 ts=2" },
    { "FileType terraform setlocal expandtab sw=2 sts=2 ts=2" },
    { "FileType javascript,typescript,graphql setlocal expandtab sw=2 sts=2 ts=2" },
    { "FileType java setlocal expandtab sw=4 sts=4 ts=4" },
    { "FileType html setlocal expandtab sw=2 sts=2 ts=2" },
    { "FileType lua setlocal expandtab sw=2 sts=2 ts=2" },
    { "FileType qf setlocal colorcolumn=0 nolist nocursorline nowrap tw=0" },
    { "FileType go setlocal noexpandtab sw=8 sts=8 ts=8" },
    { "FileType go setlocal cindent formatoptions=cqlron cinoptions=:0,l1,t0,g0,(0" },
  },
  listchars = {
    { "InsertEnter", "*", ":set nolist" },
    { "InsertLeave", "*", ":set list" },
  },
  trailing = {
    { "InsertEnter", "*", ":set listchars-=trail:˽" },
    { "InsertLeave", "*", ":set listchars+=trail:˽" },
  },
  markdown = {
    { "BufRead", "*.{md,markdown,mdown}", "setf markdown" },
  },
  line_return = { -- go to last loc when opening a buffer
    {
      "BufReadPost",
      "*",
      [[
      if line("'\"") > 0 && line("'\"") <= line("$") |
        execute 'normal! g`"zvzz' |
      endif
    ]],
    },
  },
}
Nvim_create_augroups(autocmds)

