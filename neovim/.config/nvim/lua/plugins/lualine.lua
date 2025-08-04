return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		},
		config = function()
			require('lualine').setup({
				options = {
					theme = 'pallmere',
					component_separators = { left = '\\', right = '/' },
					section_separators = { left = '', right = '' },
				},
				sections = {
					lualine_c = { 'filename', 'searchcount', 'selectioncount' },
					lualine_x = { 'encoding', 'fileformat', 'lsp_status', 'filetype', 'filesize' },
				}
			})
		end,
	}
}
