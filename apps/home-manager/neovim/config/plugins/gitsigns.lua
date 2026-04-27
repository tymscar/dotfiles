local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
  return
end

gitsigns.setup({
  on_attach = function(bufnr)
    local gs = require("gitsigns")

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end

    map("n", "<leader>n", gs.next_hunk, "Next hunk")
    map("n", "<leader>p", gs.prev_hunk, "Prev hunk")
    map("n", "gp", gs.preview_hunk, "Preview hunk")
    map("n", "gb", gs.toggle_current_line_blame, "Blame")
  end,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
  },
})
