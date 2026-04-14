-- [[ Configure plugins ]]
require("lazy").setup({
	-- Essential core plugins only for ultra-fast startup
	"stevearc/profile.nvim",
	{ "tpope/vim-sleuth", event = "BufReadPost" }, -- Detect tabstop and shiftwidth automatically

	-- Optional: Uncomment these if needed (adds startup time)
	-- "nacro90/numb.nvim",
	-- "andreshazard/vim-freemarker",
	-- { "sindrets/diffview.nvim", lazy = true, cmd = "DiffviewOpen" },
	-- "NoahTheDuke/vim-just",
	-- "kevinhwang91/nvim-bqf",
	-- { "stevearc/dressing.nvim", opts = {} },
	-- "mickael-menu/zk-nvim",
	-- "wellle/targets.vim",
	-- "kilavila/nvim-gitignore",
	-- { "kaarmu/typst.vim", ft = { "typ" } },

	-- NOTE: This is where your plugins related to LSP can be installed.
	--  The configuration is done below. Search for lspconfig to find it below.
	-- {
	-- 	-- LSP Configuration & Plugins
	-- 	"neovim/nvim-lspconfig",
	--    version = "2.1.0",
	-- 	dependencies = {
	-- 		-- Automatically install LSPs to stdpath for neovim
	-- 		{
	-- 			"williamboman/mason.nvim",
	-- 			config = true,
	-- 			opts = { PATH = "append" },
	-- 		},
	--      { "williamboman/mason-lspconfig.nvim", version = "1.32.0"}
	--
	-- 	},
	-- },
  -- TODO: Fix nvim treesitter
	-- {
	-- 	-- Highlight, edit, and navigate code
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	-- Load treesitter when opening files with content
	-- 	event = { "BufReadPost", "BufNewFile" },
	-- 	dependencies = {
	-- 		{
	-- 			"nvim-treesitter/nvim-treesitter-textobjects",
	-- 			event = { "BufReadPost", "BufNewFile" },
	-- 		},
	-- 		{ "marcelarie/tree-sitter-kanshi", ft = "kanshi" },
	-- 	},
	-- 	build = ":TSUpdate",
	-- },
	--    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins

	-- Dynamic plugin loading based on profile
	unpack(require("plugin-profiles").get_imports()),
}, {
	change_detection = {
		notify = false,
	},
	dev = {
		path = "~/clones/forks/",
	},
})

-- vim: ts=2 sts=2 sw=2 et
