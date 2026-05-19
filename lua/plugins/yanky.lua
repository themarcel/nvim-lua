return {
	"gbprod/yanky.nvim",
	opts = {},
	keys = {
		{
			"<leader>v",
			function()
				require("yanky.picker").fzf_lua()
			end,
			mode = { "n", "x" },
			desc = "Open Yank History",
		},
	},
}
