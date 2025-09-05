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

-- paths to check for project.godot file
local paths_to_check = { '/', '/../' }
local is_godot_project = false
local godot_project_path = ''
local cwd = vim.fn.getcwd()

-- iterate over paths and check
for key, value in pairs(paths_to_check) do
	if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
		is_godot_project = true
		godot_project_path = cwd .. value
		break
	end
end

-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(godot_project_path .. '/godot.pipe')
-- start server, if not already running
if is_godot_project and not is_server_running then
	vim.fn.serverstart(godot_project_path .. '/godot.pipe')
end
