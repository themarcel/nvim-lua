-- Plugin Profiles for different startup performance needs
-- Usage: Set environment variable or call functions to switch profiles

local M = {}

-- Check environment variable for profile selection
local function get_profile()
	local profile = vim.env.NVIM_PROFILE or "minimal"
	return profile
end

-- Get plugin imports based on profile
function M.get_imports()
	local profile = get_profile()

	if profile == "full" then
		return {
			{ import = "plugins" },
			{ import = "plugins.optional" },
		}
	else -- minimal (default)
		return {
			{ import = "plugins" },
		}
	end
end

-- Functions to switch profiles (requires restart)
function M.set_minimal()
	vim.env.NVIM_PROFILE = "minimal"
	print "Profile set to minimal (~14 plugins)"
	print "⚠️  Restart Neovim to apply changes"
	print "Or set NVIM_PROFILE=minimal in your shell for persistence."
end

function M.set_full()
	vim.env.NVIM_PROFILE = "full"
	print "Profile set to full (80+ plugins)"
	print "⚠️  Restart Neovim to apply changes"
	print "Or set NVIM_PROFILE=full in your shell for persistence."
end

-- Print current profile
function M.current_profile()
	print("Current profile: " .. get_profile())
	if get_profile() == "minimal" then
		print "Plugins: Core only (~14 plugins)"
	else
		print "Plugins: Core + Optional (~80+ plugins)"
	end
end

-- Create commands
vim.api.nvim_create_user_command("ProfileMinimal", M.set_minimal, {})
vim.api.nvim_create_user_command("ProfileFull", M.set_full, {})
vim.api.nvim_create_user_command("ProfileCurrent", M.current_profile, {})

return M
