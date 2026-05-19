local M = {}

function M.typescript_server_import_all()
	if
		vim.bo.filetype == "typescript"
		or vim.bo.filetype == "typescriptreact"
	then
		vim.lsp.buf.code_action {
			apply = true,
			---@diagnostic disable-next-line: missing-fields
			context = {
				only = {
					---@diagnostic disable-next-line: assign-type-mismatch
					"source.addMissingImports.ts",
				},
			},
		}
	else
		vim.api.nvim_err_writeln "Not a typescript file"
		return
	end
end

return M
