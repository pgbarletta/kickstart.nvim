local M = {}

function M.toggle_colorscheme()
  local current_colorscheme = vim.g.colors_name -- Get the current colorscheme

  local dark_scheme = 'catppuccin-frappe' -- Your preferred dark scheme
  local light_scheme = 'catppuccin-latte' -- Your preferred light scheme

  if current_colorscheme == dark_scheme then
    vim.cmd('colorscheme ' .. light_scheme)
  elseif current_colorscheme == light_scheme then
    vim.cmd('colorscheme ' .. dark_scheme)
  else
    -- Handle the case where the current colorscheme is neither dark nor light.
    -- You might want to default to one or the other.
    vim.cmd('colorscheme ' .. dark_scheme) -- Default to dark
  end
end

-- Create the key mapping.  <leader>ts is a common choice, but use whatever you prefer.
vim.keymap.set('n', '<leader>ts', M.toggle_colorscheme, { noremap = true, silent = true })

vim.keymap.set('n', '<C-Up>', '<C-w>w', { noremap = true, silent = true }) -- This example keeps the default behavior

function Search_and_replace_word()
  -- Get the word under the cursor
  local word = vim.fn.expand '<cword>'

  -- Prompt the user for the replacement word
  local replacement = vim.fn.input('Replace ' .. word .. ' with: ')

  -- If the user entered a replacement, perform the search and replace
  if replacement ~= '' then
    vim.cmd(':%s/' .. word .. '/' .. replacement .. '/gc') -- 'c' flag for confirmation
  end
end

-- Create a keymap for the function (e.g., <leader>r)
vim.api.nvim_set_keymap('n', '<leader>fr', '<cmd>lua Search_and_replace_word()<CR>', { noremap = true, silent = true })

-- go to end of line
vim.keymap.set('n', '_', 'g_', { desc = 'Go to last non-blank character of line' })
vim.keymap.set('v', '_', 'g_', { desc = 'Go to last non-blank character of line' })

--------------- copy buffer and containing dir paths
-- vim.keymap.set('n', '<leader>cp', ':let @+=expand("%:p")<CR>') -- copy path to system clipboard.
vim.api.nvim_create_user_command('CopyPath', 'let @+=expand("%:p")', {
  desc = "Copy the current buffer's path to the system clipboard",
})
vim.keymap.set('n', '<leader>cp', ':CopyPath<CR>')

function copy_dir_path()
  vim.fn.setreg('+', vim.fn.expand '%:p:h') -- Use :h to get directory path
  vim.notify('Copied directory path to clipboard', vim.log.levels.INFO, { title = 'Neovim' })
end
vim.api.nvim_set_keymap('n', '<leader>cd', '<cmd>lua copy_dir_path()<CR>', { noremap = true, silent = true })

-- Lua function to save and quit the current buffer
function Save_and_quit_buffer()
  vim.cmd 'w'
  vim.cmd 'bd'
end

-- Create a user command (optional, but good practice)
vim.api.nvim_create_user_command('SaveQuitBuffer', 'lua Save_and_quit_buffer()', {
  desc = 'Save and quit the current buffer',
})

-- Set the key mapping
vim.keymap.set('n', '<leader>bs', ':SaveQuitBuffer<CR>')

-- Lua function to quit the current buffer
function Quit_buffer()
  vim.cmd 'bd!'
end

-- Create a user command (optional, but good practice)
vim.api.nvim_create_user_command('QuitBuffer', 'lua Quit_buffer()', {
  desc = 'Quit the current buffer',
})

-- Set the key mapping
vim.keymap.set('n', '<leader>bd', ':QuitBuffer<CR>')

-- Lua function reload he current buffer
function Reload_buffer()
  vim.cmd 'e'
end

-- Create a user command (optional, but good practice)
vim.api.nvim_create_user_command('ReloadBuffer', 'lua Reload_buffer()', {
  desc = 'Reload the current buffer',
})

-- Set the key mapping
vim.keymap.set('n', '<leader>ee', ':ReloadBuffer<CR>')

-- ------------------[ DAP Debugging Keymaps ]------------------ 🐛
vim.keymap.set('n', '<F5>', function()
  require('dap').continue()
end, { desc = 'DAP: Continue' })
vim.keymap.set('n', '<F10>', function()
  require('dap').step_over()
end, { desc = 'DAP: Step Over' })
vim.keymap.set('n', '<F11>', function()
  require('dap').step_into()
end, { desc = 'DAP: Step Into' })
vim.keymap.set('n', '<F12>', function()
  require('dap').step_out()
end, { desc = 'DAP: Step Out' })
vim.keymap.set('n', '<leader>b', function()
  require('dap').toggle_breakpoint()
end, { desc = 'DAP: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
  require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
end, { desc = 'DAP: Set Logpoint' })
vim.keymap.set('n', '<leader>dr', function()
  require('dap').repl.open()
end, { desc = 'DAP: Open REPL' })
vim.keymap.set('n', '<leader>dl', function()
  require('dap').run_last()
end, { desc = 'DAP: Run Last' })
vim.keymap.set('n', '<leader>dt', function()
  require('dapui').toggle()
end, { desc = 'DAP: Toggle UI' })

return M
