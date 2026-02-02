-- NOTE: Requires tree-sitter-cli installed
-- https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md

return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			local ensure_installed = {
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
				"query",
				"markdown_inline",
				"markdown",
			}

			local treesitter = require("nvim-treesitter")
			treesitter.setup()
			treesitter.install(ensure_installed)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					-- syntax highlighting, provided by neovim
					local ok = pcall(vim.treesitter.start)
					if not ok then
						return -- failed to start treesitter
					end

					-- folds, provided by neovim
					vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
					vim.wo[0][0].foldmethod = 'expr'

					-- indentation, provided by nvim-treesitter
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end
	}
}
