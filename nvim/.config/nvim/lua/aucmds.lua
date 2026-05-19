local M = {}

M.groups = {}
-- M.groups = {
-- 	on_pack = vim.api.nvim_create_augroup('on_pack', {clear = true}),
-- 	on_color = vim.api.nvim_create_augroup('on_color', {clear = true}),
-- 	on_filetype = vim.api.nvim_create_augroup('on_filetype', {clear = true})
-- }

-- on_pack package_name: string hooks: array[string] callback: function
M.on_pack = function (description, package_name, hooks, callback)
	if not M.groups.on_pack then
		M.groups.on_pack = vim.api.nvim_create_augroup('on_pack', {clear = true})
	end

	vim.api.nvim_create_autocmd('PackChanged', {
		group = M.groups.on_pack,
		desc = description,
		callback = function (ctx)
			local name, kind = ctx.data.spec.name, ctx.data.kind

			if name ~= package_name then
				return
			end

			local continue = false
			for _, hook in ipairs(hooks) do
				if hook == kind then
					continue = true
				end
			end

			if not continue then
				return
			end

			callback(ctx)

		end
	})
end


-- on_color description, callback
M.on_color = function (description, callback)
	if not M.groups.on_color then
		M.groups.on_color = vim.api.nvim_create_augroup('on_color', {clear = true})
	end

	vim.api.nvim_create_autocmd({"UIEnter", "ColorScheme"}, {
		desc = description,
		group = M.groups.on_color,
		callback = callback,
	})

end

-- on_color_hl description, group_specs
M.on_color_hl = function (description, group_specs)
	if not M.groups.on_color then
		M.groups.on_color = vim.api.nvim_create_augroup('on_color', {clear = true})
	end

	vim.api.nvim_create_autocmd({"UIEnter", "ColorScheme"}, {
		desc = description,
		group = M.groups.on_color,
		callback = function ()
			for _, spec in ipairs(group_specs) do
				vim.api.nvim_set_hl(spec.ns_id, spec.name, spec.opts)
			end
		end
	})

end

M.on_filetype = function (description, filetypes, callback)
	if not M.groups.on_filetype then
		M.groups.on_filetype = vim.api.nvim_create_augroup('on_filetype', {clear = true})
	end

	vim.api.nvim_create_autocmd('FileType', {
		group = M.groups.on_filetype,
		desc = description,
		pattern = filetypes,
		callback = callback,
	})

end


return M
