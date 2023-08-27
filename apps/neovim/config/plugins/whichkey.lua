local setup, whichkey = pcall(require, "which-key")
if not setup then
    return
end

whichkey.setup()
