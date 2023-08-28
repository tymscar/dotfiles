local status, _ = pcall(vim.cmd, "colorscheme kanagawa")
if not status then
    print("Colourscheme not found!")
    return
end
