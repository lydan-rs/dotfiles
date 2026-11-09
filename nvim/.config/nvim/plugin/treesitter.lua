-- =============================================================================
-- Treesitter ==================================================================
-- =============================================================================

require('nvim-treesitter').install({
	'lua',
	'markdown',
	'c',
	'cpp',
	'cmake',
	'python',
})

require('aucmds').on_filetype(
	'Start treesitter for installed parsers.',
  {
		'lua',
		'markdown',
		'c',
		'cpp',
		'cmake',
		'python',
	},
	function ()
		vim.treesitter.start()
		-- TODO: Seperate this once we install a parser for which we don't have fold queries
		vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.wo[0][0].foldmethod = 'expr'
	end
)
