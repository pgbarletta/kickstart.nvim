return {
  {
    'mfussenegger/nvim-dap',
    -- Add nvim-dap-python to the dap dependencies
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        -- Configure nvim-dap-ui
        config = function()
          local dapui = require 'dapui'
          dapui.setup() -- Use default settings

          local dap = require 'dap'
          -- Add listeners to automatically open and close the UI on session events
          dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
          end
        end,
      },
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      -- This function call is the core of the setup.
      -- It will find the debugpy adapter installed by Mason and configure it automatically.
      -- It also sets up default launch configurations for Python.
      require('dap-python').setup 'python'
    end,
  },
}
