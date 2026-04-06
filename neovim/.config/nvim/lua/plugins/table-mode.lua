return {
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown", "md" },
		cmd = { "TableModeToggle", "TableModeEnable", "Tableize" },
		keys = {
			{ "<leader>tm", "<cmd>TableModeToggle<cr>",  desc = "Toggle Table Mode" },
			{ "<leader>tr", "<cmd>TableModeRealign<cr>", desc = "Realign Table" },
			{ "<leader>tt", "<cmd>Tableize<cr>",         mode = "v",                desc = "Tableize selection" },
		},
		init = function()
			-- Use | for corners to produce markdown-compatible separator rows
			-- e.g. |---|---|---| instead of +---+---+---+
			vim.g.table_mode_corner = "|"

			-- Use - as the horizontal fill character (default, but explicit for clarity)
			vim.g.table_mode_header_fillchar = "-"

			-- Character used between columns in separator rows
			vim.g.table_mode_separator = "|"
		end,
	},
}
