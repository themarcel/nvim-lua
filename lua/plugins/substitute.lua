return {
	"gbprod/substitute.nvim",
	lazy = true,
	keys = {
		{
			"s",
			function()
				require("substitute").operator()
			end,
			mode = "n",
			desc = "Substitute operator",
		},
		{
			"ss",
			function()
				require("substitute").line()
			end,
			mode = "n",
			desc = "Substitute line",
		},
		{
			"S",
			function()
				require("substitute").eol()
			end,
			mode = "n",
			desc = "Substitute to EOL",
		},
		{
			"s",
			function()
				require("substitute").visual()
			end,
			mode = "x",
			desc = "Substitute visual",
		},
	},
	config = function()
		require("substitute").setup {}
	end,
}
