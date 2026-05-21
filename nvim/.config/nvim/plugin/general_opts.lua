-- =============================================================================
-- General Options =============================================================
-- =============================================================================

require('mini.icons').setup()


-- ======== UI =================================================================
-- local colorscheme_augroup = vim.api.nvim_create_augroup('colorscheme-augroup', {clear = true })
-- local make_aucmd_on_colorscheme = function (callback, description)
-- 	vim.api.nvim_create_autocmd({"UIEnter", "ColorScheme"}, {
-- 		desc = description,
-- 		group = colorscheme_augroup,
-- 		callback = callback,
-- 	})
-- end

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



-- ======== Editing ============================================================
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


-- ======== Indent and Wrap ====================================================
vim.opt.wrap        = false -- do not wrap lines by default
vim.opt.tabstop     = 2     -- tabwidth
vim.opt.shiftwidth  = 2     -- indent width
vim.opt.softtabstop = 2     -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab   = false -- use spaces instead of tabs
vim.opt.smartindent = true  -- smart auto-indent
vim.opt.autoindent  = true  -- copy indent from current line

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


-- ======== Search =============================================================
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase  = true -- case sensitive if uppercase in string
vim.opt.hlsearch   = true -- highlight search matches
vim.opt.incsearch  = true -- show matches as you type

require('fzf-lua').setup()
-- local fzf_lua = require('fzf-lua')
-- fzf_lua.setup()
-- vim.keymap.set("n", "<leader>ff", fzf_lua.files, { desc = "find files" })
-- vim.keymap.set("n", "<leader>fg", fzf_lua.live_grep, { desc = "live grep" })
-- vim.keymap.set("n", "<leader>fb", fzf_lua.buffers, { desc = "find buffers" })
-- vim.keymap.set("n", "<leader>fh", fzf_lua.help_tags, { desc = "help tags" })
-- vim.keymap.set("n", "<leader>fo", fzf_lua.oldfiles, { desc = "recent files" })
-- vim.keymap.set("n", "<leader>fr", fzf_lua.lsp_references, { desc = "lsp references" })
-- vim.keymap.set("n", "<leader>fr", fzf_lua.resume, { desc = "resume search" })
-- vim.keymap.set("n", "<leader>fd", fzf_lua.lsp_definitions, { desc = "lsp definitions" })
-- vim.keymap.set("n", "<leader>fs", fzf_lua.lsp_document_symbols, { desc = "lsp document symbols" })
-- vim.keymap.set("n", "<leader>fo", fzf_lua.builtin, { desc = "fzf-lua search options" })


-- ======== Folding ============================================================
-- Set to indent and set expression on a per filetype basis
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr   = "v:lua.vim.treesitter.foldexpr()"
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


-- ======== Completion =========================================================
-- vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.completeopt = {
	"menuone",
	-- "noinsert",
	"noselect",
	-- "fuzzy",
	-- "popup",
}

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = {
	"longest:full",
	"full",
} -- complete longest common match, full completion list, cycle through with Tab

-- vim.opt.shortmess:append('c') -- Reccommended by mini.completion
-- vim.opt.complete:remove('t') -- Recommeneded by mini.completion

-- ======== Diagnostics ========================================================
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',  -- You can use '■', '●', '▎', etc.
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false, -- Optional: disables updates while in insert mode
  severity_sort = true,
})
