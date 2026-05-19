-- =============================================================================
-- Plugin Hooks ================================================================
-- =============================================================================

require('aucmds').on_pack(
	'LuaSnip install jsregexp on install/update.',
	'LuaSnip',
	{'install', 'update'},
	function (ctx)
		-- if not ctx.data.active then vim.cmd.packadd('LuaSnip') end -- Is this necessary?
		vim.notify('Installing jsregexp for LuaSnip.')
		-- local path = vim.pack.get({'LuaSnip'})[1].path
		vim.system({'make', 'install_jsregexp'}, {cwd = ctx.data.path}, function(result)
			if result.code == 0 then
				vim.notify('jsregexp installed successfully!!')
			else
				vim.notify('jsregexp install failed: ' .. (result.stderr or "unknown error."), vim.log.levels.ERROR)
			end
		end)
	end
)

require('aucmds').on_pack(
	'TSUpdate on nvim-treesitter update.',
	'nvim-treesitter',
	{'update'},
	function (ctx)
    if not ctx.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
	end
)


-- =============================================================================
-- Plugins =====================================================================
-- =============================================================================

vim.pack.add({
	'https://github.com/nvim-mini/mini.nvim',
	'https://github.com/ibhagwan/fzf-lua',
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/folke/lazydev.nvim',
	'https://github.com/rafamadriz/friendly-snippets',
	{
		src = 'https://github.com/L3MON4D3/LuaSnip',
		version = vim.version.range('v2.*'),
	},
	{
		src = 'https://github.com/saghen/blink.cmp',
		version = vim.version.range('1.x'),
	},
	'https://github.com/nvim-treesitter/nvim-treesitter',
})

-- =============================================================================
-- Treesitter ==================================================================
-- =============================================================================

require('nvim-treesitter').install({
	'lua',
	'markdown',
	'latex',
})

require('aucmds').on_filetype(
	'Start treesitter for installed parsers.',
  {
		'lua',
		'markdown',
		'tex',
	},
	function ()
		vim.treesitter.start()
		-- TODO: Seperate this once we install a parser for which we don't have fold queries
		vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.wo[0][0].foldmethod = 'expr'
	end
)

-- =============================================================================
-- Mason =======================================================================
-- =============================================================================

local mason_tools = {
	-- LSPs
	'lua-language-server', -- lua_ls
	'texlab', -- texlab 
	'gobaldygook',
	'notanlsp',
	'somerandomtool',
}

local unrecognised_mason_packages = {}

for _, tool in ipairs(mason_tools) do
	if not require('mason-registry').is_installed(tool) then
		if not require('mason-registry').has_package(tool) then
			-- unrecognised_mason_packages:append(tool)
			table.insert(unrecognised_mason_packages, tool)
		else
			-- require('mason-registry').install(tool)
			vim.cmd({ cmd = 'MasonInstall', args = {tool} })
		end
	end
end

if #unrecognised_mason_packages then
 local msg = 'Some Mason tools were not recognised, and therefore not installed.'
 for _, tool in ipairs(unrecognised_mason_packages) do
 	msg = msg..'\n\t'..tool
 end
	vim.notify(msg, vim.log.levels.WARN)
end


-- =============================================================================
-- Overview ====================================================================
-- =============================================================================
--[[
	== To Add ==
	Completion and Snippets
	Improved command line
	Vim api completion
	Language support for lua, markdown, latex, c, go, python, md, html, css, javascript
	Diagnostics
	Proper documentation
	Context

	== To Understand Better ==
	Search, grep and regex
	Textobjects and operators
	Quickfix list
	mini.files
	lua
	FileType autocommand events


	== Dependencies ==
	ripgrep
	fzf
	treesitter-cli
	bat
	add `fd` for better find
--]]

-- vim.o for normal options
-- vim.opt like vim.o, but uses lua tables as args, instead of strings
-- vim.go for global options
-- vim.g vs vim.go
-- vim.bo for buffer scoped options
-- vim.wo for window scoped options
--
-- == Features ==
-- Auto open help on left (or floating if possible)

--[[
backup
writebackup
undofile
undodir

virtualedit
infercase
splitkeep
shortmess
ruler
fillchars
breakindent

confirm
showmode
timeoutlen
updatetime
diagnostic
swapfile
vim.opt.ttimeoutlen = 0 -- key code timeout
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory
--]]


