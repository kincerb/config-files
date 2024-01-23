local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font("FantasqueSansM Nerd Font")
config.font_size = 12.0
-- config.color_scheme = "Monokai Vivid"
config.color_scheme = "Symphonic (Gogh)"
-- config.color_scheme = "Atelierforest (dark) (terminal.sexy)"
config.enable_scroll_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.adjust_window_size_when_changing_font_size = false

config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.7,
}

wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

return config
--# vim: ft=lua ts=2 sw=2 sts=2
