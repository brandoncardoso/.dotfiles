local nvim_lsp = require('lspconfig')

-- after language server has attached to buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- enable completion
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'


		-- keybinds
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<leader>fm', function()
			vim.lsp.buf.format { async = true }
		end, opts)


		-- format on save
		vim.api.nvim_create_autocmd('BufWritePre', {
			buffer = ev.buf,
			callback = function()
				vim.lsp.buf.format({
					id = ev.data.client_id,
					async = false,
				})
			end,
		})
	end,
})
