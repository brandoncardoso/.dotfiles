return {
	{
		'numtostr/comment.nvim',
		lazy = false,
		opts = {
		},
		config = function()
			require('Comment').setup({
				toggler = {
					line = 'gcc', -- toggle comment for line
					block = 'gbc', -- toggle comment for block
				},
				extra = {
					eol = 'gcA', -- add comment to end of line
				}
			})
		end,
	}
}
