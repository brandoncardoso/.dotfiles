vim.opt.termguicolors = true
vim.g.syntax = 'enable'
-- only syntax highlight first X characters in a line
vim.opt.synmaxcol = 300

vim.opt.number = true
vim.opt.cursorline = true
-- always show signcolumn to avoid jitter
vim.opt.signcolumn = 'yes'

-- always show status line
vim.opt.laststatus = 2

-- display incomplete commands
vim.opt.showcmd = true
vim.opt.cmdheight = 1

-- let same file scroll differently in seperate panes
vim.opt.scrollbind = false

-- disable visual bell
vim.opt.errorbells = false
vim.opt.visualbell = false

-- set lines in view at edges of screen
vim.opt.scrolloff = 999 -- current line centered
vim.opt.sidescrolloff = 10
vim.opt.sidescroll = 1

vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftround = true -- round up indents

vim.opt.completeopt = 'longest,menuone,noinsert,noselect'

-- show special characters
vim.opt.list = true    
vim.opt.listchars:append({
	trail = '◼',
	tab = '┃ ',
	leadmultispace = '┃ ',
	extends = '❯',
	precedes = '❮',
	nbsp = '␣',
	-- eol = '↵',
})
-- maintain indent level on line wrap
vim.opt.breakindent = true
vim.opt.showbreak = '↪ '

-- match all search results in a line by default (/g at end to undo)
vim.opt.gdefault = true
-- search term case insensitive unless using some uppercase
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- don't continue comments when using o/O
vim.opt.formatoptions['o'] = false

-- reasonable tab completion
vim.opt.wildmode = 'full'
