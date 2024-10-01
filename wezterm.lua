-- Pull in the wezterm API
local wezterm = require("wezterm")
--
-- -- This will hold the configuration.
local config = wezterm.config_builder()

-- Silence the bell
config.audible_bell = "Disabled"

config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}
config.colors = {
  visual_bell = '#202020',
}

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
config.color_scheme = "Batman"

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
    overrides.window_background_opacity = 0.8
  else
    overrides.window_background_opacity = nil
  end
  window:set_config_overrides(overrides)
end)

return {
  -- Specify the default key bindings
  keys = {
    {
      key = "B",
      mods = "CTRL",
      action = wezterm.action({ EmitEvent = "toggle-opacity" }),
    },
  },
}
-- -- and finally, return the configuration to wezterm
-- return config
