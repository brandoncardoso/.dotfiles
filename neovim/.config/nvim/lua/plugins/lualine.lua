return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		},
		config = function()
			require('lualine').setup({
				options = {
					theme = 'ayu_light',
				},
				sections = {
					lualine_c = { 'filename', 'searchcount', 'selectioncount' },
					lualine_x = { 'encoding', 'fileformat', 'filetype', 'filesize' },
				}
			})
		end,
	}
}
