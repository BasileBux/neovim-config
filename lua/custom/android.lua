-- Android
-- To get this setup working, you need to have aliases or scripts for all the commands
-- defined in the `config` table below.

local M = {}

-- Configuration
local config = {
  emulator_command = "emu",
  build_command = "build .",
  install_command = "apkinstall",
  reload_command = "reload",

  filetypes = { "kotlin", "java", "xml", "gradle" },
}

local function run_async_command(cmd, on_success, on_failure)
  vim.fn.jobstart(cmd, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify(cmd .. on_success, vim.log.levels.INFO, { title = cmd })
      else
        vim.notify(cmd .. on_failure, vim.log.levels.ERROR, { title = cmd })
      end
    end,
  })
end

local function has_filetype()
  local ft = vim.bo.filetype
  for _, filetype in ipairs(config.filetypes) do
    if ft == filetype then
      return true
    end
  end
  return false
end

-- Modify this to only work in kotlin/java files
function M.start_emulator()
  run_async_command(config.emulator_command, "Emulator: Started", "Emulator: Failed to start")
end

function M.build()
  if has_filetype() == false then
    vim.notify("Need to be in kotlin/java to build with this command", vim.log.levels.WARN, { title = "Emulator" })
    return
  end
  vim.notify("Building...", vim.log.levels.INFO, { title = "Build" })
  run_async_command(config.build_command, "Build: Success", "Build: Failed")
end

function M.install()
  if has_filetype() == false then
    vim.notify("Need to be in kotlin to install with this command", vim.log.levels.WARN, { title = "Emulator" })
    return
  end
  vim.notify("Installing...", vim.log.levels.INFO, { title = "Install" })
  run_async_command(config.install_command, "Install: Success", "Install: Failed")
end

function M.reload()
  if has_filetype() == false then
    vim.notify("Need to be in kotlin to reload with this command", vim.log.levels.WARN, { title = "Emulator" })
    return
  end
  vim.notify("Reloading...", vim.log.levels.INFO, { title = "Reload" })
  run_async_command(config.reload_command, "Reload: Success", "Reload: Failed")
end

function M.setup(opts)
  config = vim.tbl_deep_extend('force', config, opts or {})
  vim.keymap.set("n", "<leader>r", M.reload, { desc = "Reload app on the emulator" })
end

return M
