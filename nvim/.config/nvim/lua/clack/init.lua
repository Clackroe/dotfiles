require("clack.options")
require("clack.remap")
require("clack.lazy_init")

local augroup = vim.api.nvim_create_augroup
local clackroe = augroup("Clackroe", {})
local autocmd = vim.api.nvim_create_autocmd

vim.keymap.set("n", "<Leader>cc", ":CMakeBuild<CR>")
vim.keymap.set("n", "<Leader>ce", ":CMakeRun<CR>")
vim.keymap.set("n", "<Leader>cd", ":CMakeDebug<CR>")

--
--This is a test for ammending commits
autocmd("LspAttach", {
    group = clackroe,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function()
            vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "<leader>vws", function()
            vim.lsp.buf.workspace_symbol()
        end, opts)
        vim.keymap.set("n", "<leader>vd", function()
            vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set("n", "<leader>vca", function()
            vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("n", "<leader>vrr", function()
            vim.lsp.buf.references()
        end, opts)
        vim.keymap.set("n", "<leader>vrn", function()
            vim.lsp.buf.rename()
        end, opts)
        vim.keymap.set("i", "<C-h>", function()
            vim.lsp.buf.signature_help()
        end, opts)
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.goto_prev()
        end, opts)
    end,
})
