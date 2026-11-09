vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.use_blink_cmp = false

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
	{
		src = 'https://github.com/L3MON4D3/LuaSnip',
		version = vim.version.range('v2.*'),
	},
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/lervag/vimtex',
	'https://github.com/stevearc/conform.nvim',
})


