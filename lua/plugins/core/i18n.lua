return {
	"yelog/i18n.nvim",
	enabled = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("i18n").setup {
			locales = { "en" },
			sources = {
				"src/shared/i18n/locales/{locales}/{module}.json",
			},
			namespace_resolver = "react_i18next",
			namespace_separator = ".",
		}
	end,
}
