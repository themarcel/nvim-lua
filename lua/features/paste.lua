local function get_visual_text()
	local reg = "z"
	local old = vim.fn.getreg(reg)
	local oldtype = vim.fn.getregtype(reg)

	vim.cmd('silent normal! "' .. reg .. "y")

	local text = vim.fn.getreg(reg)

	vim.fn.setreg(reg, old, oldtype)

	return text
end

local function paste_visual()
	local text = get_visual_text()
	if text == "" then
		vim.notify("Nothing selected", vim.log.levels.WARN)
		return
	end

	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
		"n",
		false
	)

	vim.notify("Generating paste URL…", vim.log.levels.INFO)

	local job = vim.fn.jobstart({
		"curl",
		"-s",
		"--data-binary",
		"@-",
		"https://paste.rs",
	}, {
		stdin = "pipe",
		stdout_buffered = true,
		on_stdout = function(_, data)
			local url = (table.concat(data or {}, "") or ""):gsub("%s+$", "")
			if url ~= "" then
				vim.fn.setreg("+", url)
				vim.schedule(function()
					vim.notify(
						"Paste URL copied to clipboard",
						vim.log.levels.INFO
					)
				end)
			else
				vim.schedule(function()
					vim.notify("Paste failed", vim.log.levels.ERROR)
				end)
			end
		end,
		on_stderr = function(_, data)
			if data and table.concat(data, "") ~= "" then
				vim.schedule(function()
					vim.notify("Paste failed", vim.log.levels.ERROR)
				end)
			end
		end,
	})

	vim.fn.chansend(job, text)
	vim.fn.chanclose(job, "stdin")
end

vim.keymap.set("v", "<leader>p", paste_visual, {
	silent = true,
	desc = "Paste visual selection",
})
