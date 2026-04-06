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
					overrides = {
						notes_subdir = "notes",
						new_notes_location = "notes_subdir",
					}
				},
				{
					name = "auto",
					path = function()
						return assert(vim.fs.root(0, ".git") or vim.fn.expand("%:p:h"))
					end,
					overrides = {
						notes_subdir = vim.NIL,
						new_notes_location = "current_dir",
					},
				},
			},

			frontmatter = {
				enabled = true,
				func = function(note)
					local title = note.metadata and note.metadata.title
					if not title then
						-- "digital-garden" → "Digital Garden"
						title = (note.title or note.id):gsub("-", " "):gsub("(%a)([%w]*)", function(first, rest)
							return first:upper() .. rest
						end)
					end

					note:add_alias(title:lower())

					local out = {
						title = title,
						aliases = note.aliases,
						tags = note.tags,
						status = (note.metadata and note.metadata.status) or "seedling",
					}

					if note.metadata then
						for k, v in pairs(note.metadata) do
							if k ~= "title" and k ~= "aliases" and k ~= "tags" then
								out[k] = v
							end
						end
					end

					return out
				end,
			},

			note_id_func = function(title)
				if title then
					return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				end
				return tostring(os.time())
			end,

			link = {
				format = "shortest",
				style = function(opts)
					if opts.label then
						return string.format("[[%s]]", opts.label)
					end
					return string.format("[[%s]]", opts.id)
				end,
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
