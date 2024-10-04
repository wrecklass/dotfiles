-- Pull in the wezterm API
local wezterm = require("wezterm")
--
-- -- This will hold the configuration.
local config = wezterm.config_builder()

-- Start up in cygwin bash
config.default_prog = { "C:/cygwin64/cygwin.bat" }

config.initial_cols = 125
config.initial_rows = 48

-- Silence the bell
config.audible_bell = "Disabled"

config.visual_bell = {
  fade_in_function = "EaseIn",
  fade_in_duration_ms = 150,
  fade_out_function = "EaseOut",
  fade_out_duration_ms = 150,
}
config.colors = {
  visual_bell = "#202020",
}

-- Cursor
config.default_cursor_style = "BlinkingBlock"

-- Some ssh domains
config.ssh_domains = {
  {
    -- Name for connection, need not be a real hostname
    name = "freedom",
    -- Here is the actual hostname, or IP address
    remote_address = "freedom.kdyfish.org",
    -- Username to login as
    username = "smartin",
  },
}
--
-- -- This is where you actually apply your config choices
--
-- -- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"
-- config.color_scheme = "3024 Night"
-- config.color_scheme = "astromouse (terminal.sexy)"
-- config.color_scheme = "WildCherry"
-- config.color_scheme = "tokyonight-night"
-- config.color_scheme = "Batman"
-- config.color_scheme = "Aurora"
-- config.color_scheme = "Belafonte Day"
config.color_scheme = "Black Metal (Dark Funeral) (base16)"

-- Scroll bars
config.enable_scroll_bar = true
-- Font
config.font = wezterm.font("FiraCode Nerd Font Mono")

config.unix_domains = {
  {
    name = "unix",
  },
}

wezterm.on("toggle-opacity", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.7
  else
    overrides.window_background_opacity = nil
  end
  window:set_config_overrides(overrides)
end)

config.keys = {
  {
    key = "B",
    mods = "CTRL",
    action = wezterm.action({ EmitEvent = "toggle-opacity" }),
  },
}

config.launch_menu = {
  {
    label = "Bash",
    args = { "C:/cygwin64/cygwin.bat" },
  },
  {
    label = "Ubuntu",
    args = { "bash" },
  },
}
-- and finally, return the configuration to wezterm
return config
