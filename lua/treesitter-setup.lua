local function safe_require(module_name, callback)
	local status, module = pcall(require, module_name)
	if status and callback then
		callback(module)
	elseif not status then
		vim.api.nvim_echo(
			{ { "Module " .. module_name .. " not found", "WarningMsg" } },
			true,
			{}
		)
	end
	return status, module
end
-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
	safe_require("nvim-treesitter.configs", function(configs)
		configs.setup {
			-- auto_install = true,
			highlight = {
				enable = true,
				disable = function(_, bufnr)
					return vim.api.nvim_buf_line_count(bufnr) > 5000
				end,
				additional_vim_regex_highlighting = {
					"org",
					"diff",
					"gitcommit",
				},
			},
		}
	end)

	safe_require("nvim-treesitter.parsers", function(parsers)
		local parser_config = parsers.get_parser_configs()

		parser_config.kanshi = {
			install_info = {
				url = "https://github.com/marcelarie/tree-sitter-kanshi",
				-- url = "~/clones/own/tree-sitter-kanshi",
				files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
				-- optional entries:
				branch = "main", -- default branch in case of git repo if different from master
				generate_requires_npm = false, -- if stand-alone parser without npm dependencies
				requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
			},
			filetype = "kanshi", -- if filetype does not match the parser name
		}

		parser_config.zig = {
			install_info = {
				url = "~/clones/forks/tree-sitter-zig",
				files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
				-- optional entries:
				branch = "main", -- default branch in case of git repo if different from master
				generate_requires_npm = false, -- if stand-alone parser without npm dependencies
				requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
			},
			filetype = "zig", -- if filetype does not match the parser name
		}
		-- require("nvim-treesitter.parsers").get_parser_configs().kanshi = {
		-- 	install_info = {
		-- 		url = "~/clones/own/tree-sitter-kanshi/",
		-- 		files = { "src/parser.c" },
		-- 	},
		-- 	filetype = "kanshi", -- Filetype associated with this grammar
		-- }

		-- vim.keymap.set(
		-- 	"n",
		-- 	"<leader>ts",
		-- 	":TSPlaygroundToggle<CR>",
		-- 	{ desc = "Toggle Treesitter playground" }
		-- )
	end)
end, 0)

-- vim: ts=2 sts=2 sw=2 et
