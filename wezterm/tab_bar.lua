local wezterm = require("wezterm")

-- module table
local module = {}

-- module.colorscheme = wezterm.config.color_scheme

module.process_icons = {
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["btm"] = wezterm.nerdfonts.fa_area_chart,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["curl"] = wezterm.nerdfonts.md_flattr,
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["fish"] = wezterm.nerdfonts.md_fish,
	["gh"] = wezterm.nerdfonts.md_github,
	["git"] = wezterm.nerdfonts.dev_git,
	["go"] = wezterm.nerdfonts.seti_go,
	["htop"] = wezterm.nerdfonts.md_chart_donut_variant,
	["kubectl"] = wezterm.nerdfonts.md_kubernetes,
	["kuberlr"] = wezterm.nerdfonts.md_kubernetes,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["lazygit"] = wezterm.nerdfonts.oct_git_compare,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["make"] = wezterm.nerdfonts.dev_gnu,
	["node"] = wezterm.nerdfonts.md_nodejs,
	["nvim"] = wezterm.nerdfonts.linux_neovim,
	["psql"] = wezterm.nerdfonts.dev_postgresql,
	["python"] = wezterm.nerdfonts.md_language_python,
	["ruby"] = wezterm.nerdfonts.cod_ruby,
	["stern"] = wezterm.nerdfonts.linux_docker,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["usql"] = wezterm.nerdfonts.dev_mysql,
	["vim"] = wezterm.nerdfonts.dev_vim,
	["wget"] = wezterm.nerdfonts.md_arrow_down_box,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
}

function module.apply_to_config(config)
	local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
	config.window_frame = {
		font_size = config.font_size - 2,
		font = config.font,
	}
end

-- Return the Tab's current working directory
function module.get_cwd(tab)
	local pane_dir = tab.active_pane.current_working_dir
	if pane_dir then
		return pane_dir.file_path
	end
	return ""
end

-- Remove all path components and return only the last value
function module.remove_abs_path(path)
	return path:gsub("(.*[/\\])(.*)", "%2")
end

-- Return the pretty path of the tab's current working directory
function module.get_display_cwd(tab)
	local current_dir = module.get_cwd(tab)
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))
	return current_dir == HOME_DIR and "~/" or module.remove_abs_path(current_dir)
end

-- Return the concise name or icon of the running process for display
function module.get_process(tab)
	if not tab.active_pane or tab.active_pane.foreground_process_name == "" then
		return "[?]"
	end

	local process_name = module.remove_abs_path(tab.active_pane.foreground_process_name)
	if process_name:find("kubectl") then
		process_name = "kubectl"
	end

	return module.process_icons[process_name] or string.format("[%s]", process_name)
end

-- Pretty format the tab title
function module.format_title(tab)
	local cwd = module.get_display_cwd(tab)
	local process = module.get_process(tab)

	local active_title = tab.active_pane.title
	if active_title:find("- NVIM") then
		active_title = active_title:gsub("^([^ ]+) .*", "%1")
	end

	local description = (not active_title or active_title == cwd) and "~" or active_title
	return string.format(" %s %s/ %s ", process, cwd, description)
end

-- Determine if a tab has unseen output since last visited
function module.has_unseen_output(tab)
	if not tab.is_active then
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then
				return true
			end
		end
	end
	return false
end

-- Returns manually set title (from `tab:set_title()` or `wezterm cli set-tab-title`) or creates a new one
function module.get_tab_title(tab)
	local title = tab.tab_title
	if title and #title > 0 then
		return title
	end
	return module.format_title(tab)
end

-- Convert arbitrary strings to a unique hex color value
-- Based on: https://stackoverflow.com/a/3426956/3219667
function module.string_to_color(str)
	-- Convert the string to a unique integer
	local hash = 0
	for i = 1, #str do
		hash = string.byte(str, i) + ((hash << 5) - hash)
	end

	-- Convert the integer to a unique color
	local c = string.format("%06X", hash & 0x00FFFFFF)
	return "#" .. (string.rep("0", 6 - #c) .. c):upper()
end

function module.select_contrasting_fg_color(hex_color)
	-- Note: this could use `return color:complement_ryb()` instead if you prefer or other builtins!

	local color = wezterm.color.parse(hex_color)
	return color:complement_ryb(hex_color)
end

-- On format tab title events, override the default handling to return a custom title
-- Docs: https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
---@diagnostic disable-next-line: unused-local
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = module.get_tab_title(tab)
	local color = module.string_to_color(module.get_cwd(tab))

	if tab.is_active then
		return {
			{ Attribute = { Intensity = "Bold" } },
			{ Background = { Color = color } },
			{ Foreground = { Color = module.select_contrasting_fg_color(color) } },
			{ Text = title },
		}
	end
	if module.has_unseen_output(tab) then
		return {
			{ Foreground = { Color = "#EBD168" } },
			{ Text = title },
		}
	end
	return title
end)

return module
