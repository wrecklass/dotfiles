-- Pull in the wezterm API
local wezterm = require("wezterm")
--
-- -- This will hold the configuration.
local config = wezterm.config_builder()

-- Silence the bell
config.audible_bell = "Disabled"

-- Cursor
config.default_cursor_style = "BlinkingBlock"

-- Some ssh domains
config.ssh_domains = {
	{
		-- Name for connection, need not be a real hostname
		name = "indy",
		multiplexing = "None",
		-- Here is the actual hostname, or IP address
		-- remote_address = "indy.kdyfish.org",
		remote_address = "192.168.1.47",
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
		overrides.window_background_opacity = 0.65
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
-- -- and finally, return the configuration to wezterm
return config
