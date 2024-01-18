local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "MaterialDark"
config.font_size = 12.0
config.font = wezterm.font("")
config.enable_scroll_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

return config
--# vim: ft=lua ts=2 sw=2 sts=2
