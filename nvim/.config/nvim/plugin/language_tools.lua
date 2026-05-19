-- =============================================================================
-- Language Options ============================================================
-- =============================================================================

local ls = require('luasnip')
require("luasnip.loaders.from_vscode").lazy_load()

require('mason').setup()

-- require('friendly-snippets').setup() Not necessary. Called automatically by blink.
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
		},

		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				-- make lazydev completions top priority (see `:h blink.cmp`)
				score_offset = 100,
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



-- ======== Lua ================================================================
-- Mason Name: lua-language-server
-- TODO: Only enable on lua files.
require('lazydev').setup({
	library = {
		-- See the configuration section for more details
		-- Load luvit types when the `vim.uv` word is found
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})


-- LSP Config Name: lua_ls
vim.lsp.enable('lua_ls')

















