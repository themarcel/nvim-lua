return {
	"chenxin-yan/footnote.nvim",
	-- dir = "~/clones/forks/footnote.nvim/",
	-- config = function()
	-- 	require("footnote").setup {}
	-- end,
	opts = {
		debug_print = false,
		keys = {
			n = {
				new_footnote = "<leader>fn",
				organize_footnotes = "<leader>fo",
				next_footnote = "]f",
				prev_footnote = "[f",
				link_footnote = "<leader>fl",
			},
			i = { new_footnote = "<C-f>" },
			v = { link_footnote = "<leader>fl" },
		},
		organize_on_save = false,
		organize_on_new = false,
		case_sensitive_link = true,
	},
}
