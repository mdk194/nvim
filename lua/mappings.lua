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
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = ':Clear hlsearch' })

map("n", "\\", ",", { desc = "_Reverse char" })
-- map('n', '<space>', ':')

map("", "<leader>1", ":diffget LOCAL<CR>", { desc = ":Diffget LOCAL" })
map("", "<leader>2", ":diffget BASE<CR>", { desc = ":Diffget BASE" })
map("", "<leader>3", ":diffget REMOTE<CR>", { desc = ":Diffget REMOTE" })

map("n", "<leader><leader>", "<c-^>", { desc = "_Alternate buffer" })

-- clean trailing whitespace
map("n", "<F2>", [[mz:%s/\s\+$//<cr>:let @/=''<cr>`z]], { desc = ":Trim whitespace" })
map("n", "<F3>", "<cmd>Undotree<CR>", { desc = ":Undotree" })

-- kill windows
vim.keymap.set("n", "X", function()
  local win = vim.api.nvim_get_current_win()
  local cfg = vim.api.nvim_win_get_config(win)
  if cfg.relative ~= "" then
    vim.api.nvim_win_close(win, true)
  else
    vim.cmd("q")
  end
end, { noremap = true, desc = "_Close/quit" })

-- Wrapped lines goes down/up to next row, rather than next line in file.
map("n", "j", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true, desc = "_Down (wrapped)" })
map("n", "k", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true, desc = "_Up (wrapped)" })

-- -- moving between windows
-- map("n", "<c-h>", "<c-w>h")
-- map("n", "<c-l>", "<c-w>l")
-- map("n", "<c-k>", "<c-w>k")
-- map("n", "<c-j>", "<c-w>j")

-- Keep search matches in the middle of the window.
-- zz centers the screen on the cursor, zv unfolds any fold if the cursor
-- suddenly appears inside a fold.
map("n", "*", "*zzzv", { desc = "_Search forward" })
map("n", "#", "#zzzv", { desc = "_Search backward" })
map("n", "n", "nzzzv", { desc = "_Next match" })
map("n", "N", "Nzzzv", { desc = "_Prev match" })

-- Change word under cursor and dot repeat
map("n", "c*", "*Ncgn", { desc = "_Change forward" })
map("n", "c#", "#NcgN", { desc = "_Change backward" })

-- Also center the screen when jumping through the change list
map("n", "g;", "g;zz", { desc = "_Prev change" })
map("n", "g,", "g,zz", { desc = "_Next change" })
map("n", "<c-i>", "<c-i>zz", { desc = "_Jump forward" })
map("n", "<c-o>", "<c-o>zz", { desc = "_Jump backward" })

map("c", "<c-j>", "<down>", { desc = "_Cmd next" })
map("c", "<c-k>", "<up>", { desc = "_Cmd prev" })

map("n", "D", "d$", { desc = "_Delete to EOL" })

-- Uppercase word
map("i", "<c-c>", "<esc>mzgUiw`za", { desc = "_Uppercase word" })

-- Keep the cursor in place while joining lines
map("n", "J", "mzJ`z", { desc = "_Join lines" })


-- Split line (sister to [J]oin lines)
-- The normal use of S is covered by cc, so don't worry about shadowing it.
map("n", "S", "i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w", { desc = ":Split line" })

-- Using '<' and '>' in visual mode to shift code by a tab-width left/right by
-- default exits visual mode. With this mapping we remain in visual mode after
-- such an operation.
map("v", "<", "<gv", { desc = "_Indent left" })
map("v", ">", ">gv", { desc = "_Indent right" })

-- first, last
map("n", "(", "^", { desc = "_Line start" })
map("n", ")", "$", { desc = "_Line end" })
map("v", ")", "g_", { desc = "_Last non-blank" })

-- dot work over visual line selections
map("x", ".", ":norm.<CR>", { desc = ":Dot visual" })

-- macro in visual line selections
map("x", "Q", [[:'<,'>:normal @q<CR>]], { desc = ":Macro on selection" })

-- vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float()]]
vim.api.nvim_set_keymap("n", "<space>d", [[<cmd>lua vim.diagnostic.open_float()<CR>]], { noremap = true, silent = true, desc = ":Diagnostic float" })
vim.api.nvim_set_keymap('n', '<C-q>', [[<cmd>cwindow<CR>]], { noremap = true, silent = true, desc = ":Toggle quickfix" })

-- Copy/paste with system clipboard
vim.keymap.set({ 'n', 'x' }, 'y', '"+y', { desc = '_Copy clipboard' })
vim.keymap.set(  'n',        'Y', '"+y$', { desc = '_Copy to EOL' })
vim.keymap.set(  'n',        'yy', '"+yy', { desc = '_Copy line' })
vim.keymap.set(  'n',        'gp', '"+p', { desc = '_Paste clipboard' })
-- Paste in Visual with `P` to not copy selected text (`:h v_P`)
vim.keymap.set(  'x',        'gp', '"+P', { desc = '_Paste clipboard' })

-- Reselect latest changed, put, or yanked text
vim.keymap.set('n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"', { expr = true, replace_keycodes = false, desc = '_Select changed' })

-- Alternative way to save and exit in Normal mode.
-- Adding `redraw` helps with `cmdheight=0` if buffer is not modified
map("n", "<leader>w", ":wa | redraw<CR>", { desc = ":Write all" })
vim.keymap.set(  'n',        '<C-S>', '<Cmd>silent! update | redraw<CR>',      { desc = ':Save' })
vim.keymap.set({ 'i', 'x' }, '<C-S>', '<Esc><Cmd>silent! update | redraw<CR>', { desc = ':Save + normal' })

