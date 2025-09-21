-- Scratch Buffer Plugin
-- A Neovim plugin for project-specific scratch buffers

local M = {}

-- Configuration
local config = {
  data_dir = vim.fn.stdpath('data') .. '/scratch',
  file_extension = '.md',
  default_mode = 'float', -- 'float', 'split', 'fullscreen'
}

-- Internal state
local scratch_buffers = {}
local scratch_windows = {}

-- Utility functions
local function get_project_name()
  local cwd = vim.fn.getcwd()
  local project_name = vim.fn.fnamemodify(cwd, ':t')

  -- If we're in a git repository, try to get a more meaningful name
  local git_root = vim.fn.system('git rev-parse --show-toplevel 2>/dev/null'):gsub('\n', '')
  if vim.v.shell_error == 0 then
    project_name = vim.fn.fnamemodify(git_root, ':t')
  end

  return project_name
end

local function get_unique_id()
  local cwd = vim.fn.getcwd()
  -- Create a simple hash of the current working directory
  local hash = vim.fn.sha256(cwd):sub(1, 8)
  return hash
end

local function get_scratch_file_path()
  local project_name = get_project_name()
  local unique_id = get_unique_id()
  local filename = string.format('%s_%s%s', project_name, unique_id, config.file_extension)

  -- Ensure the directory exists
  local dir = config.data_dir
  vim.fn.mkdir(dir, 'p')

  return dir .. '/' .. filename
end

local function get_scratch_buffer()
  local file_path = get_scratch_file_path()
  local project_key = get_project_name() .. '_' .. get_unique_id()

  -- Return existing buffer if it exists
  if scratch_buffers[project_key] and vim.api.nvim_buf_is_valid(scratch_buffers[project_key]) then
    return scratch_buffers[project_key], file_path
  end

  -- Create new buffer
  local buf = vim.api.nvim_create_buf(false, false)
  scratch_buffers[project_key] = buf

  -- Set buffer options
  vim.api.nvim_buf_set_name(buf, file_path)
  vim.api.nvim_set_option_value('buftype', '', { buf = buf })
  vim.api.nvim_set_option_value('filetype', 'markdown', { buf = buf })
  vim.api.nvim_set_option_value('swapfile', false, { buf = buf })

  -- Load existing content if file exists
  if vim.fn.filereadable(file_path) == 1 then
    local lines = vim.fn.readfile(file_path)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value('modified', false, { buf = buf })
  else
    -- Set initial content for new scratch files
    local initial_content = {
      '# Scratch Buffer - ' .. get_project_name() .. ' at ' .. vim.fn.getcwd(),
      '',
      '',
    }
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, initial_content)
    vim.api.nvim_set_option_value('modified', false, { buf = buf })
  end

  -- Set up auto-save
  vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
    buffer = buf,
    callback = function()
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_get_option_value('modified', { buf = buf }) then
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          vim.fn.writefile(lines, file_path)
          vim.api.nvim_set_option_value('modified', false, { buf = buf })
        end
      end)
    end,
  })

  return buf, file_path
end

-- Display mode functions
local function open_float(buf)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = ' Scratch Buffer - ' .. get_project_name() .. ' ',
    title_pos = 'center',
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  -- Set window-specific options
  vim.api.nvim_set_option_value('wrap', true, { win = win })
  vim.api.nvim_set_option_value('linebreak', true, { win = win })

  return win
end

local function open_split(buf)
  -- Open a vertical split on the right
  vim.cmd('rightbelow vsplit')
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)

  -- Set window width to 40% of screen
  local width = math.floor(vim.o.columns * 0.4)
  vim.api.nvim_win_set_width(win, width)

  return win
end

local function open_fullscreen(buf)
  -- Open in current window
  vim.api.nvim_win_set_buf(0, buf)
  return vim.api.nvim_get_current_win()
end

-- Main functions
function M.open(mode)
  mode = mode or config.default_mode

  local buf, file_path = get_scratch_buffer()
  local project_key = get_project_name() .. '_' .. get_unique_id()

  -- Close existing window if it exists
  if scratch_windows[project_key] and vim.api.nvim_win_is_valid(scratch_windows[project_key]) then
    vim.api.nvim_win_close(scratch_windows[project_key], false)
  end

  local win
  if mode == 'float' then
    win = open_float(buf)
  elseif mode == 'split' then
    win = open_split(buf)
  elseif mode == 'fullscreen' then
    win = open_fullscreen(buf)
  else
    vim.notify('Invalid mode: ' .. mode .. '. Using float mode.', vim.log.levels.WARN)
    win = open_float(buf)
  end

  scratch_windows[project_key] = win

  -- Set up window-specific keymaps
  local opts = { buffer = buf, noremap = true, silent = true }
  vim.keymap.set('n', 'q', function()
    if mode == 'float' and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, false)
    end
  end, opts)

  vim.keymap.set('n', '<Esc>', function()
    if mode == 'float' and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, false)
    end
  end, opts)

  return buf, win
end

function M.toggle(mode)
  mode = mode or config.default_mode
  local project_key = get_project_name() .. '_' .. get_unique_id()

  -- If window exists and is valid, close it
  if scratch_windows[project_key] and vim.api.nvim_win_is_valid(scratch_windows[project_key]) then
    vim.api.nvim_win_close(scratch_windows[project_key], false)
    scratch_windows[project_key] = nil
    return
  end

  -- Otherwise, open it
  M.open(mode)
end

function M.open_float()
  return M.open('float')
end

function M.open_split()
  return M.open('split')
end

function M.open_fullscreen()
  return M.open('fullscreen')
end

function M.toggle_float()
  return M.toggle('float')
end

function M.toggle_split()
  return M.toggle('split')
end

function M.toggle_fullscreen()
  return M.toggle('fullscreen')
end

function M.save()
  local project_key = get_project_name() .. '_' .. get_unique_id()
  local buf = scratch_buffers[project_key]

  if buf and vim.api.nvim_buf_is_valid(buf) then
    local file_path = get_scratch_file_path()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    vim.fn.writefile(lines, file_path)
    vim.api.nvim_set_option_value('modified', false, { buf = buf })
    vim.notify('Scratch buffer saved to: ' .. file_path, vim.log.levels.INFO)
  else
    vim.notify('No scratch buffer found for current project', vim.log.levels.WARN)
  end
end

function M.setup(opts)
  config = vim.tbl_deep_extend('force', config, opts or {})

  vim.keymap.set("n", "<leader>x", M.toggle_float, { desc = "Toggle scratch buffer (float)" })
  vim.keymap.set("n", "<leader>xs", M.toggle_split, { desc = "Toggle scratch buffer (split)" })
  vim.keymap.set("n", "<leader>xf", M.toggle_fullscreen, { desc = "Toggle scratch buffer (fullscreen)" })
  vim.keymap.set("n", "<leader>xw", M.save, { desc = "Save scratch buffer" })

  -- Ensure directories exist
  vim.fn.mkdir(config.data_dir, 'p')
end

return M
