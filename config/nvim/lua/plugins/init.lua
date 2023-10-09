return {
  -- default
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup {
        options = {
          hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' }
          },
          diagnostics = "nvim_lsp",
          -- rest of config ...

          --- count is an integer representing total count of errors
          --- level is a string "error" | "warning"
          --- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
          --- this should return a string
          --- Don't get too fancy as this function will be executed a lot
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end

        },
      }
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    version = "*",
    opts = {
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1, -- relative path
          },
        },
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    -- version = "*",
    -- event = "VeryLazy",
    main = "ibl",
    opts = {
      scope = {
        enabled = true,
        show_start = true,
      },
    },
  },

  {
    'folke/which-key.nvim',
    opts = {},
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("notify").setup({
        background_colour = "#000000",
      })

      local noice = require("noice")

      noice.setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })

      -- vim.keymap.set({ "c" }, "<C-e>", "<C-p>", { noremap = true, silent = true })
      -- vim.keymap.set({ "c" }, "<C-p>", "<C-e>", { noremap = true, silent = true })
    end,
  },

  -- {
  --   'glacambre/firenvim',
  --
  --   -- Lazy load firenvim
  --   -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  --   lazy = not vim.g.started_by_firenvim,
  --   build = function()
  --     vim.fn["firenvim#install"](0)
  --   end
  -- },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = "VeryLazy",
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
      })
      vim.keymap.set('n', 'gt', require('treesj').toggle, { desc = '[T]ree toggle' })
    end,
  },

  {
    'windwp/nvim-autopairs',
    -- due to bug: https://github.com/windwp/nvim-autopairs/issues/395
    commit = "3b664e8",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "aznhe21/actions-preview.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
    end,
  },

  {
    'jedrzejboczar/possession.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    event = "VeryLazy",
    config = function()
      require('possession').setup({})
    end,
  },

  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      -- "anuvyklack/animation.nvim"
    },
    event = "VeryLazy",
    config = function()
      -- vim.o.winwidth = 10
      -- vim.o.winminwidth = 10
      -- vim.o.equalalways = false
      require('windows').setup({
        -- animation = {
        --   duration = 100,
        --   fps = 60,
        -- },
      })

      vim.keymap.set("n", "<leader>m", "<CMD>WindowsMaximize<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<C-w>=", "<CMD>WindowsEqualize<CR>", { noremap = true, silent = true })
    end,
  },

  {
    'norcalli/nvim-colorizer.lua',
    opts = {},
  },

  {
    'sanathks/workspace.nvim',
    opts = {},
    config = function()
      local workspace = require('workspace')
      workspace.setup({
        workspaces = {
          { name = "buzzvil",    path = "~/Workspace/buzzvil",  keymap = { '<leader>wwb' } },
          { name = "playground", path = "~/Workspace/gwolv.es", keymap = { '<leader>wwp' } },
        },
      })

      vim.keymap.set('n', '<leader>ww', workspace.tmux_sessions)
    end,
  },

  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    opts = {},
  },

  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup()
      vim.keymap.set({ "n", "t" }, "<C-\\>", "<CMD>ToggleTerm<CR>", { noremap = true, silent = true })
      vim.keymap.set({ "n", "t" }, "<C-`>", "<CMD>ToggleTerm<CR>", { noremap = true, silent = true })
    end,
  },

}
