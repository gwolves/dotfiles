return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {

      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("neo-tree").setup({
        window = {
          mappings = {
            -- used for navigation
            ["e"] = "noop",
            ["C-c"] = "cancel",
          },
        },
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          -- hijack_netrw_behavior = "disabled",
          window = {
            mappings = {
              ["<BS>"] = "noop",
              ["-"] = "navigate_up",
            },
            fuzzy_finder_mappings = {
              ["<C-e>"] = "move_cursor_up",
            },
          },
        },
      })

      local function graceful_toggle()
        local manager = require("neo-tree.sources.manager")
        local renderer = require("neo-tree.ui.renderer")
        local state = manager.get_state("filesystem")

        if renderer.window_exists(state) then
          if state.winid ~= vim.api.nvim_get_current_win() then
            -- just focus if tree already exists
            vim.api.nvim_set_current_win(state.winid)
          else
            vim.cmd("Neotree close")
          end
        else
          vim.cmd("Neotree focus")
        end
      end

      vim.keymap.set({ "n", "t" }, "<C-b>", graceful_toggle)
      -- vim.keymap.set("n", "<C-b>", toggle)
    end,
  },

  {
    "theprimeagen/harpoon",
    event = "VeryLazy",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file, { silent = true, desc = '[A]dd file to <harpoon>' })
      vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu, { silent = true, desc = 'toggle [H]arpoon' })
      vim.keymap.set("n", "<C-h>", ui.nav_next)
    end,
  },

  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { silent = true, desc = 'toggle [U]ndotree' })
    end,
  },

  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end,
  },

  {
    'sindrets/winshift.nvim',
    config = function()
      require("winshift").setup()
      vim.keymap.set("n", "<C-M-m>", "<cmd>WinShift left<CR>")
      vim.keymap.set("n", "<C-M-n>", "<cmd>WinShift down<CR>")
      vim.keymap.set("n", "<C-M-e>", "<cmd>WinShift up<CR>")
      vim.keymap.set("n", "<C-M-i>", "<cmd>WinShift right<CR>")
    end,
  },

  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      tmux_nav = require("nvim-tmux-navigation")
      tmux_nav.setup({
        disable_when_zoomed = true,
      })
      vim.keymap.set({ "n", "t" }, "<C-m>", tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set({ "n", "t" }, "<C-n>", tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set({ "n", "t" }, "<C-e>", tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set({ "n", "t" }, "<C-i>", tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set({ "n", "t" }, "<C-9>", tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set({ "n", "t" }, "<C-0>", tmux_nav.NvimTmuxNavigateNext)
    end,
  },

  {
    "natecraddock/workspaces.nvim",
    opts = {},
  },

  {
    "tiagovla/scope.nvim",
    opts = {},
  },

  {
    'stevearc/oil.nvim',
    event = "VeryLazy",
    config = function()
      require('oil').setup()
    end,
  },

  {
    'ggandor/leap.nvim',
    dependencies = {
      'ggandor/flit.nvim',
    },
    event = { "BufReadPre" },
    config = function()
      -- Note: workaround: leap requires `Cursor` highlight group, but my current colorscheme not support it.
      -- Ref: https://github.com/ggandor/leap.nvim/issues/27
      vim.api.nvim_set_hl(0, 'Cursor', { reverse = true })

      -- Note: workaround: original cursor remains visible due to neovim bug.
      -- Ref: https://github.com/ggandor/leap.nvim/issues/70
      vim.api.nvim_create_autocmd(
        "User",
        {
          callback = function()
            vim.cmd.hi("Cursor", "blend=100")
            vim.opt.guicursor:append { "a:Cursor/lCursor" }
          end,
          pattern = "LeapEnter"
        }
      )
      vim.api.nvim_create_autocmd(
        "User",
        {
          callback = function()
            vim.cmd.hi("Cursor", "blend=0")
            vim.opt.guicursor:remove { "a:Cursor/lCursor" }
          end,
          pattern = "LeapLeave",
        }
      )

      local leap = require('leap');

      require('flit').setup({});

      -- vim.keymap.set({ 'n', 'x' }, '<C-s>', '<Plug>(leap-forward)',
      --   { silent = true, desc = "[S]earch forward by <leap>" })
      vim.keymap.set({ 'n', 'x' }, '<Leader>s', '<Plug>(leap-forward)',
        { silent = true, desc = "[S]earch forward by <leap>" })
      vim.keymap.set({ 'n', 'x' }, '<Leader>S', '<Plug>(leap-backward)',
        { silent = true, desc = "[S]earch backward by <leap>" })
      vim.keymap.set('x', '<Leader>x', '<Plug>(leap-forward-till)',
        { silent = true, desc = "e[X]clusive search forward by <leap>" })
      vim.keymap.set('x', '<Leader>X', '<Plug>(leap-backward-till)',
        { silent = true, desc = "e[X]clusive search backward by <leap>" })

      leap.add_repeat_mappings(';', ',', {
        -- False by default. If set to true, the keys will work like the
        -- native semicolon/comma, i.e., forward/backward is understood in
        -- relation to the last motion.
        relative_directions = true,
        -- By default, all modes are included.
        modes = { 'n', 'x', 'o' },
      })
    end,
  },

}
