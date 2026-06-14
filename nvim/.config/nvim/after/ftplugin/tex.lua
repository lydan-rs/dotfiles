vim.b.miniclue_config = {
	sclues = {
		{ mode = {'n', 'x'}, keys = '<Leader>l', desc = '+LaTeX' },
	}
}

local set = vim.opt_local

set.wrap           = true
set.linebreak      = true
set.number         = false
set.relativenumber = false
set.spell          = true

-- Remap keys for visual line navigation
vim.keymap.set({'n', 'v'},'j', 'gj', {buffer = true, silent = true})
vim.keymap.set({'n', 'v'},'k', 'gk', {buffer = true, silent = true})
vim.keymap.set({'n', 'v'},'$', 'g$', {buffer = true, silent = true})
vim.keymap.set({'n', 'v'},'^', 'g^', {buffer = true, silent = true})


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

