local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.default_prog = { '/usr/local/bin/zsh' }
-- 光标
config.default_cursor_style = 'BlinkingBar'

-- config.color_scheme = 'Batman'
config.color_scheme = 'BlulocoDark'

-- font
config.font = wezterm.font 'Monaco' -- Apple
-- config.font = wezterm.font 'Fira Code'
-- config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 14

-- windows
config.window_background_opacity = 0.95

-- tab bar
config.tab_max_width = 30
hide_tab_bar_if_only_one_tab = true

config.enable_scroll_bar = true

config.tab_bar_at_bottom = false

config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.5,
}

-- key binding
local act = wezterm.action
config.keys = {
    {
        key = 'd',
        mods = 'CMD',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    {
        key = 'd',
        mods = 'CMD|SHIFT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
    },
    {
        key = 'Enter',
        mods = 'CMD',
        action = wezterm.action.ToggleFullScreen,
    },
    {
        key = 'RightArrow',
        mods = 'CMD',
        action = act.ActivateTabRelative(1),
    },
    {
        key = 'LeftArrow',
        mods = 'CMD',
        action = act.ActivateTabRelative(-1),
    }
}

wezterm.on('update-right-status', function(window, pane)
  -- "Wed Mar 3 08:14"
  local date = wezterm.strftime '%F %A %T '

  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    bat = '🔋' .. string.format('%.0f%%', b.state_of_charge * 100)
  end

  window:set_right_status(wezterm.format {
    { Text = bat .. '    ' .. wezterm.nerdfonts.fa_clock_o .. ' ' .. date },
  })
end)

return config
