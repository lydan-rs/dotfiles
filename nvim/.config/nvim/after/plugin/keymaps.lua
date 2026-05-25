local map = vim.keymap.set
-- =============================================================================
-- Keymaps =====================================================================
-- =============================================================================

-- ======== Navigation =========================================================
-- Center on up and down
map({'n', 'x'}, '<C-d>', '<C-d>zz')
map({'n', 'x'}, '<C-u>', '<C-u>zz')

-- Window Navigation
map('n', '<C-h>', '<C-w><C-h>')
map('n', '<C-j>', '<C-w><C-j>')
map('n', '<C-k>', '<C-w><C-k>')
map('n', '<C-l>', '<C-w><C-l>')

-- ======== Search =============================================================
map('n', '<Leader>o', MiniFiles.open, {desc = 'Open file explorer'})

map('n', '<esc>', '<cmd>nohlsearch<cr>')
-- Center on search
map({'n', 'x'}, 'n', 'nzz')
map({'n', 'x'}, 'N', 'Nzz')

local fzf_lua = require('fzf-lua')
map("n", "<leader>ff", fzf_lua.files, { desc = "find files" })
map("n", "<leader>fg", fzf_lua.live_grep, { desc = "live grep" })
map("n", "<leader>fb", fzf_lua.buffers, { desc = "find buffers" })
map("n", "<leader>fh", fzf_lua.help_tags, { desc = "help tags" })
map("n", "<leader>fo", fzf_lua.oldfiles, { desc = "recent files" })
map("n", "<leader>fr", fzf_lua.lsp_references, { desc = "lsp references" })
map("n", "<leader>fr", fzf_lua.resume, { desc = "resume search" })
map("n", "<leader>fd", fzf_lua.lsp_definitions, { desc = "lsp definitions" })
map("n", "<leader>fs", fzf_lua.lsp_document_symbols, { desc = "lsp document symbols" })
map("n", "<leader>fo", fzf_lua.builtin, { desc = "fzf-lua search options" })


-- ======== LSP ================================================================
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LSPKeybinds', { clear = true }),
  callback = function(event)

		local lsp = vim.lsp.buf
		local buf = event.buf
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		local supports_method = function(method)
			return client:supports_method(method, buf)
		end

    local genOpts = function(description)
      return { desc = description, buffer = buf, silent = true }
    end

		if supports_method('textDocument/definition') then
			map('n', '<leader>gd', lsp.definition, genOpts("Goto Definition"))
		end

		if supports_method('textDocument/declaration') then
			map('n', '<leader>gD', lsp.declaration, genOpts("Goto Declaration"))
		end

		if supports_method('textDocument/implementation') then
			map('n', '<leader>gi', lsp.implementation, genOpts("Goto Implementation"))
		end
		-- vim.lsp.protocol.Methods.textDocument_references
		if supports_method('textDocument/references') then
			map('n', '<leader>gR', lsp.references, genOpts("Goto References"))
		end

		if supports_method('textDocument/type_definition') then
			map('n', '<leader>gt', lsp.type_definition, genOpts("Goto Type Definition"))
		end

		if supports_method('textDocument/hover') then
			local opts = genOpts('Hover')
			map('n', 'K', lsp.hover, opts)
			map('n', '<leader>ch', lsp.hover, opts)
		end

		if supports_method('textDocument/signature_help') then
			local opts = genOpts("Show Signature Help")
			map('n', '<leader>cH', lsp.signature_help, opts)
			map('n', '<C-K>', lsp.signature_help, opts)
		end

		if supports_method('textDocument/rename') then
			map('n', '<leader>cr', lsp.rename, genOpts("Rename Symbol"))
		end

		if supports_method('textDocument/code_action') then
			map({ 'n', 'v' }, '<leader>ca', lsp.code_action, genOpts("Show Code Actions"))
		end

    map('n', '<leader>E', vim.diagnostic.open_float, genOpts("Open Diagnositc Float"))
    map('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, genOpts(''))
    map('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, genOpts(''))
  end,
})



-- =============================================================================
-- Mini Clue Setup =============================================================
-- =============================================================================
local miniclue = require('mini.clue')
miniclue.setup({
	window = {
		delay = 250,
		config = {
			width = 'auto',
		},
	},
  triggers = {
    -- Leader triggers
    { mode = { 'n', 'x' }, keys = '<Leader>' },

    -- `[` and `]` keys
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = { 'n', 'x' }, keys = 'g' },

    -- Marks
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },

    -- Registers
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = { 'n', 'x' }, keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
		{ mode = {'n', 'x'}, keys = '<Leader>c', desc = '+Code' },
		{ mode = {'n', 'x'}, keys = '<Leader>f', desc = '+Find' },
		{ mode = {'n', 'x'}, keys = '<Leader>g', desc = '+GoTo' },
  },
})
