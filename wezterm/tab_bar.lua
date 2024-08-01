-- copied from https://github.com/adriankarlen/bar.wezterm/tree/main
local wez = require("wezterm")

local config = {
	position = "top",
	max_width = 32,
	left_separator = " " .. wez.nerdfonts.fa_chevron_right .. " ",
	right_separator = " " .. wez.nerdfonts.fa_chevron_left .. " ",
	field_separator = " " .. wez.nerdfonts.fa_ellipsis_v .. " ",
	leader_icon = wez.nerdfonts.fa_pause,
	workspace_icon = "",
	pane_icon = "",
	user_icon = wez.nerdfonts.cod_account,
	hostname_icon = wez.nerdfonts.cod_server,
	clock_icon = wez.nerdfonts.fa_clock_o,
	cwd_icon = wez.nerdfonts.fa_folder_open_o,
	enabled_modules = {
		username = true,
		hostname = true,
		clock = true,
		cwd = true,
	},
	modules = {
		workspace = {
			enabled = true,
			icon = "",
		},
		pane = {
			enabled = true,
			icon = "",
		},
		user = {
			enabled = true,
			icon = wez.nerdfonts.cod_account,
		},
		hostname = {
			enabled = true,
			icon = wez.nerdfonts.cod_server,
		},
		clock = {
			enabled = true,
			icon = wez.nerdfonts.fa_clock_o,
		},
		cwd = {
			enabled = true,
			icon = wez.nerdfonts.fa_folder_open_o,
		},
	},
	ansi_colors = {
		workspace = 8,
		leader = 2,
		pane = 7,
		active_tab = 4,
		inactive_tab = 6,
		username = 6,
		hostname = 8,
		clock = 5,
		cwd = 7,
	},
}

local username = os.getenv("USER") or os.getenv("LOGNAME") or os.getenv("USERNAME")
local home = (os.getenv("USERPROFILE") or os.getenv("HOME") or wez.home_dir or ""):gsub("\\", "/")
local is_windows = package.config:sub(1, 1) == "\\"

local M = {}

local function tableMerge(t1, t2)
	for k, v in pairs(t2) do
		if type(v) == "table" then
			if type(t1[k] or false) == "table" then
				tableMerge(t1[k] or {}, t2[k] or {})
			else
				t1[k] = v
			end
		else
			t1[k] = v
		end
	end
	return t1
end

local find_git_dir = function(directory)
	directory = directory:gsub("~", home)

	while directory do
		local handle = io.open(directory .. "/.git/HEAD", "r")
		if handle then
			handle:close()
			directory = directory:match("([^/]+)$")
			return directory
		elseif directory == "/" or directory == "" then
			break
		else
			directory = directory:match("(.+)/[^/]*")
		end
	end

	return nil
end

local get_cwd_hostname = function(pane, search_git_root_instead)
	local cwd, hostname = "", ""
	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		if type(cwd_uri) == "userdata" then
			-- Running on a newer version of wezterm and we have
			-- a URL object here, making this simple!

			---@diagnostic disable-next-line: undefined-field
			cwd = cwd_uri.file_path
			---@diagnostic disable-next-line: undefined-field
			hostname = cwd_uri.host or wez.hostname()
		else
			-- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
			-- which doesn't have the Url object
			cwd_uri = cwd_uri:sub(8)
			local slash = cwd_uri:find("/")
			if slash then
				hostname = cwd_uri:sub(1, slash - 1)
				-- and extract the cwd from the uri, decoding %-encoding
				cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
					return string.char(tonumber(hex, 16))
				end)
			end
		end

		-- Remove the domain name portion of the hostname
		local dot = hostname:find("[.]")
		if dot then
			hostname = hostname:sub(1, dot - 1)
		end
		if hostname == "" then
			hostname = wez.hostname()
		end

		if is_windows then
			cwd = cwd:gsub("/" .. home .. "(.-)$", "~%1")
		else
			cwd = cwd:gsub(home .. "(.-)$", "~%1")
		end

		---search for the git root of the project if specified
		if search_git_root_instead then
			local git_root = find_git_dir(cwd)
			cwd = git_root or cwd ---fallback to cwd
		end
	end

	return cwd, hostname
end

local basename = function(path) -- get filename from path
	if type(path) ~= "string" then
		return nil
	end
	local file = ""
	if M.is_windows then
		file = path:gsub("(.*[/\\])(.*)", "%2") -- replace (path/ or path\)(file) with (file)
	else
		file = path:gsub("(.*/)(.*)", "%2") -- replace (path/)(file) with (file)
	end
	-- remove extension
	file = file:gsub("(%..+)$", "")
	return file
end

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return basename(tab_info.active_pane.title)
end

local get_leader = function(prev)
	local leader = config.leader_icon

	wez.log_info("prev: " .. prev)
	wez.log_info("prev size: " .. #prev)
	wez.log_info("leader: " .. leader)
	wez.log_info("leader size: " .. #leader)

	local spacing = #prev - #leader
	local first_half = math.floor(spacing / 2)
	local second_half = math.ceil(spacing / 2)
	wez.log_info("spacing: " .. spacing)
	wez.log_info("first_half: " .. first_half)
	wez.log_info("second_half: " .. second_half)
	return string.rep(" ", first_half) .. leader .. string.rep(" ", second_half)
end

-- conforming to https://github.com/wez/wezterm/commit/e4ae8a844d8feaa43e1de34c5cc8b4f07ce525dd
-- exporting an apply_to_config function, even though we don't change the users config
M.apply_to_config = function(c, opts)
	-- make the opts arg optional
	if not opts then
		opts = {}
	end

	-- combine user config with defaults
	config = tableMerge(config, opts)

	local scheme = wez.color.get_builtin_schemes()[c.color_scheme]
	local default_colors = {
		tab_bar = {
			background = "transparent",
			active_tab = {
				bg_color = "transparent",
				fg_color = scheme.ansi[config.ansi_colors.active_tab],
			},
			inactive_tab = {
				bg_color = "transparent",
				fg_color = scheme.ansi[config.ansi_colors.inactive_tab],
			},
		},
	}

	if c.colors == nil then
		c.colors = default_colors
	else
		c.colors = tableMerge(default_colors, c.colors)
	end

	c.use_fancy_tab_bar = false
	c.tab_bar_at_bottom = config.position == "bottom"
	c.tab_max_width = config.max_width
end

wez.on("format-tab-title", function(tab, _, _, conf, _, _)
	local palette = conf.resolved_palette

	local index = tab.tab_index + 1
	local offset = #tostring(index) + #config.left_separator + 2
	local title = index .. config.left_separator .. tab_title(tab)

	local width = conf.tab_max_width - offset
	if #title > conf.tab_max_width then
		title = wez.truncate_right(title, width) .. "…"
	end

	local fg = palette.tab_bar.inactive_tab.fg_color
	local bg = palette.tab_bar.inactive_tab.bg_color
	if tab.is_active then
		fg = palette.tab_bar.active_tab.fg_color
		bg = palette.tab_bar.active_tab.bg_color
	end

	return {
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = title .. "  " },
	}
end)

-- Name of workspace
wez.on("update-status", function(window, pane)
	local present, conf = pcall(window.effective_config, window)
	if not present then
		return
	end

	local palette = conf.resolved_palette

	-- left status
	local stat = " " .. config.workspace_icon .. " " .. window:active_workspace() .. " "
	local stat_fg = palette.ansi[config.ansi_colors.workspace]

	if window:leader_is_active() then
		stat_fg = palette.ansi[config.ansi_colors.leader]
		stat = get_leader(stat)
	end

	window:set_left_status(wez.format({
		{ Background = { Color = palette.tab_bar.background } },
		{ Foreground = { Color = stat_fg } },
		{ Text = stat },

		{ Foreground = { Color = palette.ansi[config.ansi_colors.pane] } },
		{ Text = config.pane_icon .. " " .. basename(pane:get_title()) .. " " },
	}))

	-- right status
	local cells = {
		{ Background = { Color = palette.tab_bar.background } },
	}
	local enabled_modules = config.enabled_modules

	if enabled_modules.username then
		table.insert(cells, { Foreground = { Color = palette.ansi[config.ansi_colors.username] } })
		table.insert(cells, { Text = username })
		table.insert(cells, { Foreground = { Color = palette.brights[1] } })
		table.insert(cells, { Text = config.right_separator .. config.user_icon .. config.field_separator })
	end

	local cwd, hostname = get_cwd_hostname(pane, true)
	if enabled_modules.hostname then
		table.insert(cells, { Foreground = { Color = palette.ansi[config.ansi_colors.hostname] } })
		table.insert(cells, { Text = hostname })
		table.insert(cells, { Foreground = { Color = palette.brights[1] } })
		table.insert(cells, { Text = config.right_separator .. config.hostname_icon .. config.field_separator })
	end

	if enabled_modules.clock then
		table.insert(cells, { Foreground = { Color = palette.ansi[config.ansi_colors.clock] } })
		table.insert(cells, { Text = wez.time.now():format("%H:%M") })
		table.insert(cells, { Foreground = { Color = palette.brights[1] } })
		table.insert(cells, { Text = config.right_separator .. config.clock_icon .. "  " })
	end

	if enabled_modules.cwd then
		table.insert(cells, { Foreground = { Color = palette.brights[1] } })
		table.insert(cells, { Text = config.cwd_icon .. " " })
		table.insert(cells, { Foreground = { Color = palette.ansi[config.ansi_colors.cwd] } })
		table.insert(cells, { Text = cwd .. " " })
	end

	window:set_right_status(wez.format(cells))
end)

return M
