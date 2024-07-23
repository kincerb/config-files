local wezterm = require("wezterm")
local tabbar = require("tab_bar")
-- local tabbar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

local act = wezterm.action
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- core
config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400
config.show_update_window = true

-- ui
config.adjust_window_size_when_changing_font_size = false
config.audible_bell = "Disabled"
config.enable_scroll_bar = false
config.enable_tab_bar = true
config.font = wezterm.font_with_fallback({
	{ family = "FantasqueSansM Nerd Font" },
})
config.font_size = 12.0
config.hide_tab_bar_if_only_one_tab = false
config.prefer_to_spawn_tabs = true
config.show_tab_index_in_tab_bar = false
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true

-- colors
config.bold_brightens_ansi_colors = true
config.color_scheme = "Galizur"

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.7,
}

-- this must be applied after font and color scheme
tabbar.apply_to_config(config)

-- wezterm.on("update-status", function(window, pane)
-- 	local meta = pane:get_metadata() or {}
-- 	local pane_domain = pane:get_domain_name()
-- 	local leader_active = window:leader_is_active()
-- 	local active_table = window:active_key_table()
--
-- 	if active_table then
-- 		window:set_right_status(wezterm.format({
-- 			{ Attribute = { Italic = true } },
-- 			{ Attribute = { Intensity = "Bold" } },
-- 			{ Text = "TABLE: " .. active_table .. " " },
-- 		}))
-- 	elseif leader_active then
-- 		window:set_right_status(wezterm.format({
-- 			{ Attribute = { Italic = true } },
-- 			{ Attribute = { Intensity = "Bold" } },
-- 			{ Text = "LEADER " },
-- 		}))
-- 	else
-- 		local secs
-- 		local status
--
-- 		status = string.format("DOMAIN: %s ", pane_domain)
--
-- 		if meta.is_tardy then
-- 			secs = meta.since_last_response_ms / 1000.0
-- 			status = string.format("LAG: %5.1fs | %s ", secs, status)
-- 		end
-- 		window:set_right_status(wezterm.format({
-- 			{ Attribute = { Italic = true } },
-- 			{ Attribute = { Intensity = "Bold" } },
-- 			{ Text = status },
-- 		}))
-- 	end
-- end)

config.ssh_domains = wezterm.default_ssh_domains()

for _, dom in ipairs(config.ssh_domains) do
	if dom.name == "SSHMUX:mac" then
		dom.remote_wezterm_path = "/Applications/WezTerm.app/Contents/MacOS/wezterm"
	end
end

-- config.default_gui_startup_args = { "connect", "main" }

local fuzzy_commands = act.ShowLauncherArgs({
	title = "🔍 find commands",
	flags = "FUZZY|KEY_ASSIGNMENTS|COMMANDS",
})
local fuzzy_domains = act.ShowLauncherArgs({
	title = "🔍 find domains",
	flags = "FUZZY|DOMAINS",
})
local fuzzy_tabs = act.ShowLauncherArgs({
	title = "🔍 find tabs",
	flags = "FUZZY|TABS|DOMAINS|WORKSPACES",
})

config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2500 }

config.keys = {
	{
		key = "Space",
		mods = "LEADER",
		action = act.ShowLauncher,
	},
	{
		key = "z",
		mods = "LEADER",
		action = act.TogglePaneZoomState,
	},
	{
		key = "f",
		mods = "CTRL|SHIFT",
		action = act.ActivateKeyTable({
			name = "find_stuff",
			one_shot = true,
		}),
	},
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
		key = "]",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},
	{
		key = "c",
		mods = "LEADER",
		action = act.ActivateCommandPalette,
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
		key = "d",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "domain_control",
			one_shot = true,
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
	{
		key = "r",
		mods = "CTRL|SHIFT",
		action = act.ShowDebugOverlay,
	},
}

config.key_tables = {
	find_stuff = {
		{ key = "t", action = fuzzy_tabs },
		{ key = "c", action = fuzzy_commands },
		{ key = "d", action = fuzzy_domains },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "q", action = "PopKeyTable" },
	},
	pane_control = {
		{ key = "-", action = act.SplitVertical({ domain = "DefaultDomain" }) },
		{ key = "\\", action = act.SplitHorizontal({ domain = "DefaultDomain" }) },
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
		{ key = "z", action = act.TogglePaneZoomState },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "q", action = "PopKeyTable" },
	},
	domain_control = {
		{ key = "d", action = act.DetachDomain("CurrentPaneDomain") },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "q", action = "PopKeyTable" },
	},
}

return config
--# vim: ft=lua ts=2 sw=2 sts=2
