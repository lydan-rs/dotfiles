-- =============================================================================
-- Mason =======================================================================
-- =============================================================================

require('tool_utils').try_mason_setup()

require('tool_utils').try_mason_install('lua-language-server') -- lua_ls
require('tool_utils').try_mason_install('clangd')
require('tool_utils').try_mason_install('basedpyright')


-- =============================================================================
-- LSP =========================================================================
-- =============================================================================

-- LSP Config Name: lua_ls
vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('basedpyright')


