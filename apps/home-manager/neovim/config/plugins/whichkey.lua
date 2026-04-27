local ok, wk = pcall(require, "which-key")
if not ok then
  return
end

wk.setup({
  win = {
    border = "single",
  },
})

wk.add({
  { "<leader>", group = " " },
  { "<leader><leader>", desc = "Search Everything" },
  { "<leader>e", desc = "File explorer" },
  { "<leader>h", desc = "Clear highlight" },
  { "<leader>w", desc = "Save file" },
  { "<leader>q", desc = "Quit" },
  { "<leader>m", desc = "Minimap" },
  { "<leader>j", desc = "Next diagnostic" },
  { "<leader>k", desc = "Previous diagnostic" },
  { "<leader>n", desc = "Git next hunk" },
  { "<leader>p", desc = "Git prev hunk" },
  { "<leader>i", desc = "Toggle inlay hints" },
  { "<leader>r", desc = "Rename" },
  { "<leader>a", desc = "Code action" },
  { "<leader>D", desc = "Type definition" },
  { "<leader>o", desc = "Document symbols" },
  { "<leader>S", desc = "Workspace symbols" },
  { "<leader>g", group = "Git" },
  { "<leader>gg", desc = "Open Git review" },
  { "gd", desc = "Go to definition" },
  { "gD", desc = "Go to declaration" },
  { "gI", desc = "Go to implementation" },
  { "gr", desc = "References" },
  { "gc", desc = "Toggle comment" },
  { "gp", desc = "Preview hunk" },
  { "gb", desc = "Blame" },
  { "K",  desc = "Hover" },
})
