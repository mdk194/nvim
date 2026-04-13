vim.cmd("highlight clear")
vim.g.colors_name = "mdk-base8"
vim.o.termguicolors = true

local hl = function(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

-- palette (8 colors)
local bg         = "#232521"
local cursorline = "#34302C"
local border     = "#887663"
local comment    = "#859E89"
local fg         = "#ECE1D7"
local red        = "#CF5454"
local yellow     = "#EBC06D"
local keyword    = "#E67E40"

-- aliases (merged into 8)
local visual   = cursorline
local blue     = comment
local tan      = border
local cyan     = comment
local orange   = keyword
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
hl("TabLineSel",    { fg = yellow, bg = cursorline })
hl("TabLineFill",   { fg = comment, bg = cursorline })
hl("Visual",        { bg = visual })
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
hl("DiffAdd",       { bg = cursorline })
hl("DiffDelete",    { fg = red, bg = bg, bold = true })
hl("DiffChange",    { bg = cursorline })
hl("DiffText",      { fg = yellow, bg = cursorline })
hl("Added",         { fg = comment })
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
hl("DiagnosticOk",            { fg = comment })
hl("DiagnosticFloatingError", { fg = red, bg = cursorline })
hl("DiagnosticFloatingWarn",  { fg = keyword, bg = cursorline })
hl("DiagnosticFloatingInfo",  { fg = cyan, bg = cursorline })
hl("DiagnosticFloatingHint",  { fg = tan, bg = cursorline })
hl("DiagnosticFloatingOk",    { fg = comment, bg = cursorline })
hl("DiagnosticUnderlineError",{ underline = true, sp = red })
hl("DiagnosticUnderlineWarn", { underline = true, sp = keyword })
hl("DiagnosticUnderlineInfo", { underline = true, sp = cyan })
hl("DiagnosticUnderlineHint", { underline = true, sp = tan })
hl("DiagnosticUnderlineOk",   { underline = true, sp = comment })

-- syntax
hl("Comment",       { fg = comment, italic = true })
hl("Constant",      { fg = orange })
hl("Number",        { fg = orange })
hl("Boolean",       { fg = orange, bold = true })
hl("Float",         { fg = orange })
hl("Character",     { fg = red })
hl("String",        { fg = comment })
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
hl("RenderMarkdownH1Bg", { bg = cursorline, bold = true })
hl("RenderMarkdownH2Bg", { bg = cursorline, bold = true })
hl("RenderMarkdownH3Bg", { bg = cursorline, bold = true })
hl("RenderMarkdownH4Bg", { bg = cursorline, bold = true })
hl("RenderMarkdownH5Bg", { bg = cursorline, bold = true })
hl("RenderMarkdownH6Bg", { bg = cursorline, bold = true })
hl("RenderMarkdownLink", { fg = blue, underline = true })

-- LSP
hl("LspReferenceText",  { bg = cursorline })
hl("@lsp.mod.deprecated", { fg = red })

-- terminal cursor
hl("TermCursor",    { reverse = true })

-- custom overrides
hl("TreesitterContext",    { bold = true, bg = cursorline })
hl("SnacksPickerMatch",   { fg = yellow, bold = true })
hl("SnacksIndentScope",   { fg = yellow })

-- blink.cmp
hl("BlinkCmpMenu",          { bg = bg })
hl("BlinkCmpMenuBorder",    { fg = orange, bg = bg })
hl("BlinkCmpMenuSelection", { bg = cursorline })
hl("BlinkCmpDoc",           { bg = bg })
hl("BlinkCmpDocBorder",     { fg = orange, bg = bg })
