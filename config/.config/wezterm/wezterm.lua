-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end


config.window_background_image = '/home/spideyclick/dotfiles/config/wallpapers/terminal-wallpaper-mountain.jpg'
config.window_background_opacity = 0.0
config.text_background_opacity = 0.3

-- config.color_scheme = 'MaterialOcean'
-- name = 'Nautilus',
config.colors = {

  foreground = 'C0A0C0',
  -- background = '090B10',
  background = '090B10',

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = '#E2DDC8',
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = 'C0A0C0',
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = '#C0A0C0',

  -- the foreground color of selected text
  selection_fg = 'C0A0C0',
  -- the background color of selected text
  selection_bg = '#603048',

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#222222',

  -- The color of the split lines between panes
  split = '#444444',

  ansi = {
    '373A55',
    'FF0094',
    'B6FF00',
    'FFC000',
    '558CFF',
    '8D82FF',
    '00B6FF',
    'E2DDC8',
  },

  brights = {
    '575A75',
    'FF51B6',
    'C3E88D',
    'FFD964',
    '82AAFF',
    'D1CCFF',
    '89DDFF',
    'FFFFFF',
  },

  -- Arbitrary colors of the palette in the range from 16 to 255
  indexed = { [136] = '#af8700' },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = 'orange',

  -- Colors for copy_mode and quick_select
  -- available since: 20220807-113146-c2fee766
  -- In copy_mode, the color of the active text is:
  -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- 2. selection_* otherwise
  copy_mode_active_highlight_bg = { Color = '#000000' },
  -- use `AnsiColor` to specify one of the ansi color palette values
  -- (index 0-15) using one of the names "Black", "Maroon", "Green",
  --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
  -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
  copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
  copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
  copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

  quick_select_label_bg = { Color = 'peru' },
  quick_select_label_fg = { Color = '#ffffff' },
  quick_select_match_bg = { AnsiColor = 'Navy' },
  quick_select_match_fg = { Color = '#ffffff' },

  -- input_selector_label_bg = { AnsiColor = 'Black' }, -- (*Since: Nightly Builds Only*)
  -- input_selector_label_fg = { Color = '#ffffff' }, -- (*Since: Nightly Builds Only*)

  -- launcher_label_bg = { AnsiColor = 'Black' }, -- (*Since: Nightly Builds Only*)
  -- launcher_label_fg = { Color = '#ffffff' }, -- (*Since: Nightly Builds Only*)
}

-- config.default_prog = { 'wsl' }
config.font = wezterm.font 'JetBrains Mono'
config.enable_tab_bar = false
config.window_padding = {
  left = "0px",
  right = "0px",
  top = "0px",
  bottom = "0px",
}
config.window_background_opacity = 0.95
-- config.window_background = "#0f111a"
config.window_background_gradient = {
  orientation = { Linear = {angle = -40.0 } },
  colors = { '#0f111a', '#0f111a' },
}
config.font_size = 13

-- Trying to make dim text work; not working yet
config.font_rules = {
  {
    intensity = 'Half',
    font = wezterm.font {
      family = 'JetBrains Mono',
      weight = 'Thin',
    },
  },
}

      -- {
      --   foreground = '00ff00',
      --   foreground_text_hsb = {
      --     hue = 1.0,
      --     saturation = 1.0,
      --     brightness = 0.5,
      --   },
      -- },

-- config.disable_default_key_bindings = true
-- key = 'F11', mods = 'SHIFT|CTRL', action = ToggleFullScreen
-- and finally, return the configuration to wezterm

-- TODO: Full Screen on startup would be nice!
-- wezterm.on('gui-startup', function(cmd)
--   local tab, pane, window = mux.spawn_window(cmd or ())
--   window:gui_window():fullscreen()
-- end)


config.keys = {
  {
    key = 'r',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ReloadConfiguration,
  },
  -- {
  --   key = 'C',
  --   mods = 'CTRL|SHIFT',
  --   action = wezterm.action.CopyTo("Clipboard"),
  -- },
}

-- config.key_tables = {
--   copy_mode = {
--     {
--       key = 'C',
--       mods = 'CMD|SHIFT',
--       action = wezterm.action.CopyMode { SetSelectionMode = 'Word' },
--     },
--   },
-- }

return config
