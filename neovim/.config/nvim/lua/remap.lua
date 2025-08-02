vim.keymap.set('n', '<Space>', '<NOP>', { silent = true })
vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>rr', function()
	dofile(vim.fn.stdpath('config') .. '/init.lua')
end, { desc = 'Reload init.lua' })

-- leave insert mode quickly
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('i', 'jk', '<ESC>')

-- undo in insert mode
vim.keymap.set('i', '<C-U>', '<C-G>u<C-U>')

-- clear search higlights
vim.keymap.set('n', '<leader>n', ':nohlsearch<cr>', { noremap = true })

-- close file in buffer without losing split
vim.keymap.set('n', '<leader>d', ':bp|sp|bn|bd<cr>', { silent = true })

-- find & replace for word under cursor
vim.keymap.set('n', '<leader>c', ':%s/\\<<C-R><C-W>\\>/<C-R><C-W>/g<Left><Left>')


vim.keymap.set('n', '<leader>sg', function()
	local win = vim.api.nvim_get_current_win()
	local row, col = unpack(vim.api.nvim_win_get_cursor(win))

	-- 1. Extmarks (e.g., LSP, nvim-tree)
	local ns_ids = vim.api.nvim_get_namespaces()
	for name, ns in pairs(ns_ids) do
		local marks = vim.api.nvim_buf_get_extmarks(0, ns, { row - 1, col }, { row - 1, col + 1 }, { details = true })
		for _, mark in ipairs(marks) do
			if mark[4] and mark[4].hl_group then
				print('Highlight group to target: "' ..
					mark[4].hl_group .. '" (source: extmark, namespace: ' .. name .. ')')
				return
			end
		end
	end

	-- 2. Treesitter node type
	local has_ts, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
	if has_ts and ts_utils.get_node_at_cursor then
		local node = ts_utils.get_node_at_cursor()
		if node then
			local node_type = node:type()
			local lang = vim.treesitter.language.get_lang(vim.bo.filetype) or "unknown"
			print('Treesitter node type: "' .. node_type .. '" (lang: ' .. lang .. ')')
			print('→ To highlight, map it in queries/' ..
				lang .. '/highlights.scm and theme it via e.g. ["@' .. node_type .. '"]')
			return
		end
	end

	-- 3. Legacy syntax group
	local s = vim.fn.synID(vim.fn.line('.'), vim.fn.col('.'), 1)
	local group = vim.fn.synIDattr(s, 'name')
	local trans = vim.fn.synIDattr(vim.fn.synIDtrans(s), 'name')
	if group ~= "" or trans ~= "" then
		print('Legacy syntax group: "' .. group .. '" → "' .. trans .. '"')
		print('→ To highlight, target "' .. trans .. '" in your theme')
	else
		print('No highlight group found at cursor')
	end
end, { desc = 'Show highlight group under cursor' })
