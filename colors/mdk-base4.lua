vim.cmd("highlight clear")
vim.g.colors_name = "mdk-base4"
vim.o.termguicolors = true

local hl = function(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

-- palette (4 colors)
local bg      = "#2A2520"
local dim     = "#867462"
local fg      = "#ECE1D7"
local accent  = "#E67E40"

-- aliases (everything mapped to 4)
local cursorline = bg
local visual     = dim
local border     = dim
local comment    = dim
local red        = accent
local yellow     = accent
local blue       = dim
local tan        = fg
local keyword    = accent
local orange     = accent
local cyan       = dim
local salmon     = accent
local float_bg   = bg

-- editor
hl("Normal",        { fg = fg })
hl("NormalNC",      {})
hl("NormalFloat",   { fg = fg, bg = bg })
hl("FloatBorder",   { fg = accent, bg = bg })
hl("FloatTitle",    { fg = fg, bold = true })
hl("Cursor",        { fg = bg, bg = fg })
hl("lCursor",       { fg = bg, bg = fg })
hl("CursorIM",      { fg = bg, bg = fg })
hl("CursorLine",    { underline = true })
hl("CursorColumn",  { bg = bg })
hl("ColorColumn",   { bg = bg })
hl("LineNr",        { fg = dim })
hl("LineNrAbove",   { fg = dim })
hl("LineNrBelow",   { fg = dim })
hl("CursorLineNr",  { fg = fg, bold = true })
hl("CursorLineSign",{ fg = dim })
hl("CursorLineFold", { fg = dim })
hl("SignColumn",    {})
hl("FoldColumn",    { fg = dim })
hl("Folded",        { fg = dim })
hl("VertSplit",     { fg = bg, bg = bg })
hl("WinSeparator",  { fg = bg, bg = bg })
hl("MsgSeparator",  { fg = bg, bg = bg })
hl("StatusLine",    { fg = fg, bg = bg, reverse = true })
hl("StatusLineNC",  { fg = dim, bg = bg, bold = true, underline = true })
hl("WinBar",        { fg = dim, bg = bg, bold = true })
hl("WinBarNC",      { fg = dim, bg = bg, bold = true })
hl("TabLine",       { fg = dim, bg = bg })
hl("TabLineSel",    { fg = accent, bg = bg })
hl("TabLineFill",   { fg = dim, bg = bg })
hl("Visual",        { reverse = true })
hl("VisualNOS",     { fg = accent })
hl("Search",        { fg = bg, bg = accent })
hl("IncSearch",     { fg = bg, bg = accent })
hl("CurSearch",     { fg = bg, bg = accent })
hl("Substitute",    { fg = bg, bg = accent })
hl("MatchParen",    { bold = true, underline = true })
hl("Whitespace",    { fg = dim })
hl("NonText",       { fg = dim })
hl("SpecialKey",    { fg = dim })
hl("EndOfBuffer",   { fg = dim })
hl("Directory",     { fg = fg })
hl("Conceal",       { fg = dim })
hl("Title",         { fg = fg, bold = true })
hl("Question",      { fg = fg })
hl("MoreMsg",       { fg = dim })
hl("ModeMsg",       { fg = dim })
hl("OkMsg",         { fg = dim })
hl("ErrorMsg",      { fg = accent })
hl("WarningMsg",    { fg = accent })
hl("WildMenu",      { fg = bg, bg = accent })
hl("QuickFixLine",  { bg = bg })

-- popup menu
hl("Pmenu",         { fg = fg, bg = bg })
hl("PmenuSel",      { reverse = true })
hl("PmenuMatch",    { fg = accent, bold = true })
hl("PmenuMatchSel", { fg = accent, bold = true, reverse = true })
hl("PmenuSbar",     { bg = bg })
hl("PmenuThumb",    { bg = fg })

-- diff
hl("DiffAdd",       { fg = fg, bold = true })
hl("DiffDelete",    { fg = accent, bold = true })
hl("DiffChange",    { fg = dim })
hl("DiffText",      { fg = accent, underline = true })
hl("Added",         { fg = dim })
hl("Removed",       { fg = accent })
hl("Changed",       { fg = accent })

-- spell
hl("SpellBad",      { undercurl = true, sp = accent })
hl("SpellCap",      { undercurl = true, sp = dim })
hl("SpellRare",     { undercurl = true, sp = accent })
hl("SpellLocal",    { undercurl = true, sp = dim })

-- diagnostics
hl("DiagnosticError",         { fg = accent, bold = true, italic = true })
hl("DiagnosticWarn",          { fg = accent, bold = true, italic = true })
hl("DiagnosticInfo",          { fg = dim, italic = true })
hl("DiagnosticHint",          { fg = dim, italic = true })
hl("DiagnosticOk",            { fg = dim })
hl("DiagnosticFloatingError", { fg = accent })
hl("DiagnosticFloatingWarn",  { fg = accent })
hl("DiagnosticFloatingInfo",  { fg = dim })
hl("DiagnosticFloatingHint",  { fg = dim })
hl("DiagnosticFloatingOk",    { fg = dim })
hl("DiagnosticUnderlineError",{ underline = true, sp = accent })
hl("DiagnosticUnderlineWarn", { underline = true, sp = accent })
hl("DiagnosticUnderlineInfo", { underline = true, sp = dim })
hl("DiagnosticUnderlineHint", { underline = true, sp = dim })
hl("DiagnosticUnderlineOk",   { underline = true, sp = dim })

-- syntax
hl("Comment",       { fg = dim, italic = true })
hl("Constant",      { fg = accent })
hl("Number",        { fg = accent })
hl("Boolean",       { fg = accent, bold = true })
hl("Float",         { fg = accent })
hl("Character",     { fg = accent })
hl("String",        { fg = dim })
hl("Identifier",    { fg = fg })
hl("Function",      { fg = fg })
hl("Statement",     { fg = accent })
hl("Keyword",       { fg = accent })
hl("Conditional",   { fg = accent })
hl("Repeat",        { fg = accent })
hl("Label",         { fg = accent })
hl("Operator",      { fg = fg })
hl("Exception",     { fg = accent })
hl("Include",       { fg = fg })
hl("PreProc",       { fg = accent })
hl("Define",        { fg = accent })
hl("Macro",         { fg = accent })
hl("PreCondit",     { fg = accent })
hl("Type",          { fg = fg })
hl("StorageClass",  { fg = accent })
hl("Structure",     { fg = accent })
hl("Typedef",       { fg = fg })
hl("Special",       { fg = dim })
hl("SpecialChar",   { fg = accent })
hl("SpecialComment",{ fg = dim })
hl("Tag",           { fg = accent })
hl("Delimiter",     { fg = dim })
hl("Debug",         { fg = accent })
hl("Ignore",        { fg = dim })
hl("Error",         { fg = bg, bg = accent })
hl("Todo",          { fg = accent, bold = true })
hl("Underlined",    { underline = true })

-- treesitter
hl("@variable",                { fg = fg })
hl("@variable.parameter",     { bold = true })
hl("@property",               { fg = fg })
hl("@comment",                { fg = dim, italic = true })
hl("@lsp.type.variable",      { fg = fg })
hl("@type.builtin",           { fg = accent, bold = true })
hl("@constructor",             { fg = dim })

-- LSP
hl("LspReferenceText",  { underline = true })
hl("@lsp.mod.deprecated", { fg = accent })

-- terminal cursor
hl("TermCursor",    { reverse = true })

-- custom overrides
hl("TreesitterContext",    { bold = true })
hl("SnacksPickerMatch",   { fg = accent, bold = true })
hl("SnacksIndentScope",   { fg = accent })

-- blink.cmp
hl("BlinkCmpMenu",          { bg = bg })
hl("BlinkCmpMenuBorder",    { fg = accent, bg = bg })
hl("BlinkCmpMenuSelection", { reverse = true })
hl("BlinkCmpDoc",           { bg = bg })
hl("BlinkCmpDocBorder",     { fg = accent, bg = bg })
