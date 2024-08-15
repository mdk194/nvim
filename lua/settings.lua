local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= "o" then
    scopes["o"][key] = value
  end
end

opt("o", "background", "dark")
opt("o", "completeopt", "menuone,noinsert,noselect")
opt("o", "complete", ".,t") -- ins-completion scan only current buffer and tag
opt("o", "virtualedit", "block") -- Allow going past the end of line in visual block mode
opt("o", "hidden", true)
opt("o", "showmode", false)
opt("o", "scrolloff", 5)
opt("o", "sidescrolloff", 5)
opt("o", "shiftround", true)
opt("o", "splitbelow", true)
opt("o", "splitright", true)
opt("o", "termguicolors", true)
opt("o", "guicursor", "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait500-blinkoff500-blinkon500") -- block in normal, visual, beam cursor in insert mode
opt("o", "showmatch", true)
opt("o", "wildmenu", true)
opt("o", "wildmode", "longest,list,full")
-- opt('o', 'showbreak', '↳ ')
opt("o", "showcmd", true)
opt("o", "smarttab", true)
opt("o", "magic", true)
opt("o", "dictionary", "/usr/share/dict/words")
opt("o", "mouse", "a")
opt("o", "shortmess", "aoOtTIcCF")
opt("o", "whichwrap", "b,s,<,>,h,l")
opt("o", "hlsearch", true)
opt("o", "ignorecase", true) -- Ignore case when searching (use `\C` to force not doing that)
opt("o", "smartcase", true)
opt("o", "incsearch", true)
opt("o", "formatoptions", "qjl1") -- Don't autoformat comments
opt("o", "autowrite", true)
opt("o", "laststatus", 0) -- 2 to show statusline
opt("o", "cmdheight", 1) -- 0 to disable cmd bar
-- opt("o", "clipboard", "unnamed,unnamedplus")
opt("o", "spell", false)
opt("o", "spelllang", "en_us")
opt("o", "synmaxcol", 200)
opt("o", "ttimeoutlen", 50)
opt("o", "backspace", "indent,eol,start")
opt("o", "cursorcolumn", false)
opt("o", "cursorline", false)
opt("o", "undofile", false) -- see also :h undodir
opt("o", "ruler", true)
opt("o", "title", true)
opt("o", "fileformat", "unix")
opt("o", "fileformats", "unix,mac,dos")
opt("o", "autoindent", false)
opt("o", "updatetime", 250)
opt("o", "foldlevelstart", 5)
opt("o", "foldmethod", "expr")
opt("o", "foldexpr", "nvim_treesitter#foldexpr()")

opt("b", "swapfile", false)
opt("b", "expandtab", true)
opt("b", "tabstop", 8)
opt("b", "shiftwidth", 4)
opt("b", "softtabstop", 4)
opt("b", "infercase", true) -- Infer letter cases for the built-in keyword completion
opt("b", "smartindent", true)
opt("b", "iskeyword", "_,-,$,@,%,#")

opt("w", "list", true)
opt("w", "listchars", "tab:▸ ,nbsp:_,extends:❯,precedes:❮")
opt("w", "number", true)
opt("w", "relativenumber", false)
opt("w", "wrap", true)
opt("w", "breakindent", true)

vim.opt.diffopt:append('algorithm:patience,indent-heuristic,vertical')

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

vim.opt.titlelen = 120
function _G.titlestring()
  vim.o.titlestring = "  %{substitute(getcwd(),$HOME,'~','')}  %f %{v:lua.statusline_diagnostic()}%w%r%m%y"
end
_G.titlestring()

vim.o.rulerformat = '%50(%=%{v:lua.statusline_diagnostic()}%m%r%{&spell?"[S]":""} %f%)'

-- no sign column icon, just text effect
-- text effects are defined in colorscheme
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" , linehl = "", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" , linehl = "", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "DiagnosticSignInfo" })

