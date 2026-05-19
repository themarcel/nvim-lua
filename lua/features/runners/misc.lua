local tmux = require "lib.tmux"

vim.api.nvim_create_user_command("FindTodos", function()
	tmux.create_tmux_command "~/scripts/find-todos.sh"
end, { desc = "Run ftodos" })

vim.api.nvim_create_user_command("FindTodosSplit", function()
	tmux.create_tmux_split_command "~/scripts/find-todos.sh"
end, { desc = "Run ftodos in a split" })
