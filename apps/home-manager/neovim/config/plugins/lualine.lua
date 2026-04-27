local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

local c = {
  bg        = "#11140a",
  bg_mid    = "#1a1e12",
  bg_light  = "#283020",
  fg        = "#f2f2f2",
  fg_dim    = "#b9b9b9",
  fg_dark   = "#8d8d8d",
  accent    = "#96aa6e",
  red       = "#fcaeae",
  green     = "#9de598",
  yellow    = "#f2dc96",
  blue      = "#93c3f4",
  magenta   = "#f799fd",
  cyan      = "#88e9ec",
}

local theme = {
  normal = {
    a = { bg = c.accent, fg = c.bg, gui = "bold" },
    b = { bg = c.bg_light, fg = c.fg },
    c = { bg = c.bg_mid, fg = c.fg_dim },
  },
  insert = {
    a = { bg = c.cyan, fg = c.bg, gui = "bold" },
    b = { bg = c.bg_light, fg = c.fg },
    c = { bg = c.bg_mid, fg = c.fg_dim },
  },
  visual = {
    a = { bg = c.yellow, fg = c.bg, gui = "bold" },
    b = { bg = c.bg_light, fg = c.fg },
    c = { bg = c.bg_mid, fg = c.fg_dim },
  },
  replace = {
    a = { bg = c.red, fg = c.bg, gui = "bold" },
    b = { bg = c.bg_light, fg = c.fg },
    c = { bg = c.bg_mid, fg = c.fg_dim },
  },
  command = {
    a = { bg = c.blue, fg = c.bg, gui = "bold" },
    b = { bg = c.bg_light, fg = c.fg },
    c = { bg = c.bg_mid, fg = c.fg_dim },
  },
  inactive = {
    a = { bg = c.bg_mid, fg = c.fg_dark },
    b = { bg = c.bg_mid, fg = c.fg_dark },
    c = { bg = c.bg_mid, fg = c.fg_dark },
  },
}

lualine.setup({
  options = {
    theme = theme,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = { "filename" },
    lualine_x = { "diagnostics", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})