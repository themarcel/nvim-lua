local M, ns = {}, vim.api.nvim_create_namespace "import_flash"

if vim.fn.hlexists "FlashImport" == 0 then
	vim.api.nvim_set_hl(0, "FlashImport", { link = "Search" })
end

local function mark(line, s, e)
	local id = vim.api.nvim_buf_set_extmark(0, ns, line, s, {
		end_row = line,
		end_col = e,
		hl_group = "FlashImport",
		priority = 2000,
	})
	vim.defer_fn(function()
		pcall(vim.api.nvim_buf_del_extmark, 0, ns, id)
	end, 150)
end

function M.word(w)
	vim.defer_fn(function()
		local p =
			vim.fn.searchpos("\\<" .. vim.fn.escape(w, "\\") .. "\\>", "nw")
		if p[1] > 0 then
			mark(p[1] - 1, p[2] - 1, p[2] - 1 + #w)
		end
	end, 30)
end

function M.line(l)
	mark(l - 1, 0, #vim.fn.getline(l))
end
return M
