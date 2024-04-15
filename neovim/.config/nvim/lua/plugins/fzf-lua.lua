return {
	{
		'ibhagwan/fzf-lua',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			'junegunn/fzf',
			'sharkdp/bat',
		},
		config = function()
			require('fzf-lua').setup({})

			vim.keymap.set('n', '<leader>ff', "<Cmd>lua require('fzf-lua').files()<CR>")
			vim.keymap.set('n', '<leader>fb', "<Cmd>lua require('fzf-lua').buffers()<CR>")
			vim.keymap.set('n', '<leader>fp', "<Cmd>lua require('fzf-lua').grep_project()<CR>")
			vim.keymap.set('n', '<leader>fw', "<Cmd>lua require('fzf-lua').grep_cword()<CR>")
			vim.keymap.set('n', '<leader>fl', "<Cmd>lua require('fzf-lua').lsp_finder()<CR>")
			vim.keymap.set('n', '<leader>fr', "<Cmd>lua require('fzf-lua').resume()<CR>")
		end,
	}
}
