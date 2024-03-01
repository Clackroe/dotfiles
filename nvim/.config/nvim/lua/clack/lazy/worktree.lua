return {
    'ThePrimeagen/git-worktree.nvim',
    'nvim-telescope/telescope.nvim',

    config = function()
        require('git-worktree').setup()


        local Worktree = require("git-worktree")
        Worktree.on_tree_change(function(op, metadata)
            if op == Worktree.Operations.Switch then
                print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
            end
        end)
    end
}
