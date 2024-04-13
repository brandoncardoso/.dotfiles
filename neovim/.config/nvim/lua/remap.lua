vim.keymap.set('n', '<Space>', '<NOP>', { silent = true })
vim.g.mapleader = ' '

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
