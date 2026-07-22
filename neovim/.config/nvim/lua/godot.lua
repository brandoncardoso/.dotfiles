local M = {}

local PIPE_NAME = 'server.pipe'

-- find the project root by (dir with 'project.godot')
local function find_root(start)
	local found = vim.fs.find('project.godot', {
		upward = true,
		path = start,
		stop = vim.uv.os_homedir(),
		type = 'file',
	})[1]
	return found and vim.fs.dirname(found) or nil
end

local function search_origin()
	local buf_dir = vim.fn.expand '%:p:h'
	if buf_dir ~= '' and vim.uv.fs_stat(buf_dir) then
		return buf_dir
	end
	return vim.fn.getcwd()
end

local function is_pipe_alive(pipe)
	if not vim.uv.fs_stat(pipe) then
		return false
	end
	local ok, chan = pcall(vim.fn.sockconnect, 'pipe', pipe)
	if ok and chan ~= 0 then
		pcall(vim.fn.chanclose, chan)
		return true
	end
	return false
end

function M.open(file, line, col)
	local bufnr = vim.fn.bufnr(file)
	local win = bufnr ~= -1 and vim.fn.bufwinid(bufnr) or -1

	if win ~= -1 then
		vim.api.nvim_set_current_win(win)
	else
		vim.cmd('vsplit ' .. vim.fn.fnameescape(file))
	end

	local row = math.max((tonumber(line) or 0) + 1, 1)
	local total = vim.api.nvim_buf_line_count(0)
	vim.api.nvim_win_set_cursor(0, { math.min(row, total), tonumber(col) or 0 })
end

function M.setup()
	_G.godot_open = M.open

	local root = find_root(search_origin())
	if not root then
		return nil
	end

	local pipe = vim.fs.joinpath(root, PIPE_NAME)

	if is_pipe_alive(pipe) then
		return nil
	end

	-- remove stale socket left by a crashed session
	if vim.uv.fs_stat(pipe) then
		vim.uv.fs_unlink(pipe)
	end

	vim.fn.serverstart(pipe)
	return pipe
end

return M
