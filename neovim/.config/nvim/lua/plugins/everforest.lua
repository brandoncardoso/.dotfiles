return {
	{
		"sainnhe/everforest",
		lazy = false, -- load at startup
		priority = 1000, -- ensure it runs before other UI plugins
		config = function()
			vim.opt.termguicolors = true

			vim.g.everforest_background = "hard" -- 'hard' | 'medium' | 'soft'
			vim.g.everforest_transparent_background = 0 -- 0 | 1 | 2
			vim.g.everforest_ui_contrast = "high" -- 'low' | 'high'
			vim.g.everforest_enable_italic = 0
			vim.g.everforest_disable_italic_comment = 0
			vim.g.everforest_sign_column_background = "none" -- 'none' | 'grey'
			vim.g.everforest_diagnostic_text_highlight = 0
			vim.g.everforest_diagnostic_line_highlight = 0
			vim.g.everforest_diagnostic_virtual_text = "coloured" -- 'grey' | 'coloured'
			vim.g.everforest_dim_inactive_windows = 0

			vim.o.background = "dark"
			vim.cmd.colorscheme("everforest")
		end,
	},
}
