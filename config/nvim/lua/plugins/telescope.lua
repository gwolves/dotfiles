return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = {
      'nvim-lua/plenary.nvim',

      -- extensions
      'nvim-telescope/telescope-file-browser.nvim',
      -- 'nvim-telescope/telescope-project.nvim',
      'cljoly/telescope-repo.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'jedrzejboczar/possession.nvim',
      'tiagovla/scope.nvim',

    },
    lazy = true,
    config = function()
      local telescope = require("telescope")
      -- local fb_action = require("telescope").extensions.file_browser.actions

      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions
      telescope.setup {
        defaults = {
          mappings = {
            i = {
              ["<C-e>"] = actions.move_selection_previous,
            },
          },
        },
        extensions = {
          file_browser = {
            -- hijack_netrw = true,
            mappings = {
              ["i"] = {
                ["<C-p>"] = fb_actions.goto_parent_dir,
                ["<C-g>"] = fb_actions.goto_home_dir,
              },
            },
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            },
          },
        },
      }

      telescope.load_extension("file_browser")
      telescope.load_extension("repo")
      -- telescope.load_extension("projects")
      telescope.load_extension("noice")
      telescope.load_extension("ui-select")
      telescope.load_extension("workspaces")
      telescope.load_extension("possession")
      telescope.load_extension("scope")

      -- require 'telescope'.extensions.project.project {}

      local builtin = require("telescope.builtin")
      local keymap = vim.keymap.set

      keymap("n", "<C-p>", builtin.find_files, { desc = 'alias for [F]ind [F]iles' })
      -- keymap("n", "<C-p>", builtin.git_files)
      -- keymap("n", "<leader>fp", ":Telescope projects<CR>")
      -- keymap("n", "<leader>fp", ":lua require'telescope'.extensions.projects.projects{}<CR>")
      keymap("n", "<leader>ff", builtin.find_files, { desc = '[F]ind [F]iles' })
      keymap("n", "<leader>fr", ":Telescope repo list<CR>", { desc = '[F]ind [R]epository' })
      keymap("n", "<leader>fg", builtin.live_grep, { desc = '[F]ind by live[G]rep' })
      keymap("n", "<leader>fb", builtin.buffers, { desc = '[F]ind [B]uffer' })
      keymap("n", "<leader>fh", builtin.help_tags, { desc = '[F]ind [H]elp tags' })
      keymap("n", "<leader>fs", telescope.extensions.possession.list, { desc = '[F]ind [S]ession' })
      -- keymap("n", "<leader>fc", ":Telescope grep_string<CR>")
      --
      -- keymap("n", "<C-f>", ":Telescope file_browser path=$HOME<CR>")
      keymap("n", "<C-f>", ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
        { desc = 'alias for File browser' })

      keymap("n", "<leader>k", ":Telescope keymaps<CR>", { desc = '[K]eymaps' })

      -- keymap("n", "<leader>ps", function()
      --   builtin.grep_string({ search = vim.fn.input("Grep > ") })
      -- end)
    end,
  },

  -- {
  --   'ahmedkhalf/project.nvim',
  --   opts = {
  --     manual_mode = true,
  --   },
  -- },
}
