local wezterm = require("wezterm")

-- module table
local module = {}

function module.apply_to_config(config)
	local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
	config.window_frame = {
		font_size = config.font_size - 2,
		font = config.font,
	}
end

return module
