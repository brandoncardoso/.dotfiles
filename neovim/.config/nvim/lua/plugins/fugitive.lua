return {
	{
		'tpope/vim-fugitive',
		config = function()
			 vim.keymap.set('n', '<leader>gs', ':0Git<cr>')
		end,
	}
}
