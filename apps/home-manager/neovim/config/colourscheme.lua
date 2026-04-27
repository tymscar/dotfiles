local palette = {
  bg          = "#11140a",
  bg_mid      = "#1a1e12",
  bg_light    = "#283020",
  bg_lighter  = "#3a4230",
  fg          = "#f2f2f2",
  fg_dim      = "#b9b9b9",
  fg_dark     = "#8d8d8d",
  accent      = "#96aa6e",
  accent_dim  = "#869563",
  red         = "#fcaeae",
  red_dark    = "#c45a5a",
  green       = "#9de598",
  yellow      = "#f2dc96",
  blue        = "#93c3f4",
  magenta     = "#f799fd",
  cyan        = "#88e9ec",
}

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "ghostty"
vim.opt.termguicolors = true
vim.opt.background = "dark"

local hi = vim.api.nvim_set_hl
local c = palette

hi(0, "Normal",           { fg = c.fg,      bg = c.bg })
hi(0, "NormalFloat",       { fg = c.fg,      bg = c.bg_mid })
hi(0, "NormalNC",          { fg = c.fg_dim,  bg = c.bg })
hi(0, "EndOfBuffer",       { fg = c.bg_lighter })
hi(0, "Folded",            { fg = c.fg_dim,  bg = c.bg_mid })
hi(0, "FoldColumn",        { fg = c.fg_dark,  bg = c.bg })
hi(0, "SignColumn",        { fg = c.fg_dark,  bg = c.bg })
hi(0, "LineNr",            { fg = c.fg_dark,  bg = c.bg })
hi(0, "CursorLineNr",      { fg = c.accent,   bg = c.bg })
hi(0, "CursorLine",        { bg = c.bg_mid })
hi(0, "CursorColumn",      { bg = c.bg_mid })
hi(0, "ColorColumn",       { bg = c.bg_mid })
hi(0, "Cursor",            { fg = c.bg,      bg = c.fg })
hi(0, "lCursor",           { fg = c.bg,      bg = c.fg })
hi(0, "MatchParen",        { fg = c.bg,      bg = c.accent,   bold = true })
hi(0, "ModeMsg",           { fg = c.accent })
hi(0, "MoreMsg",           { fg = c.accent })
hi(0, "Question",          { fg = c.accent })
hi(0, "WarningMsg",        { fg = c.yellow })
hi(0, "ErrorMsg",           { fg = c.red })
hi(0, "Title",              { fg = c.accent,   bold = true })

hi(0, "Directory",         { fg = c.cyan })
hi(0, "Search",            { fg = c.bg,      bg = c.accent })
hi(0, "IncSearch",         { fg = c.bg,      bg = c.yellow })
hi(0, "Substitute",        { fg = c.bg,      bg = c.accent_dim })
hi(0, "Visual",            { fg = c.fg,      bg = c.accent_dim })
hi(0, "VisualNOS",         { fg = c.fg,      bg = c.bg_lighter })

hi(0, "Pmenu",             { fg = c.fg,      bg = c.bg_mid })
hi(0, "PmenuSel",          { fg = c.bg,      bg = c.accent })
hi(0, "PmenuSbar",         { bg = c.bg_light })
hi(0, "PmenuThumb",        { bg = c.fg_dark })

hi(0, "StatusLine",       { fg = c.fg,      bg = c.bg_light })
hi(0, "StatusLineNC",      { fg = c.fg_dark, bg = c.bg_mid })
hi(0, "VertSplit",         { fg = c.bg_lighter })
hi(0, "WinSeparator",      { fg = c.bg_lighter })

hi(0, "TabLine",            { fg = c.fg_dark, bg = c.bg_mid })
hi(0, "TabLineFill",        { bg = c.bg })
hi(0, "TabLineSel",         { fg = c.accent,  bg = c.bg_light })

hi(0, "Comment",           { fg = c.fg_dark,  italic = true })
hi(0, "SpecialComment",    { fg = c.fg_dark,  italic = true })
hi(0, "Todo",               { fg = c.yellow,   bg = c.bg_mid, bold = true })
hi(0, "Ignore",             { fg = c.bg_lighter })

hi(0, "Constant",          { fg = c.magenta })
hi(0, "String",            { fg = c.green })
hi(0, "Character",         { fg = c.green })
hi(0, "Number",            { fg = c.yellow })
hi(0, "Boolean",           { fg = c.yellow })
hi(0, "Float",             { fg = c.yellow })

hi(0, "Identifier",       { fg = c.fg })
hi(0, "Function",          { fg = c.blue })

hi(0, "Statement",         { fg = c.accent })
hi(0, "Conditional",       { fg = c.accent })
hi(0, "Repeat",            { fg = c.accent })
hi(0, "Label",             { fg = c.accent })
hi(0, "Operator",          { fg = c.fg })
hi(0, "Keyword",           { fg = c.accent })
hi(0, "Exception",         { fg = c.red })

hi(0, "PreProc",           { fg = c.cyan })
hi(0, "Include",            { fg = c.cyan })
hi(0, "Define",             { fg = c.cyan })
hi(0, "Macro",              { fg = c.cyan })
hi(0, "PreCondit",         { fg = c.cyan })

hi(0, "Type",               { fg = c.yellow })
hi(0, "StorageClass",       { fg = c.yellow })
hi(0, "Structure",          { fg = c.yellow })
hi(0, "Typedef",            { fg = c.yellow })

hi(0, "Special",           { fg = c.cyan })
hi(0, "SpecialChar",       { fg = c.cyan })
hi(0, "Tag",                { fg = c.accent })
hi(0, "Delimiter",         { fg = c.fg_dim })

hi(0, "Underlined",        { fg = c.blue,    underline = true })
hi(0, "Error",              { fg = c.red,     bg = c.bg_mid })

hi(0, "DiffAdd",           { fg = c.green,    bg = c.bg_mid })
hi(0, "DiffChange",        { fg = c.yellow,   bg = c.bg_mid })
hi(0, "DiffDelete",        { fg = c.red,      bg = c.bg_mid })
hi(0, "DiffText",          { fg = c.cyan,     bg = c.bg_light })

hi(0, "DiagnosticError",   { fg = c.red })
hi(0, "DiagnosticWarn",    { fg = c.yellow })
hi(0, "DiagnosticInfo",    { fg = c.blue })
hi(0, "DiagnosticHint",   { fg = c.accent })
hi(0, "DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hi(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = c.yellow })
hi(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = c.blue })
hi(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = c.accent })
hi(0, "DiagnosticSignError",  { fg = c.red })
hi(0, "DiagnosticSignWarn",   { fg = c.yellow })
hi(0, "DiagnosticSignInfo",   { fg = c.blue })
hi(0, "DiagnosticSignHint",   { fg = c.accent })

hi(0, "LspReferenceText",  { bg = c.bg_light })
hi(0, "LspReferenceRead",  { bg = c.bg_light })
hi(0, "LspReferenceWrite", { bg = c.bg_light })

hi(0, "GitSignsAdd",       { fg = c.green })
hi(0, "GitSignsChange",    { fg = c.yellow })
hi(0, "GitSignsDelete",    { fg = c.red })
hi(0, "GitSignsAddNr",     { fg = c.green })
hi(0, "GitSignsChangeNr",  { fg = c.yellow })
hi(0, "GitSignsDeleteNr",  { fg = c.red })
hi(0, "GitSignsAddLn",     { fg = c.green })
hi(0, "GitSignsChangeLn",  { fg = c.yellow })
hi(0, "GitSignsDeleteLn",  { fg = c.red })

hi(0, "TelescopeNormal",       { fg = c.fg,      bg = c.bg })
hi(0, "TelescopeBorder",       { fg = c.fg_dark,  bg = c.bg })
hi(0, "TelescopePrompt",       { fg = c.fg,      bg = c.bg_mid })
hi(0, "TelescopePromptBorder", { fg = c.fg_dark,  bg = c.bg_mid })
hi(0, "TelescopeResults",      { fg = c.fg,      bg = c.bg })
hi(0, "TelescopePreview",       { fg = c.fg,      bg = c.bg })
hi(0, "TelescopeMatching",     { fg = c.accent,   bold = true })
hi(0, "TelescopeSelection",    { fg = c.bg,      bg = c.accent })
hi(0, "TelescopeSelectionCaret",{ fg = c.accent })
hi(0, "TelescopeMultiIcon",    { fg = c.accent })

hi(0, "WhichKeyNormal",        { fg = c.fg,      bg = c.bg })
hi(0, "WhichKeyBorder",        { fg = c.fg_dark })
hi(0, "WhichKeyGroup",         { fg = c.accent })
hi(0, "WhichKeyDesc",          { fg = c.fg })
hi(0, "WhichKeySeparator",     { fg = c.fg_dark })
hi(0, "WhichKeyValue",         { fg = c.fg_dim })

hi(0, "NvimTreeNormal",        { fg = c.fg,      bg = c.bg })
hi(0, "NvimTreeFolderIcon",    { fg = c.accent })
hi(0, "NvimTreeFolderName",    { fg = c.accent })
hi(0, "NvimTreeOpenedFolderName",{ fg = c.accent })
hi(0, "NvimTreeRootFolder",    { fg = c.cyan })
hi(0, "NvimTreeSpecialFile",   { fg = c.magenta })
hi(0, "NvimTreeGitDirty",     { fg = c.yellow })
hi(0, "NvimTreeGitStaged",     { fg = c.green })
hi(0, "NvimTreeGitMerge",      { fg = c.cyan })
hi(0, "NvimTreeGitDeleted",    { fg = c.red })
hi(0, "NvimTreeIndentMarker",  { fg = c.fg_dark })
hi(0, "NvimTreeCursorLine",    { bg = c.bg_mid })

hi(0, "CmpItemKind",           { fg = c.accent })
hi(0, "CmpItemAbbr",           { fg = c.fg })
hi(0, "CmpItemAbbrMatch",      { fg = c.accent,   bold = true })
hi(0, "CmpItemAbbrFuzzy",      { fg = c.accent })
hi(0, "CmpItemMenu",           { fg = c.fg_dark })
hi(0, "CmpItemKindText",       { fg = c.fg })
hi(0, "CmpItemKindMethod",     { fg = c.blue })
hi(0, "CmpItemKindFunction",   { fg = c.blue })
hi(0, "CmpItemKindConstructor",{ fg = c.yellow })
hi(0, "CmpItemKindField",      { fg = c.green })
hi(0, "CmpItemKindVariable",   { fg = c.magenta })
hi(0, "CmpItemKindClass",      { fg = c.yellow })
hi(0, "CmpItemKindInterface",  { fg = c.yellow })
hi(0, "CmpItemKindModule",     { fg = c.cyan })
hi(0, "CmpItemKindProperty",   { fg = c.green })
hi(0, "CmpItemKindUnit",       { fg = c.yellow })
hi(0, "CmpItemKindValue",      { fg = c.fg })
hi(0, "CmpItemKindEnum",       { fg = c.yellow })
hi(0, "CmpItemKindKeyword",    { fg = c.accent })
hi(0, "CmpItemKindSnippet",    { fg = c.fg_dark })
hi(0, "CmpItemKindFile",       { fg = c.cyan })
hi(0, "CmpItemKindFolder",     { fg = c.cyan })

hi(0, "@variable",           { fg = c.fg })
hi(0, "@variable.builtin",   { fg = c.red,     italic = true })
hi(0, "@function",            { fg = c.blue })
hi(0, "@function.builtin",   { fg = c.cyan })
hi(0, "@function.call",      { fg = c.blue })
hi(0, "@method",              { fg = c.blue })
hi(0, "@method.call",        { fg = c.blue })
hi(0, "@constructor",         { fg = c.yellow })
hi(0, "@keyword",             { fg = c.accent })
hi(0, "@keyword.function",   { fg = c.accent })
hi(0, "@keyword.operator",   { fg = c.accent })
hi(0, "@keyword.return",     { fg = c.accent })
hi(0, "@conditional",        { fg = c.accent })
hi(0, "@repeat",              { fg = c.accent })
hi(0, "@label",               { fg = c.accent })
hi(0, "@include",              { fg = c.cyan })
hi(0, "@exception",           { fg = c.red })
hi(0, "@type",                 { fg = c.yellow })
hi(0, "@type.builtin",       { fg = c.yellow,  italic = true })
hi(0, "@type.definition",    { fg = c.yellow })
hi(0, "@type.qualifier",     { fg = c.accent })
hi(0, "@storageclass",       { fg = c.accent })
hi(0, "@attribute",           { fg = c.cyan })
hi(0, "@field",               { fg = c.fg_dim })
hi(0, "@property",            { fg = c.fg_dim })
hi(0, "@parameter",           { fg = c.fg,      italic = true })
hi(0, "@variable.parameter",  { fg = c.fg,      italic = true })
hi(0, "@string",              { fg = c.green })
hi(0, "@string.escape",      { fg = c.cyan })
hi(0, "@string.special",      { fg = c.cyan })
hi(0, "@character",           { fg = c.green })
hi(0, "@character.special",  { fg = c.cyan })
hi(0, "@number",              { fg = c.yellow })
hi(0, "@boolean",             { fg = c.yellow })
hi(0, "@float",               { fg = c.yellow })
hi(0, "@operator",            { fg = c.fg })
hi(0, "@constant",            { fg = c.magenta })
hi(0, "@constant.builtin",   { fg = c.yellow })
hi(0, "@constant.macro",     { fg = c.cyan })
hi(0, "@macro",               { fg = c.cyan })
hi(0, "@preproc",             { fg = c.cyan })
hi(0, "@define",               { fg = c.cyan })
hi(0, "@comment",             { fg = c.fg_dark, italic = true })
hi(0, "@punctuation",         { fg = c.fg_dim })
hi(0, "@punctuation.bracket",{ fg = c.fg_dim })
hi(0, "@punctuation.delimiter",{ fg = c.fg_dim })
hi(0, "@tag",                  { fg = c.accent })
hi(0, "@tag.attribute",      { fg = c.yellow })
hi(0, "@tag.delimiter",      { fg = c.fg_dim })
hi(0, "@text.literal",        { fg = c.green })
hi(0, "@text.reference",     { fg = c.cyan,    underline = true })
hi(0, "@text.title",          { fg = c.accent,  bold = true })
hi(0, "@text.uri",            { fg = c.cyan,    underline = true })
hi(0, "@text.underline",    { underline = true })
hi(0, "@text.strikethrough",{ strikethrough = true })
hi(0, "@text.emphasis",     { italic = true })
hi(0, "@text.strong",       { bold = true })
hi(0, "@note",                 { fg = c.blue })
hi(0, "@warning",              { fg = c.yellow })
hi(0, "@danger",               { fg = c.red })
hi(0, "@error",                { fg = c.red })
hi(0, "@diff.plus",           { fg = c.green })
hi(0, "@diff.minus",          { fg = c.red })
hi(0, "@diff.delta",          { fg = c.yellow })

hi(0, "MiniMapCursor",       { bg = c.accent_dim, fg = c.fg })
vim.g.minimap_cursor_color = "MiniMapCursor"
vim.g.minimap_range_color = "Visual"
vim.g.minimap_search_color = "Search"
vim.g.minimap_diffadd_color = "DiffAdd"
vim.g.minimap_diffremove_color = "DiffDelete"
vim.g.minimap_diff_color = "DiffChange"