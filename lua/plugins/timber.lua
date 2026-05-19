return {
	"Goose97/timber.nvim",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	lazy = true,
	config = function()
		require("timber").setup {
			-- Configuration here, or leave empty to use defaults
			-- The string to search for when deleting or commenting log statements
			-- Can be used in log templates as %log_marker placeholder
			log_marker = "🪵",
			-- Controls the flash highlight after a log statement is inserted
			-- or a log target is added to a batch
			highlight = {
				on_insert = true,
				on_add_to_batch = true,
				duration = 100,
			},
			keymaps = {
				-- Set to false to disable the default keymap for specific actions
				-- insert_log_below = false,
				insert_log_below = "glj",
				insert_log_above = "glk",
				insert_plain_log_below = "glo",
				insert_plain_log_above = "gl<S-o>",
				insert_batch_log = "glb",
				add_log_targets_to_batch = "gla",
				insert_log_below_operator = "g<S-l>j",
				insert_log_above_operator = "g<S-l>k",
				insert_batch_log_operator = "g<S-l>b",
				add_log_targets_to_batch_operator = "g<S-l>a",
			},
			-- Set to false to disable all default keymaps
			default_keymaps_enabled = false,
			log_watcher = {
				enabled = false,
				sources = {},
				preview_snippet_length = 32,
			},
		}

		-- vim.keymap.set("n", "<leader>p", function()
		-- 	require("timber.actions").insert_log {
		-- 		position = "below",
		-- 	}
		-- end, {
		-- 	noremap = true,
		-- 	silent = false,
		-- 	desc = "Insert log statement below",
		-- })

		vim.api.nvim_create_user_command("CreateLogUnderCursor", function()
			require("timber.actions").insert_log { position = "below" }
		end, { desc = "Insert log statement below" })
	end,
	keys = {
		{
			"<leader>p",
			function()
				require("timber.actions").insert_log { position = "below" }
			end,
			desc = "Insert log statement below",
		},
		{
			"<leader>P",
			function()
				require("timber.actions").insert_log { position = "above" }
			end,
			desc = "Insert log statement above",
		},
	},
}
