local M = {}

M.try_mason_setup = function()
	local mason = require('mason')
	if not mason.has_setup then
		mason.setup()
	end
end

M.mason_msg = "Hello Mason"

M.try_mason_install = function(tool_name)
	local mason = require('mason')
	if not mason.has_setup then
		vim.notify("Mason is not setup. Unable to install " .. tool_name .. ".",
	vim.log.levels.WARN)
	end

	local mr = require("mason-registry")
	if not mr.is_installed(tool_name) then
		if not mr.has_package(tool_name) then
			vim.notify("No such tool " .. tool_name .. " present in the Mason registry. Unable to install.",
		vim.log.levels.WARN)
		else
			vim.cmd({ cmd = "MasonInstall", args = { tool_name }})
		end
	end
end


return M
