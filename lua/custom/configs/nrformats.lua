local M = {}

function M.toggle_alpha_nrformat()
  -- Get current nrformats as a Lua table
  local current = vim.opt.nrformats:get()

  -- Check if "alpha" is present
  local has_alpha = false
  for _, v in ipairs(current) do
    if v == 'alpha' then
      has_alpha = true
      break
    end
  end

  if has_alpha then
    vim.opt.nrformats:remove 'alpha'
    vim.notify('nrformats: alpha OFF', vim.log.levels.INFO)
  else
    vim.opt.nrformats:append 'alpha'
    vim.notify('nrformats: alpha ON', vim.log.levels.INFO)
  end
end

return M
