local status, _ = pcall(vim.cmd, "colorscheme catppuccin-macchiato")
if not status then
    print("Colourscheme not found!")
    return
end
