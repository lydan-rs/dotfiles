vim.b.miniclue_config = {
	sclues = {
		{ mode = {'n', 'x'}, keys = '<Leader>l', desc = '+LaTeX' },
	}
}

local vtmap = function(key, command, description)
	vim.keymap.set(
		'n',
		'<leader>l'..key,
		function() vim.cmd(command) end,
		{
			desc = description,
			buffer = true, -- This buffer only
			silent = true, -- Not echoed on command line
			noremap = true, -- Prevents recursive remapping
		}
	)
end
vtmap('i', 'VimtexInfo', 'Open VimTex info')
vtmap('I', 'VimtexInfo!', 'Open full VimTex info')
vtmap('c', 'VimtexCompile', 'Begin continuous compilation')
vtmap('q', 'VimtexStop', 'Quit continuous compilation')
vtmap('C', 'VimtexCompileSS', 'Begin single-shot compilation') -- TODO: Add in auto-save before single-shot compilation
vtmap('f', 'VimtexView', 'Forward search.')

-- vim.keymap.set('n', '<leader>lc',
-- function() vim.cmd('LspTexlabBuild') end,
-- {
-- 	buffer = true,
-- 	desc = 'Build LaTeX document.'
-- })
--
-- vim.keymap.set('n', '<leader>lf',
-- function() vim.cmd('LspTexlabForward') end,
-- {
-- 	buffer = true,
-- 	desc = 'Show corresponding curor position in text document.'
-- })
