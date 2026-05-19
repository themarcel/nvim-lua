local M = {}
local tmux = require "lib.tmux"

-- cache management
local function get_cache_dir()
	local cache_dir = vim.fn.stdpath "cache" .. "/runner"
	vim.fn.mkdir(cache_dir, "p")
	return cache_dir
end

local function hash_command(command)
	local handle = io.popen(
		"echo -n " .. vim.fn.shellescape(command) .. " | md5sum | cut -d' ' -f1"
	)
	local result = handle:read "*a"
	handle:close()
	return result:gsub("\n", "")
end

local function get_cache_file(command_hash)
	return get_cache_dir() .. "/" .. command_hash
end

local function write_file(path, content)
	local file = io.open(path, "w")
	if file then
		file:write(content)
		file:close()
	end
end

local function read_file(path)
	local file = io.open(path, "r")
	if file then
		local content = file:read "*a"
		file:close()
		return content
	end
	return nil
end

-- command execution with colored output
local function run_in_tmux_or_terminal(cmd, use_tmux)
	if use_tmux and tmux.inside_tmux_session() then
		tmux.create_tmux_persistent_command(cmd)
	else
		vim.cmd("terminal bash -c '" .. cmd:gsub("'", "'\\''") .. "; bash'")
		vim.cmd "startinsert"
	end
end

local function execute_with_diff(command, use_tmux)
	local command_hash = hash_command(command)
	local cache_file = get_cache_file(command_hash)
	local cached_output = read_file(cache_file)

	if cached_output then
		local new_output_file = vim.fn.tempname()
		vim.fn.system(
			string.format("(%s) > %s 2>/dev/null", command, new_output_file)
		)

		-- check if outputs are identical
		vim.fn.system(
			string.format(
				"diff -q %s %s > /dev/null 2>&1",
				vim.fn.shellescape(cache_file),
				vim.fn.shellescape(new_output_file)
			)
		)
		local has_differences = vim.v.shell_error ~= 0

		if has_differences then
			local diff_cmd = string.format(
				"difft --display=inline --context=10000 %s %s; cp %s %s && rm %s",
				vim.fn.shellescape(cache_file),
				vim.fn.shellescape(new_output_file),
				vim.fn.shellescape(new_output_file),
				vim.fn.shellescape(cache_file),
				vim.fn.shellescape(new_output_file)
			)
			run_in_tmux_or_terminal(diff_cmd, use_tmux)
		else
			vim.fn.system("rm " .. vim.fn.shellescape(new_output_file))
			run_in_tmux_or_terminal(command, use_tmux)
		end
	else
		if use_tmux and tmux.inside_tmux_session() then
			local new_output_file = vim.fn.tempname()
			local cache_cmd = string.format(
				"(%s) | tee %s",
				command,
				vim.fn.shellescape(new_output_file)
			)
			tmux.create_tmux_persistent_command(cache_cmd)
			vim.defer_fn(function()
				local output = read_file(new_output_file)
				if output then
					write_file(cache_file, output)
					vim.fn.system("rm " .. vim.fn.shellescape(new_output_file))
				end
			end, 2000)
		else
			local handle = io.popen(command .. " 2>&1")
			local output = handle:read "*a"
			handle:close()
			write_file(cache_file, output)
			vim.notify(
				"Output cached. Run again to see diff.",
				vim.log.levels.INFO
			)
		end
	end
end

-- public API
function M.create(get_command, opts)
	opts = opts or {}
	local use_tmux = opts.use_tmux ~= false

	return {
		run = function(args)
			vim.cmd "w"
			local cmd = get_command(args or "")
			run_in_tmux_or_terminal(cmd, use_tmux)
		end,

		run_with_diff = function(args)
			vim.cmd "w"
			local cmd = get_command(args or "")
			execute_with_diff(cmd, use_tmux)
		end,
	}
end

function M.clear_cache()
	vim.fn.system("rm -rf " .. vim.fn.shellescape(get_cache_dir()))
	print "Runner cache cleared"
end

return M
