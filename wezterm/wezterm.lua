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

-- ui
config.adjust_window_size_when_changing_font_size = false
config.audible_bell = "Disabled"
config.enable_scroll_bar = false
config.enable_tab_bar = true
config.font = wezterm.font_with_fallback({
	{ family = "FiraCode Nerd Font" },
	{ family = "FantasqueSansM Nerd Font" },
})
config.font_size = 12.0
config.hide_tab_bar_if_only_one_tab = false
config.prefer_to_spawn_tabs = true
config.show_tab_index_in_tab_bar = false
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_rate = 800
config.detect_password_input = true
config.initial_cols = 120
config.initial_rows = 40
config.window_padding = {
	top = "10px",
	bottom = "0px",
	left = "5px",
	right = "5px",
}

-- colors
config.bold_brightens_ansi_colors = true
config.color_scheme = "Argonaut (Gogh)"
-- config.color_scheme = "Galizur"
-- config.color_scheme = "theme2 (terminal.sexy)"
config.char_select_bg_color = "#07adad"
config.char_select_fg_color = "#000505"
config.command_palette_bg_color = "#313457"
config.command_palette_fg_color = "#7c7c80"

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.7,
}

-- this must be applied after font and color scheme
tabbar.apply_to_config(config)

config.ssh_domains = wezterm.default_ssh_domains()

for _, dom in ipairs(config.ssh_domains) do
	if dom.name == "SSHMUX:mac" then
		dom.remote_wezterm_path = "/Applications/WezTerm.app/Contents/MacOS/wezterm"
		dom.local_echo_threshold_ms = 250
	end
end

local gpg_rc, gpg_out, _ = wezterm.run_child_process({ "gpgconf", "--list-dirs", "agent-ssh-socket" })

if gpg_rc then
	local gpg_socket = wezterm.split_by_newlines(gpg_out)[1]
	local ssh_auth_sock = os.getenv("SSH_AUTH_SOCK")
	if ssh_auth_sock ~= gpg_socket then
		config.default_ssh_auth_sock = gpg_socket
	end
end

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
		key = "a",
		mods = "LEADER|CTRL",
		action = act.SendKey({ key = "a", mods = "CTRL" }),
	},
	{
		key = "Space",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			title = "🔍 all the things",
			flags = "FUZZY|TABS|LAUNCH_MENU_ITEMS|DOMAINS|WORKSPACES|COMMANDS",
		}),
	},
	{
		key = "u",
		mods = "LEADER",
		action = act.CharSelect({
			copy_on_select = true,
			copy_to = "ClipboardAndPrimarySelection",
			group = "NerdFonts",
		}),
	},
	{
		key = "x",
		mods = "LEADER",
		action = act.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "z",
		mods = "LEADER",
		action = act.TogglePaneZoomState,
	},
	{
		key = "F11",
		mods = "",
		action = act.ToggleFullScreen,
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
	{
		key = "W",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "New name for workspace:" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					if string.find(line, "^work$") then
						window:perform_action(
							act.SwitchToWorkspace({
								name = line,
								spawn = { domain = { DomainName = "SSHMUX:mac" } },
							}),
							pane
						)
					elseif string.find(line, "^lab$") then
						window:perform_action(
							act.SwitchToWorkspace({
								name = line,
								spawn = { domain = { DomainName = "SSHMUX:p620" } },
							}),
							pane
						)
					else
						window:perform_action(
							act.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end
			end),
		}),
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
