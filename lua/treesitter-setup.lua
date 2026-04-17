local function safe_require(module_name, callback)
	local status, module = pcall(require, module_name)
	if status and callback then
		callback(module)
	end
	-- No else block = silent failure, which is usually better for a "clean" startup
	return status, module
end
-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
	-- We skip nvim-treesitter.configs entirely as it is removed in v1.0+

	safe_require("nvim-treesitter.parsers", function(parsers)
		-- Attempt to find the parser configuration table safely
		local parser_config
		if type(parsers.get_parser_configs) == "function" then
			parser_config = parsers.get_parser_configs()
		elseif type(parsers.get_parser_configs) == "table" then
			parser_config = parsers.get_parser_configs
		else
			-- Fallback for the newest v1.0+ structure
			parser_config = parsers
		end

		-- Check if we actually got a table we can write to
		if type(parser_config) == "table" then
			parser_config.kanshi = {
				install_info = {
					url = "https://github.com/marcelarie/tree-sitter-kanshi",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "kanshi",
			}

			parser_config.zig = {
				install_info = {
					url = "~/clones/forks/tree-sitter-zig",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "zig",
			}
		end
	end)
end, 0)

-- vim: ts=2 sts=2 sw=2 et
