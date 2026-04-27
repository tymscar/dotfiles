local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

pcall(require, "neodev")

vim.lsp.config("*", {
  capabilities = capabilities,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    local bufmap = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    bufmap("<leader>r", vim.lsp.buf.rename, "Rename")
    bufmap("<leader>a", vim.lsp.buf.code_action, "Code action")
    bufmap("gd", vim.lsp.buf.definition, "Go to definition")
    bufmap("gD", vim.lsp.buf.declaration, "Go to declaration")
    bufmap("gI", vim.lsp.buf.implementation, "Go to implementation")
    bufmap("<leader>D", vim.lsp.buf.type_definition, "Type definition")
    bufmap("gr", require("telescope.builtin").lsp_references, "References")
    bufmap("<leader>o", require("telescope.builtin").lsp_document_symbols, "Document symbols")
    bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")
    bufmap("K", vim.lsp.buf.hover, "Hover")
    bufmap("<leader>i", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, "Toggle inlay hints")

    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
      vim.lsp.buf.format()
    end, {})

    if client and client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("nil_ls", {
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "nil_ls",
  "rust_analyzer",
  "kotlin_language_server",
  "gopls",
  "gleam",
  "bashls",
})