local setup, term = pcall(require, "toggleterm")
if not setup then
    return
end

term.setup()

local Terminal = require("toggleterm.terminal").Terminal

local zshTerm = Terminal:new({
    cmd = "zsh",
    hidden = true,
    direction = "float",
});

function _TOGGLE_ZSH()
    zshTerm:toggle()
end
