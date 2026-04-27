local ok, neogit = pcall(require, "neogit")
if not ok then
  return
end

neogit.setup({
  kind = "replace",
  disable_line_numbers = true,
  disable_relative_line_numbers = true,
  disable_insert_on_commit = true,
  commit_editor = {
    kind = "replace",
    show_staged_diff = true,
    staged_diff_split_kind = "split",
  },
  integrations = {
    diffview = true,
  },
  sections = {
    untracked = {
      folded = false,
      hidden = false,
    },
    unstaged = {
      folded = false,
      hidden = false,
    },
    staged = {
      folded = false,
      hidden = false,
    },
  },
  signs = {
    hunk = { "", "" },
    item = { ">", "v" },
    section = { ">", "v" },
  },
  treesitter_diff_highlight = true,
  word_diff_highlight = true,
})

vim.keymap.set("n", "<leader>gg", function()
  neogit.open({ kind = "replace" })
end, { desc = "Open Git review" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "NeogitStatus",
  callback = function(args)
    local opts = { buffer = args.buf, silent = true, remap = true }
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.keymap.set("n", "n", "}", vim.tbl_extend("force", opts, { buffer = args.buf }))
        vim.keymap.set("n", "N", "{", vim.tbl_extend("force", opts, { buffer = args.buf }))
      end
    end)
  end,
})
