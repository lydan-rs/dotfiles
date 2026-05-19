-- =============================================================================
-- Keymaps =====================================================================
-- =============================================================================

-- ======== Navigation =========================================================
vim.keymap.set({'n', 'x'}, '<C-d>', '<C-d>zz')
vim.keymap.set({'n', 'x'}, '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')

-- ======== Search =============================================================
vim.keymap.set('n', '<Leader>o', MiniFiles.open, {desc = 'Open file explorer'})

vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')
vim.keymap.set({'n', 'x'}, 'n', 'nzz')
vim.keymap.set({'n', 'x'}, 'N', 'Nzz')

local fzf_lua = require('fzf-lua')
vim.keymap.set("n", "<leader>ff", fzf_lua.files, { desc = "find files" })
vim.keymap.set("n", "<leader>fg", fzf_lua.live_grep, { desc = "live grep" })
vim.keymap.set("n", "<leader>fb", fzf_lua.buffers, { desc = "find buffers" })
vim.keymap.set("n", "<leader>fh", fzf_lua.help_tags, { desc = "help tags" })
vim.keymap.set("n", "<leader>fo", fzf_lua.oldfiles, { desc = "recent files" })
vim.keymap.set("n", "<leader>fr", fzf_lua.lsp_references, { desc = "lsp references" })
vim.keymap.set("n", "<leader>fr", fzf_lua.resume, { desc = "resume search" })
vim.keymap.set("n", "<leader>fd", fzf_lua.lsp_definitions, { desc = "lsp definitions" })
vim.keymap.set("n", "<leader>fs", fzf_lua.lsp_document_symbols, { desc = "lsp document symbols" })
vim.keymap.set("n", "<leader>fo", fzf_lua.builtin, { desc = "fzf-lua search options" })


-- ======== LSP ================================================================
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LSPKeybinds', { clear = true }),
  callback = function(event)
    local genOpts = function(description)
      return { desc = description, buffer = event.buf, silent = true }
    end

    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, genOpts("Goto Definition"))
    vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, genOpts("Goto Declaration"))
    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, genOpts("Goto Implementation"))
    vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, genOpts("Goto References"))
    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, genOpts("Goto Type Definition"))

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, genOpts(""))
    vim.keymap.set('n', '<leader>ch', vim.lsp.buf.hover, genOpts("Hover (Also 'K')"))
    vim.keymap.set('n', '<leader>cH', vim.lsp.buf.signature_help, genOpts("Show Signature Help"))
    -- vim.keymap.set('n', '<C-K>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, genOpts("Rename Symbol"))
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, genOpts("Show Code Actions"))

    vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, genOpts("Open Diagnositc Float"))
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, genOpts(''))
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, genOpts(''))
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
  },
})
