local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Ayu Dark theme colors
config.colors = {
	foreground = "#bfbdb6",
	background = "#0d1017",
	cursor_bg = "#e6b450",
	cursor_fg = "#0d1017",
	cursor_border = "#e6b450",
	selection_bg = "#273747",
	selection_fg = "#bfbdb6",
	ansi = {
		"#0d1017", -- black
		"#f07178", -- red
		"#aad94c", -- green
		"#e6b450", -- yellow
		"#39bae6", -- blue
		"#d2a6ff", -- magenta
		"#95e6cb", -- cyan
		"#bfbdb6", -- white
	},
	brights = {
		"#636a72", -- bright black
		"#f07178", -- bright red
		"#aad94c", -- bright green
		"#ffb454", -- bright yellow
		"#59c2ff", -- bright blue
		"#d2a6ff", -- bright magenta
		"#95e6cb", -- bright cyan
		"#ffffff", -- bright white
	},
	tab_bar = {
		background = "#0b0e14",
		active_tab = {
			bg_color = "#0d1017",
			fg_color = "#bfbdb6",
		},
		inactive_tab = {
			bg_color = "#0b0e14",
			fg_color = "#636a72",
		},
		inactive_tab_hover = {
			bg_color = "#131721",
			fg_color = "#bfbdb6",
		},
		new_tab = {
			bg_color = "#0b0e14",
			fg_color = "#636a72",
		},
		new_tab_hover = {
			bg_color = "#131721",
			fg_color = "#bfbdb6",
		},
	},
}

-- Transparent blurred background
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

-- Window styling
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 12,
	right = 12,
	top = 12,
	bottom = 12,
}

-- Font settings
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14.0

-- Tab bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Cursor
config.default_cursor_style = "SteadyBar"

-- macOS: Let Alt send raw escape sequences (for word jumping, etc.)
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- Key bindings
config.keys = {
	-- Vertical split (CMD+Shift+D)
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Horizontal split (CMD+D)
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Navigate panes (CMD+OPT+Arrow)
	{
		key = "LeftArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	-- Word jumping (OPT+Arrow)
	{
		key = "LeftArrow",
		mods = "OPT",
		action = wezterm.action.SendString("\x1bb"),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action.SendString("\x1bf"),
	},
	-- Toggle pane zoom (CMD+Shift+Enter)
	{
		key = "Enter",
		mods = "CMD|SHIFT",
		action = wezterm.action.TogglePaneZoomState,
	},
}

return config
