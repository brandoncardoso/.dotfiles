return {
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup({
				numhl = true,
				auto_attach = true,
				on_attach = function(bufnr)
					local gitsigns = require('gitsigns')

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = buffer
						vim.keymap.set(mode, l, r, opts)
					end

					map('n', 'g]', function()
						if vim.wo.diff then
							vim.cmd.normal({'g]', bang = true})
						else
							gitsigns.nav_hunk('next')
						end
					end)

					map('n', 'g[', function()
						if vim.wo.diff then
							vim.cmd.normal({'g[', bang = true})
						else
							gitsigns.nav_hunk('prev')
						end
					end)
				end,
			})

			vim.opt.signcolumn = 'yes'
		end,
	}
}
