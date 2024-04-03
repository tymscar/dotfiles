local status, _ = pcall(vim.cmd, "colorscheme dracula")
if not status then
    print("Colourscheme not found!")
    return
end
