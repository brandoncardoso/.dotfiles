require('settings')
require('remap')
require('lazy-init')
require('lsp')

-- resize splits on window resize
vim.api.nvim_create_autocmd('VimResized', {
	pattern = '*',
	group = on_vim_resized,
	callback = function()
		vim.cmd.wincmd '='
	end,
})

vim.cmd [[
if has("persistent_undo")
let target_path = expand('~/.config/nvim/undo')

" create the directory and any parent directories
" if the location does not exist.

if !isdirectory(target_path)
call mkdir(target_path, "p", 0700)
endif

let &undodir=target_path
set undofile
endif
]]
