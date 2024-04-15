return {
	{
		'neovim/nvim-lspconfig',
		lazy = false,
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/nvim-cmp',
			'l3mon4d3/luasnip',
			'saadparwaiz1/cmp_luasnip',
		},
		config = function()
			local cmp = require('cmp')
			local cmp_lsp = require('cmp_nvim_lsp')
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			require('mason').setup()
			require('mason-lspconfig').setup({
				ensure_installed = {
					'lua_ls',
					'gopls',
				},
				handlers = {
					function(server)
						require('lspconfig')[server].setup({
							capabilities = capabilities
						})
					end,
				},
			})

			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<cr>'] = cmp.mapping.confirm({ select = true }), -- accept current item
					['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
					['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				}, {
					{ name = 'buffer' },
				}),
			})
		end,
	}
}
