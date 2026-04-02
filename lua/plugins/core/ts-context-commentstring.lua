return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	lazy = true,
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		-- Updated configuration for compatibility with nvim-treesitter v1.0+
		local ok, ts_context_commentstring =
			pcall(require, "ts_context_commentstring")
		if ok then
			ts_context_commentstring.setup {
				enable = true,
				enable_autocmd = false, -- Disable auto-cmd to prevent conflicts
				config = {
					-- Languages that have a single comment style
					css = "// %s",
					scss = "// %s",
					java = "// %s",
					javascript = "// %s",
					javascriptreact = "// %s",
					json = "",
					jsonc = "",
					less = "// %s",
					sass = "// %s",
					scala = "// %s",
					svelte = "// %s",
					typescript = "// %s",
					typescriptreact = "// %s",
					tsx = "// %s",
					xml = "<!-- %s -->",
					xsl = "<!-- %s -->",
					-- Languages that have multiple comment styles
					graphql = {
						__default = "# %s",
						-- For code inside the ```, not the GraphQL queries themselves
						gql = "// %s",
					},
				},
			}
		end
	end,
}

