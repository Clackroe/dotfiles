local wezterm     = require('wezterm')
local sessionizer = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer.wezterm"

local home        = os.getenv("HOME")

-- Helpers

function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            return true
        end
    end
    return ok, err
end

function isdir(path)
    return exists(path .. "/")
end

--


--string[]
local wantedDirectories = {
    home .. "/dev",
    home .. "/dev/personal",
    home .. "/dev/external",
    home .. "/work",

}
local sessionizerSchema = {

    processing = sessionizer.for_each_entry(function(entry)
        entry.label = entry.label:gsub(wezterm.home_dir, "~")
    end),

    sessionizer.AllActiveWorkspaces { filter_default = true, filter_current = true },

}

for _, path in ipairs(wantedDirectories) do
    if isdir(path) then
        for _, proj in ipairs(wezterm.read_dir('' .. path)) do
            print("Inserting: " .. proj)
            table.insert(sessionizerSchema, proj)
        end
    end
end



local config = {}

config = wezterm.config_builder()


config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.font = wezterm.font('JetBrains Mono', { weight = "Regular", italic = false })

config.colors = {

    cursor_bg = 'white',
    cursor_fg = 'black',
    cursor_border = 'white',

    tab_bar = {
        background = '#333333',
        active_tab = {
            bg_color = '#5eacd3', fg_color = '#000000',
        },
        inactive_tab = {
            bg_color = '#333333',
            fg_color = '#5eacd3',
        },
    },
}

config.window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
}

-- Set base index to 1
config.tab_and_split_indices_are_zero_based = false


-- Keybindings
config.keys = {
    -- Configuration reload
    { key = 'r',  mods = 'LEADER', action = wezterm.action.ReloadConfiguration },

    -- Split management - similar to your tmux bindings
    { key = '\\', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '-',  mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },

    -- Pane navigation - similar to your vim/tmux navigation
    { key = 'k',  mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'j',  mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'h',  mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'l',  mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },

    -- Tab navigation
    { key = 'o',  mods = 'LEADER', action = wezterm.action.ActivateLastTab },

    { key = '1',  mods = 'LEADER', action = wezterm.action.ActivateTab(0) },
    { key = '2',  mods = 'LEADER', action = wezterm.action.ActivateTab(1) },
    { key = '3',  mods = 'LEADER', action = wezterm.action.ActivateTab(2) },
    { key = '4',  mods = 'LEADER', action = wezterm.action.ActivateTab(3) },
    { key = '5',  mods = 'LEADER', action = wezterm.action.ActivateTab(4) },
    { key = '6',  mods = 'LEADER', action = wezterm.action.ActivateTab(5) },

    { key = 'c',  mods = 'LEADER', action = wezterm.action.SpawnTab('CurrentPaneDomain') },

    { key = 'w',  mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = false } },

    { key = 's',  mods = 'LEADER', action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES' } },

    { key = 'f',  mods = 'CTRL',   action = sessionizer.show(sessionizerSchema) },

    { key = '[',  mods = 'LEADER', action = wezterm.action.ActivateCopyMode },


}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- Enable workspaces for sessionizer
config.unix_domains = {
    {
        name = 'unix',
    }
}

return config
