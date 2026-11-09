if not vim.g.use_blink_cmp then
	return
end

-- =============================================================================
-- Completion ==================================================================
-- =============================================================================

vim.pack.install({
	'https://github.com/rafamadriz/friendly-snippets',
	{
		src = 'https://github.com/saghen/blink.cmp',
		version = vim.version.range('1.x'),
	},
	{
		src = 'https://github.com/saghen/blink.compat',
		version = vim.version.range('2.x'),
	},
	'https://github.com/micangl/cmp-vimtex',
})



require('blink.compat').setup({})
require('blink.cmp').setup({
	keymap = { preset = 'default' },

	completion = {
		documentation = { auto_show = false },
		menu = {
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
					{ "source_name" },
					{ "source_id" },
				},
			},
		},
	},
	snippets = { preset = 'luasnip'},

	-- TODO: Checkout opts_extend
	sources = {
		default = { 'lsp', 'snippets', 'path' },

		per_filetype = {
			tex = { 'vimtex', 'snippets', 'path' }
		},

		providers = {
			vimtex = {
				name = 'vimtex',
				module = 'blink.compat.source',
				score_offset = 15,
			},
		},
	},

	-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
	-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	--
	-- See the fuzzy documentation for more information
	fuzzy = { implementation = "prefer_rust_with_warning" }
})



