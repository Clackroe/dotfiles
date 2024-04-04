return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
        "williamboman/mason.nvim",
    },
    opts = {
        handlers = {},
        ensure_installed = {
            "codelldb",
        },
    },

    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local mason = require("mason")
        local masondap = require("mason-nvim-dap")

        mason.setup()
        masondap.setup({
            handlers = {},
        })

        dapui.setup()
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<leader>bb", function()
            require("dap").toggle_breakpoint()
        end)
        vim.keymap.set("n", "<leader>br", function()
            require("dap").continue()
        end)
        vim.keymap.set("n", "<Leader>bq", ":lua require('dap').terminate()<CR>")

        vim.keymap.set("n", "<Leader>bc", ":lua require('dap').continue()<CR>")
        vim.keymap.set("n", "<Leader>bo", ":lua require('dap').step_over()<CR>")
        vim.keymap.set("n", "<Leader>bi", ":lua require('dap').step_into()<CR>")
        vim.keymap.set("n", "<Leader>bO", ":lua require('dap').step_out()<CR>")
        vim.keymap.set("n", "<Leader>bu", ":lua require('dapui').toggle()<CR>")

        vim.keymap.set("n", "<Leader>bK", ":lua require('dap.ui.variables').hover()<CR>")
        vim.keymap.set("v", "<Leader>bv", ":lua require('dap.ui.variables').visual_hover()<CR>")
        --
        --
        -- vim.keymap.set( "n", "<Leader>dro", ":lua require('dap').repl.open()<CR>" )
        -- vim.keymap.set( "n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>" )
        --

        -- vim.keymap.set( "n", "<Leader>dc", ":lua require('dap.ui.variables').scopes()<CR>" )
    end,
}
