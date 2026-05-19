return {
	"tadmccorkle/markdown.nvim",
	ft = "markdown", -- or 'event = "VeryLazy"'
	config = function()
		require("markdown").setup {}

		vim.keymap.set(
			{ "n", "v" },
			"<leader>to",
			":MDTaskToggle<cr>",
			{ desc = "Toggle todo item" }
		)

		vim.keymap.set(
			"n",
			"<leader>tj",
			":MDListItemBelow<cr>",
			{ desc = "Add todo item below" }
		)

		vim.keymap.set(
			"n",
			"<leader>tk",
			":MDListItemAbove<cr>",
			{ desc = "Add todo item below" }
		)
	end,
}
