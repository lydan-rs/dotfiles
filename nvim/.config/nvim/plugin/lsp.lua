-- =============================================================================
-- LSP =========================================================================
-- =============================================================================

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
vim.lsp.enable('clangd')
vim.lsp.enable('basedpyright')


