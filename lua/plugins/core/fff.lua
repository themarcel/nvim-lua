return {
	"dmtrKovalenko/fff.nvim",
	-- build = "cargo build --release",
	-- build = "nix run .#release", -- or if you are using nixos
	build = function()
		-- this will download prebuild binary or try to use existing rustup toolchain to build from source
		-- (if you are using lazy you can use gb for rebuilding a plugin if needed)
		require("fff.download").download_or_build_binary()
	end,
	enabled = false,
	opts = {
		base_path = vim.fn.getcwd(),
		prompt = "> ",
		title = "FFFiles",
		max_results = 100,
		max_threads = 4,
		layout = {
			height = 0.8,
			width = 0.8,
			prompt_position = "bottom", -- or 'top'
			preview_position = "right", -- or 'left', 'right', 'top', 'bottom'
			preview_size = 0.5,
		},
		preview = {
			enabled = false,
			max_size = 10 * 1024 * 1024, -- Do not try to read files larger than 10MB
			chunk_size = 8192, -- Bytes per chunk for dynamic loading (8kb - fits ~100-200 lines)
			binary_file_threshold = 1024, -- amount of bytes to scan for binary content (set 0 to disable)
			imagemagick_info_format_str = "%m: %wx%h, %[colorspace], %q-bit",
			line_numbers = false,
			wrap_lines = false,
			show_file_info = true,
			filetypes = {
				svg = { wrap_lines = true },
				markdown = { wrap_lines = true },
				text = { wrap_lines = true },
			},
		},
		keymaps = {
			close = "<Esc>",
			select = "<CR>",
			select_split = "<C-s>",
			select_vsplit = "<C-v>",
			select_tab = "<C-t>",
			move_up = { "<Up>", "<C-p>" },
			move_down = { "<Down>", "<C-n>" },
			preview_scroll_up = "<C-u>",
			preview_scroll_down = "<C-d>",
			toggle_debug = "<F2>",
		},
		hl = {
			border = "FloatBorder",
			normal = "Normal",
			cursor = "CursorLine",
			matched = "IncSearch",
			title = "Title",
			prompt = "Question",
			active_file = "Visual",
			frecency = "Number",
			debug = "Comment",
		},
		frecency = {
			enabled = true,
			db_path = vim.fn.stdpath "cache" .. "/fff_nvim",
		},
		debug = {
			enabled = true, -- Set to true to show scores in the UI
			show_scores = true,
		},
		logging = {
			enabled = true,
			log_file = vim.fn.stdpath "log" .. "/fff.log",
			log_level = "info",
		},
	},
	keys = {
		{
			"<leader>f",
			function()
				require("fff").find_files()
			end,
			desc = "FFFind files",
		},
		{
			"<leader>rg",
			function()
				require("fff").live_grep()
			end,
			desc = "LiFFFe grep",
		},
		{
			"<leader>rp",
			function()
				require("fff").live_grep {
					grep = {
						modes = { "fuzzy", "plain" },
					},
				}
			end,
			desc = "Live fffuzy grep",
		},
		{
			"<leader>rw",
			function()
				require("fff").live_grep { query = vim.fn.expand "<cword>" }
			end,
			desc = "Search current word",
		},
	},
}
