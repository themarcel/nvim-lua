local runner = require "lib.runner"

vim.api.nvim_create_autocmd("FileType", {
	pattern = "sh",
	callback = function()
		local function get_command(args)
			local cmd = "bash " .. vim.fn.expand "%"
			if args ~= "" then
				cmd = cmd .. " " .. args
			end
			return cmd
		end

		local r = runner.create(get_command, { use_tmux = true })

		vim.keymap.set(
			"n",
			"<leader>r",
			r.run,
			{ buffer = true, silent = true }
		)

		vim.keymap.set("n", "<leader>R", function()
			r.run(vim.fn.input "Args: ")
		end, { buffer = true, silent = true })

		vim.keymap.set(
			"n",
			"<leader>rd",
			r.run_with_diff,
			{ buffer = true, silent = true }
		)

		vim.keymap.set("n", "<leader>rD", function()
			r.run_with_diff(vim.fn.input "Args: ")
		end, { buffer = true, silent = true })

		-- Keep the old terminal keymaps for vsplit terminal
		vim.keymap.set("n", "<leader>t", function()
			vim.cmd "w"
			vim.cmd "vsplit | terminal bash %"
		end, { buffer = true, silent = true })

		vim.keymap.set("n", "<leader>T", function()
			local args = vim.fn.input "Args: "
			vim.cmd "w"
			vim.cmd(
				"vsplit | terminal bash " .. vim.fn.expand "%" .. " " .. args
			)
		end, { buffer = true, silent = true })
	end,
})
