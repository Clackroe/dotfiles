#!/usr/bin/env lua
-- WezTerm Sessionizer
-- Save this to ~/.local/scripts/wezterm-sessionizer.lua

local wezterm = require('wezterm')
local io = require('io')
local os = require('os')
local home = os.getenv('HOME')

-- Function to execute a command and get its output
local function execute_command(cmd)
    local handle = io.popen(cmd)
    local result = handle:read('*a')
    handle:close()
    return result:gsub('\n$', '') -- Remove trailing newline
end

-- Function to get selected directory
local function get_selected_directory(arg)
    local selected
    
    if #arg > 0 then
        selected = arg[1]
    else
        -- Use a temporary file to get fzf's selection
        local tmp_file = os.tmpname()
        os.execute('find ~/Documents ~/School ~/School/** ~/dev ~/dev/work ~/dev/personal -mindepth 1 -maxdepth 1 -type d | fzf > ' .. tmp_file)
        
        local f = io.open(tmp_file, 'r')
        if f then
            selected = f:read('*a'):gsub('\n$', '')
            f:close()
        end
        os.remove(tmp_file)
    end
    
    if selected == "" then
        os.exit(0)
    end
    
    return selected
end

-- Function to sanitize workspace name
local function get_workspace_name(path)
    local basename = path:match("([^/]+)$")
    return basename:gsub("%.", "_")
end

-- Main function
local function main(arg)
    local selected = get_selected_directory(arg)
    if not selected then
        os.exit(0)
    end
    
    local workspace_name = get_workspace_name(selected)
    
    -- Check if we're already in a WezTerm instance
    local in_wezterm = os.getenv('WEZTERM_PANE')
    
    if in_wezterm then
        -- Create or switch to workspace
        -- Using wezterm cli to interact with the running instance
        local result = execute_command('wezterm cli list-clients')
        
        -- Try to activate the workspace first (will succeed if it exists)
        local activate_result = os.execute('wezterm cli activate-workspace ' .. workspace_name .. ' 2>/dev/null')
        
        -- If activation failed, create a new workspace
        if activate_result ~= 0 then
            os.execute('wezterm cli spawn --workspace ' .. workspace_name .. ' --cwd "' .. selected .. '"')
        end
    else
        -- Start a new WezTerm instance with this workspace
        os.execute('wezterm start --workspace ' .. workspace_name .. ' --cwd "' .. selected .. '"')
    end
end

main(arg)
