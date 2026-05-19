local runner = require "lib.runner"

local function get_cargo_run_command(args)
	if args ~= "" then
		return "cargo run " .. args
	else
		return "cargo run"
	end
end

local r = runner.create(get_cargo_run_command, { use_tmux = true })

vim.api.nvim_create_user_command("CargoRun", function(opts)
	r.run(opts.args or "")
end, { desc = "Run cargo run in tmux window", nargs = "?" })

vim.keymap.set("n", "<leader>cr", function()
	r.run()
end, {
	desc = "Run cargo run in tmux window",
	silent = true,
})

vim.keymap.set("n", "<leader>crd", function()
	r.run_with_diff()
end, {
	desc = "Run cargo run with diff in tmux window",
	silent = true,
})

vim.api.nvim_create_user_command("CargoClippy", function()
	local tmux = require "lib.tmux"
	tmux.create_tmux_persistent_command "cargo clippy"
end, { desc = "Run cargo clippy in tmux window" })

vim.api.nvim_create_user_command("CargoTest", function()
	local tmux = require "lib.tmux"
	tmux.create_tmux_persistent_command "cargo test -- --show-output"
end, { desc = "Run cargo test in tmux window" })

vim.keymap.set("n", "<leader>ct", function()
	local tmux = require "lib.tmux"
	tmux.create_tmux_persistent_command "cargo test -- --show-output"
end, {
	desc = "Run cargo test in tmux window",
	silent = true,
})
