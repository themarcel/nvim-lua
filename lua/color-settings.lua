vim.o.termguicolors = true
local theme_file = vim.fn.expand "$HOME/.cache/.theme_mode"
local theme_file = io.open(theme_file, "r")
if theme_file then
	vim.o.background = theme_file:read "*l" or "dark"
	theme_file:close()
else
	vim.o.background = "dark"
end
vim.cmd.set "t_Co=256"

vim.cmd "hi VertSplit guifg=#373737 guibg=#373737gui=NONE cterm=NONE"

-- Highlights (merged from highlights.lua)
vim.api.nvim_set_hl(0, "RefIdentifier", { fg = "#50fa7b", bold = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "md" },
	callback = function()
		-- vim.fn.matchadd("RefIdentifier", "\\v\\]\\zs\\[[^]]+\\]") -- the whole [label]
		vim.fn.matchadd("RefNumberOnly", "\\v\\[\\zs\\d+\\ze\\]") -- the number only
		vim.api.nvim_set_hl(
			0,
			"RefNumberOnly",
			{ fg = "#ff79c6", bold = false }
		)
	end,
})

vim.api.nvim_set_hl(
	0,
	"@ref.number.markdown_inline",
	{ fg = "#ff79c6", bold = true }
)
vim.api.nvim_set_hl(0, "@ref.number.markdown", { fg = "#ff79c6", bold = false })
