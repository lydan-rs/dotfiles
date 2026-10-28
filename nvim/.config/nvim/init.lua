vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
	'https://github.com/Shatur/neovim-ayu',
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
	{
		src = 'https://github.com/saghen/blink.compat',
		version = vim.version.range('2.x'),
	},
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/lervag/vimtex',
	'https://github.com/micangl/cmp-vimtex',
	'https://github.com/stevearc/conform.nvim',
})

-- =============================================================================
-- Treesitter ==================================================================
-- =============================================================================

require('nvim-treesitter').install({
	'lua',
	'markdown',
	'c',
	'cpp',
	'cmake',
	'python',
})

require('aucmds').on_filetype(
	'Start treesitter for installed parsers.',
  {
		'lua',
		'markdown',
		'c',
		'cpp',
		'cmake',
		'python',
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

require('mason').setup()

local mason_tools = {
	-- LSPs
	'lua-language-server', -- lua_ls
	'clangd',
	'basedpyright',
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

if #unrecognised_mason_packages > 0 then
 local msg = 'Some Mason tools were not recognised, and therefore not installed.'
 for _, tool in ipairs(unrecognised_mason_packages) do
 	msg = msg..'\n\t'..tool
 end
	vim.notify(msg, vim.log.levels.WARN)
end
