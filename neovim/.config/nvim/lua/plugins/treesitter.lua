return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			local treesitter = require('nvim-treesitter')

			treesitter.install {
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
			}

			vim.api.nvim_create_autocmd('FileType', {
				pattern = { '<filetype>' },
				callback = function()
					-- enable syntax highlighting
					vim.treesitter.start()
					--
					-- enable folding
					vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
					vim.wo[0][0].foldmethod = 'expr'
				end,
			})
		end,
	}
}
