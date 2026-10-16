-- =============================================================================
-- Snippets ====================================================================
-- =============================================================================

require("luasnip.loaders.from_vscode").lazy_load()

local snippets_path = vim.fn.stdpath('config') .. '/lua_snippets/'
vim.notify('LuaSnip snippets folder: ' .. snippets_path)

require('luasnip.loaders.from_lua').lazy_load({
	paths = snippets_path,
	fs_event_providers = {libuv = true},
})

require('luasnip').setup({
	enable_autosnippets = true,
	update_events = {'TextChanged', 'TextChangedI'},
})
