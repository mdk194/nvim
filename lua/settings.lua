local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= "o" then
    scopes["o"][key] = value
  end
end

opt("o", "background", "dark")
opt("o", "completeopt", "menu,menuone,noselect")
opt("o", "hidden", true)
opt("o", "showmode", false)
opt("o", "scrolloff", 5)
opt("o", "sidescrolloff", 5)
opt("o", "shiftround", true)
opt("o", "splitbelow", true)
opt("o", "splitright", true)
opt("o", "termguicolors", true)
opt("o", "guicursor", "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50") -- block in normal, visual, beam cursor in insert mode
opt("o", "showmatch", true)
opt("o", "wildmenu", true)
opt("o", "wildmode", "longest,list,full")
-- opt('o', 'showbreak', '↳ ')
opt("o", "showcmd", true)
opt("o", "smarttab", true)
opt("o", "magic", true)
opt("o", "dictionary", "/usr/share/dict/words")
opt("o", "mouse", "a")
opt("o", "shortmess", "aoOtTIcF")
opt("o", "whichwrap", "b,s,<,>,h,l")
opt("o", "hlsearch", false)
opt("o", "ignorecase", true)
opt("o", "smartcase", true)
opt("o", "incsearch", true)
opt("o", "formatoptions", "rqnj1")
opt("o", "autowrite", true)
opt("o", "laststatus", 2) -- 2 to show statusline
opt("o", "cmdheight", 1) -- 0 to disable cmd bar
opt("o", "clipboard", "unnamed,unnamedplus")
opt("o", "spelllang", "en_us")
opt("o", "synmaxcol", 200)
opt("o", "ttimeoutlen", 20)
opt("o", "backspace", "indent,eol,start")
opt("o", "cursorcolumn", false)
opt("o", "cursorline", false)
opt("o", "undofile", false)
opt("o", "title", true)
opt("o", "titlestring", "%{substitute(getcwd(),$HOME,'~','')}") -- set title to cwd for tmux #T
opt("o", "fileformat", "unix")
opt("o", "fileformats", "unix,mac,dos")
opt("o", "pastetoggle", "<F1>")
opt("o", "autoindent", false)
opt("o", "updatetime", 250)
opt("o", "foldlevelstart", 5)

opt("b", "swapfile", false)
opt("b", "expandtab", true)
opt("b", "tabstop", 8)
opt("b", "shiftwidth", 4)
opt("b", "softtabstop", 4)
opt("b", "smartindent", false)
opt("b", "iskeyword", "_,-,$,@,%,#")

opt("w", "list", true)
opt("w", "listchars", "tab:▸ ,nbsp:_,extends:❯,precedes:❮")
opt("w", "signcolumn", "number")
opt("w", "number", true)
opt("w", "relativenumber", false)
opt("w", "wrap", true)
opt("w", "breakindent", true)

vim.opt.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
*/tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
]]

-- opt("o", "fillchars", "stl:-,stlnc: ")
function _G.statusline()
  local quickfix        = '%q'
  local paste           = [[%{&paste?'[PASTE] ':''}]]
  local buf_fn          = '%<%f '
  local modified_status = '%m'
  local readonly        = '%r'
  local preview         = '%w'
  local align_section   = '%='
  local column          = '%c '
  local file_type       = '%y'
  local not_unix        = [[%{&fileformat!='unix'?[&fileformat]:''}]]
  return quickfix..paste..buf_fn..modified_status..readonly..preview..align_section..column..file_type..not_unix
end
vim.cmd([[set statusline=%!v:lua.statusline()]])

vim.fn.sign_define("DiagnosticSignError", { text = "❎", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "❗", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "✋", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "💡", texthl = "DiagnosticSignHint" })
