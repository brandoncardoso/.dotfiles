return {
	{
		'nvim-focus/focus.nvim',
		version = '*',
		lazy = false,
		config = function()
			require("focus").setup({})

			local focusmap = function(direction)
				vim.keymap.set('n', '<Leader>'..direction, function()
					require('focus').split_command(direction)
				end, {
					desc = string.format('Create or move to split (%s)', direction),
					noremap = true,
				})
			end

			focusmap('h')
			focusmap('j')
			focusmap('k')
			focusmap('l')
		end,
	}
}
