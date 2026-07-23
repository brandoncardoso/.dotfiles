return {
	{
		'neovim/nvim-lspconfig',
		lazy = false,
		dependencies = {
			'mason-org/mason.nvim',
			'mason-org/mason-lspconfig.nvim',
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
			local luasnip = require('luasnip')
			local lspconfig = vim.lsp.config('*', {
				capabilities = vim.tbl_deep_extend(
					"force",
					{},
					vim.lsp.protocol.make_client_capabilities(),
					cmp_lsp.default_capabilities()
				)
			})

			require('mason').setup()
			require('mason-lspconfig').setup({
				ensure_installed = {
					'lua_ls',
					'ts_ls', -- typescript
					'gopls',
					'rust_analyzer',
				},
				handlers = {
					function(server)
						require('lspconfig')[server].setup({
							capabilities = capabilities
						})
					end,
					["gopls"] = function()
						lspconfig.gopls.setup({
							settings = {
								gopls = {
									analyses = {
										unusedparams = true,
										unusedwrite = true,
										nilness = true,
										shadow = true,
									},
									staticcheck = true,
								},
							},
						})
					end,
					["rust_analyzer"] = function()
						lspconfig.rust_analyzer.setup({
							settings = {
								["rust-analyzer"] = {
									cargo = {
										features = "all",
									}
								}
							}
						})
					end,
				}
			})

			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				formatting = {
					format = function(entry, item)
						return require("nvim-highlight-colors").format(entry, item)
					end,
				},
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
					diagnostics = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({
									select = true,
								})
							end
						else
							fallback()
						end
					end),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				}, {
					{ name = 'buffer' },
				}),
			})
		end,
	},
}
