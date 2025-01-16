-- mason!
require('mason').setup()

-- servers
require('mason-lspconfig').setup({
    ensure_installed = {
        "lua_ls",
        "astro",
        "clangd",
        "dockerls",
        "gopls",
        "graphql",
        "html",
        "jdtls",
        "eslint",
        "texlab",
        "pyright",
        "rust_analyzer"
    },
})

-- capabilities for nvim-cmp (autocompletion)
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- on attach func
local on_attach = function(client, bufnr)
    -- for buffer-specific keymaps
    local bufmap = function(mode, ll, rr, opts)
        opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, ll, rr, opts)
    end

    -- LSP-specific keybindings
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>') -- Go to definition
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>') -- Go to references
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>') -- Hover
    bufmap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>') -- Rename
    bufmap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>') -- Code actions
    bufmap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>') -- Show diagnostics
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>') -- Previous diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>') -- Next diagnostic
end

-- config lsp servers
require('mason-lspconfig').setup_handlers({
    -- Default handler: Configures all servers
    function(server_name)
        require('lspconfig')[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,

    -- Custom configurations for specific servers
    ["lua_ls"] = function()
        require('lspconfig').lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }, -- Recognize `vim` as a global
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime
                        checkThirdParty = false, -- Disable third-party checks
                    },
                },
            },
        })
    end,

    ["pyright"] = function()
        require('lspconfig').pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "strict", -- Enable strict type checking
                    },
                },
            },
        })
    end,

    ["eslint"] = function()
        require('lspconfig').eslint.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = true
                on_attach(client, bufnr)
            end,
            settings = {
                format = { enable = true }, -- Automatically format files
            },
        })
    end,

    ["rust_analyzer"] = function()
        require('lspconfig').rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                    },
                    checkOnSave = {
                        command = "clippy",
                    },
                },
            },
        })
    end,
})
