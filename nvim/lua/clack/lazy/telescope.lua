return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require('telescope').setup({})
        local builtin = require('telescope.builtin')

        -- Custom function to get Diversion files
        local function get_diversion_files()
            local handle = io.popen('dv ls')
            if not handle then return nil end

            local result = handle:read("*a")
            handle:close()

            local files = {}
            for line in result:gmatch("[^\r\n]+") do
                -- Only include lines that start with (F) for files
                if line:match("^%(F%)") then
                    -- Extract the file path (second field)
                    local filepath = line:match("^%(F%)%s+([^%s]+)")
                    if filepath then
                        table.insert(files, filepath)
                    end
                end
            end

            return files
        end

        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', function()
            -- Try git first
            local git_ok = pcall(builtin.git_files, {})
            if not git_ok then
                -- If git fails, try to find diversion files
                local dv_files = get_diversion_files()
                if dv_files and #dv_files > 0 then
                    require('telescope.pickers').new({}, {
                        prompt_title = 'Diversion Files',
                        finder = require('telescope.finders').new_table({
                            results = dv_files
                        }),
                        sorter = require('telescope.config').values.generic_sorter({}),
                    }):find()
                else
                    -- Fall back to all files
                    builtin.find_files({})
                end
            end
        end)
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
