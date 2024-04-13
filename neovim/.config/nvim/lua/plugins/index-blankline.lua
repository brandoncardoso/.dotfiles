return {
	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		opts = {},
		config = function()
			require('ibl').setup({
				whitespace = {
					remove_blankline_trail = true,
				},
				scope = {
					show_start = false,
					show_end = false,
				}
			})
		end,
	}
}
