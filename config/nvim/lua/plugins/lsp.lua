return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- local lsp env
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',

      -- rust
      'simrat39/rust-tools.nvim',

      -- format
      "lukas-reineke/lsp-format.nvim",
    },
    event = "VeryLazy",
    config = function()
      require('mason').setup()
      local lsp_format = require("lsp-format")

      -- [[ Configure LSP ]]
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        -- nmap('<leader>ca', '<cmd>CodeActionMenu<cr>', '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nmap('gT', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('E', vim.lsp.buf.hover, 'Hover Documentation [Explain]')
        nmap('gh', vim.lsp.buf.signature_help, '[S]ignature [D]ocumentation')

        nmap('<leader>vd', '<cmd>lua vim.diagnostic.open_float()<cr>', '[V]iew [D]iagnostic')
        nmap('[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', '[D]iagnostic [P]revioues')
        nmap(']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', '[D]iagnostic [N]ext')

        -- Lesser used LSP functionality
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        --   vim.lsp.buf.format()
        -- end, { desc = 'Format current buffer with LSP' })
        -- nmap('<leader>F', '<cmd>:Format<CR>', '[F]ormat')

        lsp_format.on_attach(client, bufnr)
      end

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. They will be passed to
      --  the `settings` field of the server config. You must look up that documentation yourself.
      --
      --  If you want to override the default filetypes that your language server will attach to you can
      --  define the property 'filetypes' to the map in question.
      local servers = {
        -- clangd = {},
        gopls = {},
        pyright = {},
        nil_ls = {},
        -- rust_analyzer is set with rust-tools
        -- rust_analyzer = {},
        -- tsserver = {},
        -- html = { filetypes = { 'html', 'twig', 'hbs'} },

        -- lua_ls = {
        --   Lua = {
        --     workspace = { checkThirdParty = false },
        --     telemetry = { enable = false },
        --   },
        -- },
      }

      -- set sync to enable :wq
      lsp_format.setup({
        go = {
          sync = true,
        },
        python = {
          sync = true,
        },
        lua = {
          sync = true,
        },
      })

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end
      }


      local rt = require('rust-tools')
      rt.setup({
        server = {
          capabilities = capabilities,
          on_attach = on_attach,
        },
      })

      require('lspconfig').lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            workspace = { checkThirdParty = true },
            telemetry = { enable = false },
          },
        },
      })

      -- Setup neovim lua configuration
      require('neodev').setup()
    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",

      -- adapters
      "nvim-neotest/neotest-go",
    },
    config = function()
      local neotest = require('neotest')
      neotest.setup({
        adapters = {
          require("neotest-go")({
            args = { "-count=1", "-timeout=30s" },
          }),
        },
      })

      vim.keymap.set('n', '<leader>rt', neotest.run.run)
      vim.keymap.set('n', '<leader>rat', function()
        neotest.run.run(vim.fn.expand("%"))
      end)
    end,
  },

  -- {
  --   "ray-x/lsp_signature.nvim",
  --   opts = {},
  --   config = function(_, opts)
  --     require('lsp_signature').setup(opts)
  --   end,
  -- },

}
