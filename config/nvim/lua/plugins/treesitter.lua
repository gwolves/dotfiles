return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- clear paragraph selection
      vim.keymap.set("x", "ip", "<Nop>");
      vim.keymap.set("x", "ap", "<Nop>");

      -- clear sentence selection
      vim.keymap.set("x", "is", "<Nop>");
      vim.keymap.set("x", "as", "<Nop>");

      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "c",
          "cpp",

          "python",
          "toml",

          "go",
          "gomod",
          "gosum",

          "rust",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "javascript",
          "html",
          "nix",

          "terraform",
          "yaml",
        },
        auto_install = true,
        sync_install = false,
        autopairs = { enable = true },
        highlight = { enable = true },
        indent = { enable = true },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<S-Space>",
            node_incremental = "M",
            node_decremental = "I",
            scope_incremental = "<S-Space>",
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["a="] = { query = "@assignment.outer", desc = "Select [A]round part of an assignment[=]" },
              ["i="] = { query = "@assignment.inner", desc = "Select [I]nner part of an assignment[=]" },
              ["l="] = { query = "@assignment.lhs", desc = "Select [L]eft hand side of an assignment[=]" },
              ["r="] = { query = "@assignment.rhs", desc = "Select [R]ight hand side of an assignment[=]" },

              ["ap"] = { query = "@parameter.outer", desc = "Select [A]round part of a [P]arameter/argument" },
              ["ip"] = { query = "@parameter.inner", desc = "Select [I]nner part of a [P]arameter/argument" },

              ["ac"] = { query = "@conditional.outer", desc = "Select [A]round part of a [C]onditional" },
              ["ic"] = { query = "@conditional.inner", desc = "Select [I]nner part of a [C]onditional" },

              ["al"] = { query = "@loop.outer", desc = "Select [A]round part of a [L]oop" },
              ["il"] = { query = "@loop.inner", desc = "Select [I]nner part of a [L]oop" },

              ["aa"] = { query = "@call.outer", desc = "Select [A]round part of a function c[A]ll" },
              ["ia"] = { query = "@call.inner", desc = "Select [I]nner part of a function c[A]ll" },

              ["af"] = { query = "@function.outer", desc = "Select [A]round part of a [F]unction/method definition" },
              ["if"] = { query = "@function.inner", desc = "Select [I]nner part of a [F]unction/method definition" },

              ["as"] = { query = "@class.outer", desc = "Select [A]round part of a [S]truct/class" },
              ["is"] = { query = "@class.inner", desc = "Select [I]nner part of a [S]truct/class" },
            },
          },

          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]a"] = { query = "@call.outer", desc = "Next function c[A]ll start" },
              ["]f"] = { query = "@function.outer", desc = "Next [F]unction/method definition start" },
              ["]s"] = { query = "@class.outer", desc = "Next [S]truct/class start" },
              ["]c"] = { query = "@conditional.outer", desc = "Next [C]onditional start" },
              ["]l"] = { query = "@loop.outer", desc = "Next [L]oop start" },
              ["]]"] = { query = "@class.outer", desc = "Next struct/class start" },
            },
            goto_next_end = {
              ["]A"] = { query = "@call.outer", desc = "Next function c[A]ll end" },
              ["]F"] = { query = "@function.outer", desc = "Next [F]unction/method definition end" },
              ["]S"] = { query = "@class.outer", desc = "Next [S]truct/class end" },
              ["]C"] = { query = "@conditional.outer", desc = "Next [C]onditional end" },
              ["]L"] = { query = "@loop.outer", desc = "Next [L]oop end" },
              ["]["] = { query = "@class.outer", desc = "Next struct/class end" },
            },
            goto_previous_start = {
              ["[a"] = { query = "@call.outer", desc = "Previous function c[A]ll start" },
              ["[f"] = { query = "@function.outer", desc = "Previous [F]unction/method definition start" },
              ["[s"] = { query = "@class.outer", desc = "Previous [S]truct/class start" },
              ["[c"] = { query = "@conditional.outer", desc = "Previous [C]onditional start" },
              ["[l"] = { query = "@loop.outer", desc = "Previous [L]oop start" },
              ["[["] = { query = "@class.outer", desc = "Previous struct/class start" },
            },
            goto_previous_end = {
              ["[A"] = { query = "@call.outer", desc = "Previous function c[A]ll end" },
              ["[F"] = { query = "@function.outer", desc = "Previous [F]unction/method definition end" },
              ["[S"] = { query = "@class.outer", desc = "Previous [S]truct/class end" },
              ["[C"] = { query = "@conditional.outer", desc = "Previous [C]onditional end" },
              ["[L"] = { query = "@loop.outer", desc = "Previous [L]oop end" },
              ["[]"] = { query = "@class.outer", desc = "Previous struct/class end" },
            },
          },

          swap = {
            enable = true,
            swap_next = {
              ["gi"] = { query = "@parameter.inner", desc = "Swap with next parameter/argument" },
            },
            swap_previous = {
              ["gm"] = { query = "@parameter.inner", desc = "Swap with next parameter/argument" },
            },
          },
        },
      })

      local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

      -- Repeat movement with ; and ,
      -- ensure ; goes forward and , goes backward regardless of the last direction
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

      -- vim way: ; goes to the direction you were moving.
      -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      -- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
      -- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
      -- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
      -- vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

      local context = require("treesitter-context");
      vim.keymap.set("n", "gx", context.go_to_context, { silent = true, desc = "[G]o to conte[X]t" });
    end,
  },
}
