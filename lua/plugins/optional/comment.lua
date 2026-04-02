return {
	"numToStr/Comment.nvim",
	opts = {},
	lazy = true,
	enabled = false, -- gcc comes from nvim core now
	config = function()
		-- Updated configuration for compatibility with nvim-treesitter v1.0+
		local ok, ts_context_commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
		if ok then
			---@diagnostic disable-next-line: missing-fields
			require("Comment").setup {
				pre_hook = ts_context_commentstring.create_pre_hook(),
			}
		else
			-- Fallback to default setup if module is not available
			require("Comment").setup {}
		end

		local comment_ft = require "Comment.ft"
		comment_ft.set("fish", { "# %s", "# %s #" })
		comment_ft.set("bash", { "# %s", "# %s #" })
		comment_ft.set("sh", { "# %s", "# %s #" })
		comment_ft.set("", { "# %s", "# %s #" })
		comment_ft.set("typ", { "// %s", "/* %s */" })
	end,
	keys = {
		{ "gcc", ":Comment<cr>", { noremap = false } },
		{ "gc", ":Comment<cr>", { noremap = false } },
	},
}
