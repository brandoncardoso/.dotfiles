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
			'nvim-highlight-colors',
		},
		config = function()
			local cmp = require('cmp')
			local cmp_lsp = require('cmp_nvim_lsp')
			local luasnip = require('luasnip')

			-- defaults for all language servers
			vim.lsp.config('*', {
				capabilities = vim.tbl_deep_extend(
					"force",
					vim.lsp.protocol.make_client_capabilities(),
					cmp_lsp.default_capabilities()
				),
			})

			vim.lsp.config('gopls', {
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

			vim.lsp.config('rust_analyzer', {
				settings = {
					["rust-analyzer"] = {
						cargo = { features = "all" },
					},
				},
			})

			vim.lsp.config('roslyn_ls', {
				filetypes = { 'cs' },
				root_markers = { '*.sln', '*.csproj', '.git' },
				settings = {
					['csharp|inlay_hints'] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
					},
					['csharp|code_lens'] = {
						dotnet_enable_references_code_lens = true,
					},
				},
			})

			require('mason').setup()
			require('mason-lspconfig').setup({
				ensure_installed = {
					'lua_ls',
					'ts_ls', -- typescript
					'gopls',
					'rust_analyzer',
					'roslyn_ls', -- c# csharp
				},
				automatic_enable = {
					exclude = { 'omnisharp' },
				},
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
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({ select = true })
							end
						else
							fallback()
						end
					end),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item(cmp_select)
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item(cmp_select)
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
