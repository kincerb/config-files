local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font("FantasqueSansM Nerd Font")
config.font_size = 12.0
config.bold_brightens_ansi_colors = true
-- config.color_scheme = "Monokai Vivid"
-- config.color_scheme = "Breeze (Gogh)"
config.color_scheme = "Argonaut (Gogh)"
-- config.color_scheme = "Breath Darker (Gogh)"
config.enable_scroll_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.adjust_window_size_when_changing_font_size = false
config.audible_bell = "Disabled"
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.7,
}

wezterm.on("update-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	else
		name = ""
	end

	window:set_right_status(wezterm.format({ { Text = name } }))
end)

config.ssh_domains = {
	{
		name = "garudavm",
		remote_address = "garuda-mate-vm.lan",
		username = "kincerb",
	},
}

config.leader = { key = "Space", mods = "CTRL|SHIFT" }

config.keys = {
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "n",
		mods = "CTRL|SHIFT",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "p",
		mods = "CTRL|SHIFT",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "pane_control",
			one_shot = false,
		}),
	},
	{
		key = "_",
		mods = "CTRL|SHIFT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "|",
		mods = "CTRL|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
}

config.key_tables = {
	pane_control = {
		{ key = "-", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "\\", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = act.ActivatePaneDirection("Left") },
		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = act.ActivatePaneDirection("Right") },
		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = act.ActivatePaneDirection("Up") },
		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = act.ActivatePaneDirection("Down") },
		{ key = "Escape", action = "PopKeyTable" },
	},
}

return config
--# vim: ft=lua ts=2 sw=2 sts=2
