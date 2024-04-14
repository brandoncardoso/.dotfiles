return {
	{
		'nvim-tree/nvim-tree.lua',
		version = '*',
		lazy = false,
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require('nvim-tree').setup({
				disable_netrw = true,
				update_cwd = false,
				respect_buf_cwd = false,
				filters = {
					custom = {
						'node_modules',
						'.git/',
					},
				},
				update_focused_file = {
					enable = true,
					update_cwd = false,
				},
				renderer = {
					add_trailing = true,
					highlight_opened_files = 'all',
				},
				view = {
					adaptive_size = true,
				},
			})

			vim.api.nvim_set_keymap('n', '<C-f>', ':NvimTreeToggle<cr>', { noremap = true })
			vim.api.nvim_set_keymap('n', '<C-r>', ':NvimTreeRefresh<cr>', { noremap = true })
		end,
	}
}
