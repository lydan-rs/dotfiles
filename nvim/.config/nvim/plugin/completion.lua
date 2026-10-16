-- =============================================================================
-- Completion ==================================================================
-- =============================================================================

-- vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
-- For insert mode completion.
-- Using Blink for this.
-- vim.opt.completeopt = {
-- 	"menuone",
-- 	-- "noinsert",
-- 	"noselect",
-- 	-- "fuzzy",
-- 	-- "popup",
-- }

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = {
	"longest:full",
	"full",
} -- complete longest common match, full completion list, cycle through with Tab

-- require('friendly-snippets').setup() Not necessary. Called automatically by blink.

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
			lua = { inherit_defaults=true, 'lazydev' },
			-- tex = { 'lsp', 'omni', 'snippets', 'path' }
			tex = { 'vimtex', 'snippets', 'path' }
		},

		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				-- make lazydev completions top priority (see `:h blink.cmp`)
				score_offset = 100,
			},
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



