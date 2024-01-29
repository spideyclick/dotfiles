-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'MaterialOcean'
config.default_prog = { 'wsl' }
config.font = wezterm.font 'JetBrains Mono'
config.enable_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_background_opacity = 0.95
-- config.window_background = "#0f111a"
config.window_background_gradient = {
  orientation = { Linear = {angle = -40.0 } },
  colors = { '#0f111a', '#0f111a' },
}
config.font_size = 10
-- config.disable_default_key_bindings = true
-- key = 'F11', mods = 'SHIFT|CTRL', action = ToggleFullScreen

-- and finally, return the configuration to wezterm
return config
