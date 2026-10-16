-- =============================================================================
-- General Options =============================================================
-- =============================================================================

require('mini.icons').setup()


-- ======== UI =================================================================

vim.g.havenerdfont = true

vim.cmd.colorscheme("miniautumn")

vim.opt.number         = true -- line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline     = true -- highlight current line
vim.opt.signcolumn     = "yes" -- always show a sign column
vim.opt.scrolloff      = 5 -- keep 5 lines above/below cursor
vim.opt.sidescrolloff  = 5 -- keep 5 lines to left/right of cursor
vim.opt.showmatch      = true -- highlights matching brackets
vim.opt.mouse          = 'a' -- Enable mouse support
vim.opt.clipboard      = 'unnamedplus' -- Check why we need to use unnamedplus specifically
vim.opt.splitright     = true
vim.opt.winbar         = ' '
vim.opt.splitright     = false
vim.opt.splitbelow     = false

vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('vertical-help', {clear = true}),
	desc = 'Force new help windows to open to the left.',
	pattern = 'help',
	command = 'wincmd H',
})

require('aucmds').on_color_hl(
	'Make winbars transparent.',
	{
		{
			ns_id = 0,
			name = 'WinBar',
			opts = {
				link = nil,
				fg = nil,
				bg = nil,
			}
		},

		{
			ns_id = 0,
			name = 'WinBarNC',
			opts = {
				link = nil,
				fg = nil,
				bg = nil,
			}
		}
	}
)


require('mini.notify').setup()
require('mini.indentscope').setup({
	draw = {
		delay = 0,
		animation = require('mini.indentscope').gen_animation.none()
	}
})

vim.opt.showmode = false
require('mini.statusline').setup()

require('aucmds').on_color_hl(
	'Invert MiniStatutslineInactive group.',
	{
		{
			ns_id = 0,
			name = 'MiniStatuslineInactive',
			opts = {
				reverse = true,
			}
		},
	}
)


vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Thin window seperators
require('aucmds').on_color_hl(
	'Thin window separators.',
	{
		{
			ns_id = 0,
			name = 'WinSeparator',
			opts = {
				bg = 'NONE'
			}
		}
	}
)

vim.opt.winborder = 'rounded'


-- ======== Navigation =========================================================

-- TODO: Center picker
require('mini.files').setup()





-- ======== Indent and Wrap ====================================================
vim.opt.wrap        = false -- do not wrap lines by default
vim.opt.tabstop     = 2     -- tabwidth
vim.opt.shiftwidth  = 2     -- indent width
vim.opt.softtabstop = 2     -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab   = false -- use spaces instead of tabs
vim.opt.smartindent = true  -- smart auto-indent
vim.opt.autoindent  = true  -- copy indent from current line



-- ======== Search =============================================================
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase  = true -- case sensitive if uppercase in string
vim.opt.hlsearch   = true -- highlight search matches
vim.opt.incsearch  = true -- show matches as you type

require('fzf-lua').setup()


-- ======== Folding ============================================================
-- Default Folding settings. 
-- Tree-sitter folding enabled in autocommand. (See init.lua)
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel  = 99 -- Starts with all folds open
vim.opt.foldcolumn = "1"

-- Remove trailing dots from folded text.
vim.opt.fillchars:append({
  fold = " ",
})



require('aucmds').on_color(
	'Set fold colors to be the inverse of comment colors.',
	function ()
    local comment = vim.api.nvim_get_hl(0, { name = "NonText", link = false })
    local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    vim.api.nvim_set_hl(0, "Folded", {
      fg = normal.bg,
      bg = comment.fg,
    })
	end
)



