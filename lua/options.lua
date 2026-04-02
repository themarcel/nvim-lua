vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable unused builtin plugins for faster startup
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_tutor = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1

-- Global options (o)
vim.o.splitbelow = false
vim.o.splitkeep = "screen"
vim.o.splitright = true
-- vim.o.timeoutlen = O
-- vim.o.guifont = "FiraCode Nerd Font:h15"
vim.opt.guicursor = "i:hor20-Cursor/lCursor" -- Add unerline cursor on Insert and Visual mode
vim.api.nvim_set_hl(0, "CursorLine", { underline = false })

-- vim.g.clipboard = "unnamedplus" -- Set in ./sys-clip.lua
vim.opt.termguicolors = true
vim.cmd.colorscheme "lunaperche"

vim.g.ai_cmp = false

vim.o.expandtab = true
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.cmdheight = 1
vim.o.mouse = "a" -- Mouse support --
vim.o.updatetime = 100 -- Faster completion
vim.o.cursorline = true -- Enable highlighting of the current line

vim.o.conceallevel = 0

vim.o.hidden = true -- Opening a new file when the current buffer has unsaved changes cause files to be hidden instead of closed.

vim.o.smartcase = true -- Case sensitive search.
vim.o.scrolloff = 8 -- 8 lines on top/bottom of cursor when scrolling.
vim.o.timeoutlen = 500 -- Vim will wait for 500 ms after keystroke for the mappings.
vim.o.updatetime = 300 -- Vim waits 300 ms after you stop before it triggers the plugin.

-- Buffer local options (bo?)

-- Window-local options (wo)
vim.wo.wrap = false -- Display long lines as just one line
-- vim.wo.relativenumber = true -- Relative numbers
vim.wo.nu = true -- Show line number
vim.wo.foldnestmax = 1
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.wo.signcolumn = "yes"
vim.wo.colorcolumn = "80"

-- vim.api.nvim_set_option("syntax on")
-- vim.cmd('set path+=**')
vim.opt.laststatus = 3
vim.cmd "set undolevels=10000"
vim.cmd "set undoreload=10000"
-- vim.cmd "set nohlsearch"
vim.opt.listchars = {
	tab = "∙ ",
	trail = "∙",
	eol = " ",
	extends = "❯",
}

vim.opt.list = true

-- undo
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true
vim.o.autoread = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- vim.opt.spelllang = 'en' -- Not supported in Neovim
-- vim.opt.hlsearch = false -- Use vim.opt.hlsearch = nil instead
vim.opt.showcmd = false -- Use vim.opt.showcmd = nil instead
vim.opt.incsearch = true
vim.opt.compatible = false
vim.opt.errorbells = false
-- vim.opt.backupdir = "~/.vim/backup" -- Not supported in Neovim
-- vim.opt.writebackup = true -- Not supported in Neovim
-- vim.opt.backupcopy = 'yes' -- Not supported in Neovim

vim.diagnostic.config {
	-- virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "e ",
			[vim.diagnostic.severity.WARN] = "w ",
			[vim.diagnostic.severity.HINT] = "h ",
			[vim.diagnostic.severity.INFO] = "i ",
		},
	},
	underline = false,
	undercurl = false,
	update_in_insert = false,
	severity_sort = false,
	-- virtual_text = {
	-- 	source = "if_many", -- Or "if_many"
	-- },
	virtual_lines = false,
	virtual_text = {
		prefix = "●", -- Could be '●', '▎', 'x'
	},
	float = {
		source = "always", -- Or "if_many"
	},
}

local border = {
	{ "🭽", "FloatBorder" },
	{ "▔", "FloatBorder" },
	{ "🭾", "FloatBorder" },
	{ "▕", "FloatBorder" },
	{ "🭿", "FloatBorder" },
	{ "▁", "FloatBorder" },
	{ "🭼", "FloatBorder" },
	{ "▏", "FloatBorder" },
}

local another_border = {
	{ "┌", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "┐", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "┘", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "└", "FloatBorder" },
	{ "│", "FloatBorder" },
}

-- vim.cmd [[
-- 	autocmd BufEnter * lua vim.diagnostic.hide(nil,0)
-- ]]

-- vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#000]]
-- vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#f29]]

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
-- 	border = "rounded", -- single, rounded. double
-- 	-- stylize_markdown = false,
-- })

local custom = {
	border = "none",
}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or custom.border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- vim.lsp.handlers["textDocument/signatureHelp"] =
-- 	vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

-- vim: ts=2 sts=2 sw=2 et
