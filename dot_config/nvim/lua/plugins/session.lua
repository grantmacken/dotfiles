-- return {
  --   'olimorris/persisted.nvim',
  --   opts = {
    --     use_git_branch = true,
    --     autoload = true,
    --     allowed_dirs = {
      --       '~/projects/grantmacken/dotfiles',
      --     },
      --   },
      --   config = true,
      -- }

      return
      {
	      "stevearc/resession.nvim",
	      enabled = true,
	      name = 'resession',
	      opts = {
	        autosave = {
	          enabled = false,
	          interval = 60,
	          notify = true,
	        },
          options = {
            "binary",
            "bufhidden",
            "buflisted",
            "cmdheight",
            "diff",
            "filetype",
            "modifiable",
            "previewwindow",
            "readonly",
            "scrollbind",
            "winfixheight",
            "winfixwidth",
          },
          --buf_filter = require("resession").default_buf_filter,
          tab_buf_filter = function(tabpage, bufnr)
            return true
          end,
          -- The name of the directory to store sessions in
          dir = "session",
          -- Show more detail about the sessions when selecting one to load.
          -- Disable if it causes lag.
          load_detail = true,
          -- List order ["modification_time", "creation_time", "filename"]
          load_order = "modification_time",
	      },
	      config = function(_, opts)
	        local resession = require('resession')
	        local session_name = require('my.util').get_session_name()
          resession.setup()
          local cmd = vim.api.nvim_create_user_command
       
          -- cmd("SessionLoad",function(_)ressession.load(session_name)end, {})

          --vim.keymap.set('n', '<leader>ss','<cmd>resession.save(session_name)<cr.', { desc = 'session save' })
          --vim.keymap.set('n', '<leader>sl', resession.load(session_name), { desc = 'session load' })
          --vim.keymap.set('n', '<leader>sd', resession.delete, { desc = 'session delete' })
	      end
      }

