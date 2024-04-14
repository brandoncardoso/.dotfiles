return {
	{
		'williamboman/mason.nvim',
		lazy = false,
		config = function()
			require('mason').setup()
			mason_lspconfig = require('mason-lspconfig')
			mason_lspconfig.setup({
				ensure_installed = {
					'gopls',
				},
			})
			mason_lspconfig.setup_handlers({
				function (server_name)
					require('lspconfig')[server_name].setup({})
				end,
			})
		end,
	}
}
