return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		init = function()
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

			vim.defer_fn(function() require("nvim-treesitter").install(ensure_installed) end, 1000)
			require("nvim-treesitter").update()

			-- auto-start highlights & indentation
			vim.api.nvim_create_autocmd("FileType", {
				desc = "User: enable treesitter highlighting",
				callback = function(ctx)
					-- highlights
					local hasStarted = pcall(vim.treesitter.start) -- errors for filetypes with no parser

					-- indent
					local noIndent = {}
					if hasStarted and not vim.list_contains(noIndent, ctx.match) then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end
	}
}
