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
			'hoffs/omnisharp-extended-lsp.nvim',
		},
		config = function()
			local cmp = require('cmp')
			local cmp_lsp = require('cmp_nvim_lsp')
			local luasnip = require('luasnip')
			local lspconfig = require('lspconfig')

			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			require('mason').setup()

			require('lspconfig').gdscript.setup({})

			require('mason-lspconfig').setup({
				ensure_installed = {
					'lua_ls',
					'ts_ls', -- typescript
					'gopls',
					'rust_analyzer',
					'omnisharp',
				},
				handlers = {
					function(server)
						require('lspconfig')[server].setup({
							capabilities = capabilities
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
					["omnisharp"] = function()
						require("lspconfig").omnisharp.setup({
							handlers = {
								["textDocument/definition"] = require("omnisharp_extended").handler,
							},
							-- cmd = { "dotnet", "/path/to/omnisharp/OmniSharp.dll" },

							-- Enables support for reading code style, naming convention and analyzer
							-- settings from .editorconfig.
							enable_editorconfig_support = true,

							-- If true, MSBuild project system will only load projects for files that
							-- were opened in the editor. This setting is useful for big C# codebases
							-- and allows for faster initialization of code navigation features only
							-- for projects that are relevant to code that is being edited. With this
							-- setting enabled OmniSharp may load fewer projects and may thus display
							-- incomplete reference lists for symbols.
							enable_ms_build_load_projects_on_demand = false, -- default false

							-- Enables support for roslyn analyzers, code fixes and rulesets.
							enable_roslyn_analyzers = true, -- default false

							-- Specifies whether 'using' directives should be grouped and sorted during
							-- document formatting.
							organize_imports_on_format = true, -- default false

							-- Enables support for showing unimported types and unimported extension
							-- methods in completion lists. When committed, the appropriate using
							-- directive will be added at the top of the current file. This option can
							-- have a negative impact on initial completion responsiveness,
							-- particularly for the first few completion sessions after opening a
							-- solution.
							enable_import_completion = true, -- default false

							-- Specifies whether to include preview versions of the .NET SDK when
							-- determining which version to use for project loading.
							sdk_include_prereleases = true,

							-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
							-- true
							analyze_open_documents_only = true, -- default false
						})
					end,
				}
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
	}
}
