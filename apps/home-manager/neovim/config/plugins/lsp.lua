local on_attach = function(_, bufnr)
    local bufmap = function(keys, func)
        vim.keymap.set('n', keys, func, { buffer = bufnr })
    end

    bufmap('<leader>r', vim.lsp.buf.rename)
    bufmap('<leader>a', vim.lsp.buf.code_action)

    bufmap('gd', vim.lsp.buf.definition)
    bufmap('gD', vim.lsp.buf.declaration)
    bufmap('gI', vim.lsp.buf.implementation)
    bufmap('<leader>D', vim.lsp.buf.type_definition)

    bufmap('gr', require('telescope.builtin').lsp_references)
    bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
    bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

    bufmap('K', vim.lsp.buf.hover)

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('neodev').setup({
    override = function(root_dir, library)
        if string.find(root_dir, "dotfiles") then
            library.enabled = true
            library.plugins = true
        end
    end,
})

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
    },
}

lspconfig.tsserver.setup {}

lspconfig.nil_ls.setup {
    autostart = true,
    capabilities = capabilities,
    settings = {
        ['nil'] = {
            formatting = {
                command = { "nixpkgs-fmt" },
            },
        },
    },
}

lspconfig.rust_analyzer.setup {
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
            workspace = {
                symbol = {
                    search = {
                        kind = "all_symbols"
                    }
                }
            }
        },
    }
}
