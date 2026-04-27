local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_config = {
      horizontal = { preview_width = 0.5 },
      vertical = { mirror = true },
    },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})

pcall(telescope.load_extension, "ui-select")