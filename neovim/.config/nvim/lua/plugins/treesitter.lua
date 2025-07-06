return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			local configs = require('nvim-treesitter.configs')

			configs.setup({
				ensure_installed = {
					'javascript',
					'typescript',
					'go',
					'java',
					'html',
					'css',
					'vim',
					'vimdoc',
					'lua',
					'rust',
					'toml',
					'yaml',
					'json',
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	}
}
