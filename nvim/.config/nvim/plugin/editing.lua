-- =============================================================================
-- Editing =====================================================================
-- =============================================================================

--[[
Auto formatting options while typing.
	r - Auto insert comment symbol on new line.
	o - Auto insert comment symbol on `o/O` in normal mode.
We remove these options globally. Can always add them back later.
--]]
-- TODO: Wrap in autocommand (doesn't work when splitting or changing themes)
vim.opt.formatoptions:remove({'r', 'o'})
-- vim.opt.formatoptions:append('c')

require('mini.ai').setup()
require('mini.pairs').setup()
--[[
Surround Actions
add       - `sa` + motion + thing to surround with
delete    - `sd` + thing to delete
replace   - `sr` + thing to replace + think to replace with
find      - `sf` + thing to find
highlight - `sh` + thing

--]]
require('mini.surround').setup()


require('mini.move').setup({
	mappings ={
		left  = '<C-h>',
		down  = '<C-j>',
		up    = '<C-k>',
		right = '<C-l>',
		-- Move not enabled in normal mode.
		-- In normal mode, same mappings are used for window navigation
	}
})
