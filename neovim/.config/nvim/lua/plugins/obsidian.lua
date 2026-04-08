return {
	{
		"obsidian-nvim/obsidian.nvim",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"ibhagwan/fzf-lua",
			"hrsh7th/nvim-cmp",
		},
		keys = {
			{ "<leader>ww", "<cmd>Obsidian quick_switch<cr>", desc = "Wiki: open page" },
			{ "<leader>wb", "<cmd>Obsidian backlinks<cr>",    desc = "Wiki: backlinks" },
			{ "<leader>wf", "<cmd>Obsidian search<cr>",       desc = "Wiki: search" },
			{ "<leader>wn", "<cmd>Obsidian today<cr>",        desc = "Wiki: today's note" },
			{ "<leader>wt", "<cmd>Obsidian tags<cr>",         desc = "Wiki: tags" },
			{ "<leader>wl", "<cmd>Obsidian link<cr>",         desc = "Wiki: link selection", mode = "v" },
			{ "gf",         "<cmd>Obsidian follow_link<cr>",  desc = "Go to file",           ft = "markdown" },
			{
				"<CR>",
				function() return require("obsidian.util").smart_action() end,
				desc = "Smart action",
				ft = "markdown",
			},
		},
		opts = {
			legacy_commands = false,
			workspaces = {
				{
					name = "wiki",
					path = "~/wiki",
				},
				{
					name = "auto",
					path = function()
						return assert(vim.fs.root(0, ".git") or vim.fn.expand("%:p:h"))
					end,
				},
			},

			frontmatter = {
				enabled = true,
				func = function(note)
					local out = note.metadata or {}

					if not out.title then
						out.title = (note.title or note.id):gsub("-", " "):gsub("(%a)([%w]*)", function(first, rest)
							return first:upper() .. rest
						end)
					end

					-- filter out aliases that match the note ID (filename) to avoid
					-- duplicate slugs in quartz's "shortest" link resolution
					local dominated_aliases = vim.tbl_filter(function(a)
						return a ~= note.id
					end, note.aliases)
					out.aliases = #dominated_aliases > 0 and dominated_aliases or nil
					out.tags = note.tags

					return out
				end,
			},

			note_id_func = function(title)
				if title then
					return title:gsub("[^A-Za-z0-9%s-]", ""):lower():gsub("%s+", " "):match("^(.-)%s*$")
				end
				return tostring(os.time())
			end,

			link = {
				format = "shortest",
			},

			daily_notes = {
				folder = "daily",
				date_format = "%Y-%m-%d",
			},

			ui = { enable = true },

			picker = {
				name = "fzf-lua",
				note_mappings = {
					new = "<C-n>",
					insert_link = "<C-l>",
				},
				tag_mappings = {
					tag_note = "<C-x>",
					insert_tag = "<C-l>",
				},
			},
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},
		},
	}
}
