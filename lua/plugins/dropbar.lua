return {
	"Bekaboo/dropbar.nvim",
	-- enabled = false,
	event = { "BufReadPost", "BufNewFile" },
	lazy = true,
	config = function()
		---@diagnostic disable-next-line: unused-local
		local sources = require "dropbar.sources"

		require("dropbar").setup {
			bar = {
				sources = {
					sources.path,
					sources.markdown,
					-- sources.lsp,
					-- sources.treesitter,
				},
			},
			icons = {
				enable = false,
				ui = {
					bar = {
						separator = "/",
						-- separator = " > ",
						extends = "…",
					},
					menu = {
						separator = " ",
						indicator = " ",
					},
				},
			},
		}
	end,
}
