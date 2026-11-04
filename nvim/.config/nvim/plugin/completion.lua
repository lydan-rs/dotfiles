-- =============================================================================
-- Completion ==================================================================
-- =============================================================================

vim.opt.autocomplete = true
vim.opt.complete = { 'o', ']', '.', 'f', }
vim.opt.completeopt = {
	'fuzzy',
	'menuone',
	'popup',
	'noselect',
}
vim.opt.pumborder = "rounded"
vim.opt.winborder = "rounded"
local pmenu = vim.api.nvim_get_hl(0,
	{
		name = "Pmenu",
		link = false,
	})
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = pmenu.bg, })
-- vim.api.nvim_set_hl(0, 'PmenuBorder', { bg = 'red' })



-- Add a rounded border to all LSP floating windows (hover, signature help)
local orig_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig_open_floating_preview(contents, syntax, opts, ...)
end

local function set_popup_border(winid)
	if winid and winid >= 0 and vim.api.nvim_win_is_valid(winid) then
		pcall(vim.api.nvim_win_set_config, winid, { border = "rounded" })
	end
end

-- Case 1: item already has `info` — popup is created by C code before CompleteChanged
-- Lua callbacks fire; grab preview_winid after yielding to the event loop.
vim.api.nvim_create_autocmd("CompleteChanged", {
	group = vim.api.nvim_create_augroup("CompletionPopupBorder", { clear = true }),
	callback = function()
		vim.schedule(function()
			local info = vim.fn.complete_info({ "selected" })
			set_popup_border(info.preview_winid)
		end)
	end,
})

-- Case 2: async LSP completionItem/resolve — popup is created via nvim__complete_set
-- after a network round-trip, long after CompleteChanged has already fired.
if vim.api.nvim__complete_set then
	local orig = vim.api.nvim__complete_set
	---@diagnostic disable-next-line: duplicate-set-field
	vim.api.nvim__complete_set = function(index, opts)
		local windata = orig(index, opts)
		set_popup_border(windata and windata.winid)
		return windata
	end
end


vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = {
	"longest:full",
	"full",
} -- complete longest common match, full completion list, cycle through with Tab



-- require('blink.compat').setup({})
-- require('blink.cmp').setup({
-- 	keymap = { preset = 'default' },
--
-- 	completion = {
-- 		documentation = { auto_show = false },
-- 		menu = {
-- 			draw = {
-- 				columns = {
-- 					{ "label", "label_description", gap = 1 },
-- 					{ "kind_icon", "kind", gap = 1 },
-- 					{ "source_name" },
-- 					{ "source_id" },
-- 				},
-- 			},
-- 		},
-- 	},
-- 	snippets = { preset = 'luasnip'},
--
-- 	-- TODO: Checkout opts_extend
-- 	sources = {
-- 		default = { 'lsp', 'snippets', 'path' },
--
-- 		per_filetype = {
-- 			tex = { 'vimtex', 'snippets', 'path' }
-- 		},
--
-- 		providers = {
-- 			vimtex = {
-- 				name = 'vimtex',
-- 				module = 'blink.compat.source',
-- 				score_offset = 15,
-- 			},
-- 		},
-- 	},
--
-- 	-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
-- 	-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
-- 	-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
-- 	--
-- 	-- See the fuzzy documentation for more information
-- 	fuzzy = { implementation = "prefer_rust_with_warning" }
-- })
--
--
--
