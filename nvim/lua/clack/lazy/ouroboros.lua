return {
    "jakemason/ouroboros",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require('ouroboros').setup({
            extension_preferences_table = {
                -- Higher numbers are a heavier weight and thus preferred.
                -- In the following, .c would prefer to open .h before .hpp
                c = { h = 2, hpp = 1 },
                h = { c = 1, cpp = 2 },
                cpp = { hpp = 2, h = 1 },
                hpp = { cpp = 1, c = 2 },

                -- Ouroboros supports any combination of filetypes you like, simply
                -- add them as desired:
                -- myext = { myextsrc = 2, myextoldsrc = 1},
                -- tpp = {hpp = 2, h = 1},
                -- inl = {cpp = 3, hpp = 2, h = 1},
                -- cu = {cuh = 3, hpp = 2, h = 1},
                -- cuh = {cu = 1}
            },
            -- if this is true and the matching file is already open in a pane, we'll
            -- switch to that pane instead of opening it in the current buffer
            switch_to_open_pane_if_possible = false,
        }
        )
    end,
}
