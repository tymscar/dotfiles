vim.g.mapleader = " "

local keymap = vim.keymap
local builtin = require("telescope.builtin")

keymap.set("n", "<leader><leader>", function()
  local actions = {
    { name = "Files",         action = builtin.find_files },
    { name = "Grep content",  action = builtin.live_grep },
    { name = "Buffers",       action = builtin.buffers },
    { name = "Keymaps",       action = builtin.keymaps },
    { name = "Commands",      action = builtin.commands },
    { name = "Help",          action = builtin.help_tags },
  }
  vim.ui.select(actions, {
    prompt = "Search:",
    format_item = function(item)
      return item.name
    end,
  }, function(choice)
    if choice then
      choice.action()
    end
  end)
end, { desc = "Search Everything" })

keymap.set("n", "<leader>h", "<cmd>nohl<cr>", { desc = "Clear highlight" })
keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "File explorer" })
keymap.set("n", "<leader>m", "<cmd>MinimapToggle<cr>", { desc = "Minimap" })

keymap.set("n", "<leader>j", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap.set("n", "<leader>k", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })

keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")