-- <localleader>ll  -> start/stop continuous compilation
-- <localleader>lv  -> forward search / open PDF viewer
-- <localleader>lk  -> stop compilation
-- <localleader>le  -> open quickfix (errors)
return {
	{
		"lervag/vimtex",
		lazy = false,
		ft = { "tex", "latex" },
		init = function()
			vim.g.vimtex_view_method = "zathura"

			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				build_dir = "", -- "" = same dir as .tex file
				callback = 1,
				continuous = 1,
				executable = "latexmk",
				options = {
					"-pdf",
					"-interaction=nonstopmode",
					"-synctex=1", -- enables forward/inverse search
					"-shell-escape", -- needed for minted, tikzexternalize, etc.
				},
			}

			vim.g.tex_flavor = "latex"

			-- conceal level: 0 = show raw LaTeX, 2 = full concealment
			vim.g.vimtex_syntax_conceal_disable = 0
			vim.opt.conceallevel = 1

			-- vim.g.vimtex_imaps_enabled = 0

			vim.g.vimtex_fold_enabled = 1
			vim.g.vimtex_fold_types = {
				sections = { enabled = 1 },
				envs = { enabled = 1 },
			}

			vim.g.vimtex_quickfix_mode = 2   -- open on error, close on success
			vim.g.vimtex_quickfix_open_on_warning = 0 -- don't open for warnings only
			vim.g.vimtex_quickfix_ignore_filters = {
				"Underfull",
				"Overfull",
				"specifier changed to",
				"Token not allowed",
			}

			vim.g.vimtex_indent_enabled = 1
			vim.g.vimtex_doc_handlers = {} -- disables :VimtexDocPackage (slow)
		end,
	},
}
