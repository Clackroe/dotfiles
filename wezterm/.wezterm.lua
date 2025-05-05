local wezterm = require('wezterm')

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
config = wezterm.config_builder()

-- Set color scheme to support 256 colors
config.term = 'xterm-256color'
config.color_scheme = 'Batman' 

-- Reduce escape time
-- config.escape_key_timeout = 0 -- milliseconds

-- Change leader key from CTRL+B to CTRL+A (like your tmux config)
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

-- Set status bar style to be similar to your tmux config
--config.colors = {
--  tab_bar = {
--    background = '#333333',
--    active_tab = {
--      bg_color = '#5eacd3',
--      fg_color = '#000000',
--    },
--    inactive_tab = {
--      bg_color = '#333333',
--      fg_color = '#5eacd3',
--    },
--  },
--}

-- Set base index to 1 (like your tmux config)
config.tab_and_split_indices_are_zero_based = false


-- Keybindings
config.keys = {
  -- Configuration reload
  { key = 'r', mods = 'LEADER', action = wezterm.action.ReloadConfiguration },
  
  -- Split management - similar to your tmux bindings
  { key = '\\', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '-', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  
  -- Pane navigation - similar to your vim/tmux navigation
  { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },
  
  -- Tab navigation
  { key = 'o', mods = 'LEADER', action = wezterm.action.ActivateLastTab },

  { key = '1', mods = 'LEADER', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'LEADER', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'LEADER', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'LEADER', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'LEADER', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'LEADER', action = wezterm.action.ActivateTab(5) },

  { key = 'o', mods = 'LEADER', action = wezterm.action.ActivateLastTab },

  { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab('CurrentPaneDomain') },

  { key = 'w', mods = 'LEADER', action = wezterm.action.CloseCurrentTab{confirm = false} },
  
  -- Launch sessionizer - similar to your tmux binding
  { 
    key = 'f', 
    mods = 'LEADER', 
    action = wezterm.action_callback(function(window, pane)
      local script_path = os.getenv('HOME') .. '/.local/scripts/wezterm-sessionizer.lua'
      window:perform_action(
        wezterm.action.SpawnCommandInNewTab {
          args = { 'lua', script_path },
        },
        pane
      )
    end)
  },
  
  
  
}

-- Enable workspaces for sessionizer
config.unix_domains = {
  {
    name = 'unix',
  }
}

return config
