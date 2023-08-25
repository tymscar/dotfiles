local status, cmp = pcall(require, "cmp")
if not status then
    return
end

local status_lspkind, lspkind = pcall(require, "lspkind")
if not status_lspkind then
    return
end


vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), 
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(), 
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
    sources = cmp.config.sources({
        { name = "buffer" },
        { name = "nvim_cmp" },
        { name = "path" },
        { name = "emoji" },
    }),
    formatting = {
        format = lspkind.cmp_format({
            maxwidth = 50,
            elipsis_char = "...",
        }),
    },
})
