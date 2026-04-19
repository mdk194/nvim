vim.cmd("highlight clear")
vim.g.colors_name = "cold-light"
vim.o.termguicolors = true

local hl = function(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

-- palette (16 colors) — desert storm, warm cream light
local bg       = "#F0E8DC"
local cursorline      = "#E4DCD0"
local comment  = "#6A6480"
local border  = "#746476"
local fg       = "#1C1828"
local red      = "#B24545"
local yellow   = "#7D6718"
local blue     = "#4858A0"
local tan      = "#886040"
local keyword  = "#A1551F"
local diff_bg  = "#D8ECF0"
local diff_del = "#F0D8D5"
local diff_chg = "#E0DCE8"
local diff_fg  = "#257096"
local context  = "#D0D8E8"

-- aliases
local orange   = keyword
local cyan     = diff_fg
local salmon   = red
local float_bg = cursorline

-- editor
hl("Normal",        { fg = fg })
hl("NormalNC",      {})
hl("NormalFloat",   { fg = fg, bg = bg })
hl("FloatBorder",   { fg = orange, bg = bg })
hl("FloatTitle",    { fg = tan, bold = true })
hl("Cursor",        { fg = bg, bg = fg })
hl("lCursor",       { fg = bg, bg = fg })
hl("CursorIM",      { fg = bg, bg = fg })
hl("CursorLine",    { bg = cursorline })
hl("CursorColumn",  { fg = bg, bg = float_bg })
hl("ColorColumn",   { bg = cursorline })
hl("LineNr",        { fg = comment })
hl("LineNrAbove",   { fg = comment })
hl("LineNrBelow",   { fg = comment })
hl("CursorLineNr",  { fg = border, bold = true })
hl("CursorLineSign",{ fg = comment })
hl("CursorLineFold", { fg = cyan })
hl("SignColumn",    {})
hl("FoldColumn",    { fg = cyan })
hl("Folded",        { fg = comment, bg = cursorline })
hl("VertSplit",     { fg = bg, bg = bg })
hl("WinSeparator",  { fg = bg, bg = bg })
hl("MsgSeparator",  { fg = bg, bg = bg })
hl("StatusLine",    { fg = border, bg = cursorline, reverse = true })
hl("StatusLineNC",  { fg = comment, bg = cursorline, bold = true, underline = true })
hl("WinBar",        { fg = border, bg = cursorline, bold = true })
hl("WinBarNC",      { fg = comment, bg = cursorline, bold = true })
hl("TabLine",       { fg = comment, bg = cursorline })
hl("TabLineSel",    { fg = blue, bg = cursorline })
hl("TabLineFill",   { fg = comment, bg = cursorline })
hl("Visual",        { bg = "#D8D0C4" })
hl("VisualNOS",     { fg = red })
hl("Search",        { fg = cursorline, bg = yellow })
hl("IncSearch",     { fg = cursorline, bg = orange })
hl("CurSearch",     { fg = cursorline, bg = orange })
hl("Substitute",    { fg = cursorline, bg = yellow })
hl("MatchParen",    { bg = cursorline, bold = true, underline = true })
hl("Whitespace",    { fg = bg })
hl("NonText",       { fg = comment })
hl("SpecialKey",    { fg = comment })
hl("EndOfBuffer",   { fg = comment })
hl("Directory",     { fg = tan })
hl("Conceal",       { fg = tan })
hl("Title",         { fg = tan, bold = true })
hl("Question",      { fg = tan })
hl("MoreMsg",       { fg = blue })
hl("ModeMsg",       { fg = blue })
hl("OkMsg",         { fg = blue })
hl("ErrorMsg",      { fg = red })
hl("WarningMsg",    { fg = red })
hl("WildMenu",      { fg = red, bg = yellow })
hl("QuickFixLine",  { bg = cursorline })

-- popup menu
hl("Pmenu",         { fg = fg, bg = cursorline })
hl("PmenuSel",      { bg = cursorline })
hl("PmenuMatch",    { fg = fg, bold = true })
hl("PmenuMatchSel", { fg = fg, bold = true, reverse = true })
hl("PmenuSbar",     { bg = cursorline })
hl("PmenuThumb",    { bg = fg })

-- diff
hl("DiffAdd",       { bg = diff_bg })
hl("DiffDelete",    { fg = red, bg = diff_del, bold = true })
hl("DiffChange",    { bg = diff_chg })
hl("DiffText",      { fg = diff_fg, bg = diff_bg })
hl("Added",         { fg = blue })
hl("Removed",       { fg = red })
hl("Changed",       { fg = keyword })

-- spell
hl("SpellBad",      { undercurl = true, sp = red })
hl("SpellCap",      { undercurl = true, sp = tan })
hl("SpellRare",     { undercurl = true, sp = keyword })
hl("SpellLocal",    { undercurl = true, sp = cyan })

-- diagnostics
hl("DiagnosticError",         { fg = red, bold = true, italic = true })
hl("DiagnosticWarn",          { fg = keyword, bold = true, italic = true })
hl("DiagnosticInfo",          { fg = cyan, italic = true })
hl("DiagnosticHint",          { fg = tan, italic = true })
hl("DiagnosticOk",            { fg = blue })
hl("DiagnosticFloatingError", { fg = red, bg = cursorline })
hl("DiagnosticFloatingWarn",  { fg = keyword, bg = cursorline })
hl("DiagnosticFloatingInfo",  { fg = cyan, bg = cursorline })
hl("DiagnosticFloatingHint",  { fg = tan, bg = cursorline })
hl("DiagnosticFloatingOk",    { fg = blue, bg = cursorline })
hl("DiagnosticUnderlineError",{ underline = true, sp = red })
hl("DiagnosticUnderlineWarn", { underline = true, sp = keyword })
hl("DiagnosticUnderlineInfo", { underline = true, sp = cyan })
hl("DiagnosticUnderlineHint", { underline = true, sp = tan })
hl("DiagnosticUnderlineOk",   { underline = true, sp = blue })

-- syntax
hl("Comment",       { fg = comment, italic = true })
hl("Constant",      { fg = orange })
hl("Number",        { fg = orange })
hl("Boolean",       { fg = orange, bold = true })
hl("Float",         { fg = orange })
hl("Character",     { fg = red })
hl("String",        { fg = blue })
hl("Identifier",    { fg = red })
hl("Function",      { fg = tan })
hl("Statement",     { fg = red, bold = true })
hl("Keyword",       { fg = keyword })
hl("Conditional",   { fg = keyword })
hl("Repeat",        { fg = yellow })
hl("Label",         { fg = yellow })
hl("Operator",      { fg = fg })
hl("Exception",     { fg = red })
hl("Include",       { fg = tan })
hl("PreProc",       { fg = yellow })
hl("Define",        { fg = keyword })
hl("Macro",         { fg = red })
hl("PreCondit",     { fg = yellow })
hl("Type",          { fg = yellow })
hl("StorageClass",  { fg = yellow })
hl("Structure",     { fg = keyword })
hl("Typedef",       { fg = yellow })
hl("Special",       { fg = cyan })
hl("SpecialChar",   { fg = salmon })
hl("SpecialComment",{ fg = cyan })
hl("Tag",           { fg = yellow })
hl("Delimiter",     { fg = salmon })
hl("Debug",         { fg = red })
hl("Ignore",        { fg = cyan })
hl("Error",         { fg = bg, bg = red })
hl("Todo",          { fg = yellow, bg = cursorline, bold = true })
hl("Underlined",    { fg = blue, underline = true })

-- treesitter
hl("@variable",                { fg = fg })
hl("@variable.parameter",     { bold = true })
hl("@property",               { fg = fg })
hl("@comment",                { fg = comment, italic = true })
hl("@lsp.type.variable",      { fg = fg })
hl("@type.builtin",           { fg = keyword, bold = true })
hl("@constructor",             { fg = salmon })

-- markdown
hl("@markup.link",              { fg = blue, underline = true })
hl("@markup.link.label",        { fg = blue, underline = true })
hl("@markup.link.url",          { fg = blue, underline = true })

-- markdown headings (render-markdown.nvim)
hl("RenderMarkdownH1Bg", { bg = context, bold = true })
hl("RenderMarkdownH2Bg", { bg = context, bold = true })
hl("RenderMarkdownH3Bg", { bg = context, bold = true })
hl("RenderMarkdownH4Bg", { bg = context, bold = true })
hl("RenderMarkdownH5Bg", { bg = context, bold = true })
hl("RenderMarkdownH6Bg", { bg = context, bold = true })
hl("RenderMarkdownLink", { fg = blue, underline = true })

-- LSP
hl("LspReferenceText",  { bg = cursorline })
hl("@lsp.mod.deprecated", { fg = red })

-- terminal cursor
hl("TermCursor",    { reverse = true })

-- custom overrides
hl("TreesitterContext",    { bold = true, bg = context })
hl("SnacksPickerMatch",   { fg = yellow, bold = true })
hl("SnacksIndentScope",   { fg = yellow })

-- blink.cmp
hl("BlinkCmpMenu",          { bg = bg })
hl("BlinkCmpMenuBorder",    { fg = orange, bg = bg })
hl("BlinkCmpMenuSelection", { bg = cursorline })
hl("BlinkCmpDoc",           { bg = bg })
hl("BlinkCmpDocBorder",     { fg = orange, bg = bg })
