vim.g.mapleader = ","
vim.g.maplocalleader = ","

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- clear hlsearch
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

map("n", "\\", ",")
-- map('n', '<space>', ':')

map("", "<leader>1", ":diffget LOCAL<CR>")
map("", "<leader>2", ":diffget BASE<CR>")
map("", "<leader>3", ":diffget REMOTE<CR>")

map("n", "<leader><leader>", "<c-^>")
map("n", "<leader>w", ":wa<CR>")

-- clean trailing whitespace
map("n", "<F2>", [[mz:%s/\s\+$//<cr>:let @/=''<cr>`z]])

-- Spell check
map("n", "<F3>", ":set spell!<CR>", { silent = true })

map("n", "<F4>", ":SymbolsOutline<CR><c-w>=")

-- kill windows
map("n", "K", ":q<CR>")

-- Wrapped lines goes down/up to next row, rather than next line in file.
map("n", "j", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true })
map("n", "k", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true })

-- -- moving between windows
-- map("n", "<c-h>", "<c-w>h")
-- map("n", "<c-l>", "<c-w>l")
-- map("n", "<c-k>", "<c-w>k")
-- map("n", "<c-j>", "<c-w>j")

-- Keep search matches in the middle of the window.
-- zz centers the screen on the cursor, zv unfolds any fold if the cursor
-- suddenly appears inside a fold.
map("n", "*", "*zzzv")
map("n", "#", "#zzzv")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Change word under cursor and dot repeat
map("n", "c*", "*Ncgn")
map("n", "c#", "#NcgN")

-- Also center the screen when jumping through the change list
map("n", "g;", "g;zz")
map("n", "g,", "g,zz")
map("n", "<c-i>", "<c-i>zz")
map("n", "<c-o>", "<c-o>zz")

map("c", "<c-j>", "<down>")
map("c", "<c-k>", "<up>")

map("n", "D", "d$")

-- Uppercase word
map("i", "<c-l>", "<esc>mzgUiw`za")

-- Keep the cursor in place while joining lines
map("n", "J", "mzJ`z")

-- Split line (sister to [J]oin lines)
-- The normal use of S is covered by cc, so don't worry about shadowing it.
map("n", "S", "i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w")

-- Using '<' and '>' in visual mode to shift code by a tab-width left/right by
-- default exits visual mode. With this mapping we remain in visual mode after
-- such an operation.
map("v", "<", "<gv")
map("v", ">", ">gv")

-- first, last
map("n", "(", "^")
map("n", ")", "$")
map("v", ")", "g_")

-- dot work over visual line selections
map("x", ".", ":norm.<CR>")

-- macro in visual line selections
map("x", "Q", [[:'<,'>:normal @q<CR>]])

-- vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float()]]
vim.api.nvim_set_keymap("n", "<space>d", [[<cmd>lua vim.diagnostic.open_float()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', [[<cmd>cwindow<CR>]], { noremap = true, silent = true })

-- Copy/paste with system clipboard
vim.keymap.set({ 'n', 'x' }, 'y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set(  'n',        'Y', '"+y$')
vim.keymap.set(  'n',        'yy', '"+yy')
vim.keymap.set(  'n',        'gp', '"+p', { desc = 'Paste from system clipboard' })
-- Paste in Visual with `P` to not copy selected text (`:h v_P`)
vim.keymap.set(  'x',        'gp', '"+P', { desc = 'Paste from system clipboard' })

-- Reselect latest changed, put, or yanked text
vim.keymap.set('n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"', { expr = true, replace_keycodes = false, desc = 'Visually select changed text' })

-- Alternative way to save and exit in Normal mode.
-- Adding `redraw` helps with `cmdheight=0` if buffer is not modified
vim.keymap.set(  'n',        '<C-S>', '<Cmd>silent! update | redraw<CR>',      { desc = 'Save' })
vim.keymap.set({ 'i', 'x' }, '<C-S>', '<Esc><Cmd>silent! update | redraw<CR>', { desc = 'Save and go to Normal mode' })

