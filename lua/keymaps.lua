local function toggle_colorscheme()
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
vim.keymap.set('n', '<leader>ts', toggle_colorscheme, { noremap = true, silent = true })

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
