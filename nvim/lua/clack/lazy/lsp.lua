return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "clangd",
                "bashls",
                "cssls",
                "gopls",
                "html",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    })
                end,
                ["clangd"] = function()
                    require("lspconfig").clangd.setup({
                        cmd = {
                            "C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Tools\\Llvm\\bin\\clangd.exe",
                            "--background-index",
                            "--clang-tidy=false",         -- Disable clang-tidy during indexing
                            "--header-insertion=never",   -- Simpler
                            "--completion-style=bundled", -- Less memory than detailed
                            "--function-arg-placeholders",
                            "--fallback-style=webkit",
                            "-j=2",               -- CRITICAL: Only 2 threads
                            "--pch-storage=disk", -- Use disk instead of memory
                            "--limit-results=30",
                            "--compile-commands-dir=.",
                        },
                        capabilities = {
                            offsetEncoding = { "utf-16" },
                        },
                    })

                    vim.keymap.set("n", "<C-Space>", "<cmd> ClangdSwitchSourceHeader <CR>")
                end,
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- For luasnip users.
                { name = "path" },
            }, {
                { name = "buffer" },
            }),
        })

        vim.diagnostic.config({
            virtual_text = {
                prefix = "●", -- Or "■", "▎", "●", "▶", or ""
                source = "always", -- Show source in virtual text
            },
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
            signs = true,             -- show signs in the gutter
            underline = true,
            update_in_insert = false, -- if true, diagnostics update while typing
            severity_sort = true,
        })
        local configs = require("lspconfig.configs")

        if not configs.hlsl_tools then
            configs.hlsl_tools = {
                default_config = {
                    -- Use standard Windows pathing or escaped backslashes
                    cmd = { "C:\\Users\\clack\\.vscode\\extensions\\timgjones.hlsltools-1.1.303\\bin\\win-x64\\ShaderTools.LanguageServer.exe" },
                    filetypes = { "hlsl" },
                    root_dir = require("lspconfig").util.root_pattern(".git", "shardertoolsproject.json"),
                    settings = {},
                },
            }
        end

        require("lspconfig").hlsl_tools.setup({
            capabilities = capabilities
        })
    end,

}
