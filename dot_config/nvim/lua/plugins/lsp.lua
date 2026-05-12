return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Setup Mason first
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "gopls",
          "rust_analyzer",
          "pyright",
          "clangd",
        },
        automatic_installation = true,
      })

      -- LSP keymaps (set when LSP attaches)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local function map(keys, func, desc)
            vim.keymap.set(
              "n",
              keys,
              func,
              { buffer = event.buf, noremap = true, silent = true, desc = "LSP: " .. desc }
            )
          end

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gr", vim.lsp.buf.references, "Go to references")
          map("gI", vim.lsp.buf.implementation, "Go to implementation")
          map("gy", vim.lsp.buf.type_definition, "Go to type definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("K", vim.lsp.buf.hover, "Hover documentation")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>ds", vim.lsp.buf.document_symbol, "Document symbols")
          map("<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
        end,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- Setup servers using vim.lsp.config (Neovim 0.11+)
      -- Lua
      vim.lsp.config.lua_ls = {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      }
      -- TypeScript
      vim.lsp.config.ts_ls = {
        capabilities = capabilities,
      }

      -- Go
      vim.lsp.config.gopls = {
        capabilities = capabilities,
      }

      -- Rust
      vim.lsp.config.rust_analyzer = {
        capabilities = capabilities,
      }

      -- Python
      vim.lsp.config.pyright = {
        capabilities = capabilities,
      }

      -- C/C++
      vim.lsp.config.clangd = {
        capabilities = capabilities,
      }

      -- Enable all configured servers
      vim.lsp.enable({ "lua_ls", "ts_ls", "gopls", "rust_analyzer", "pyright", "clangd" })
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        desc = "Format buffer",
      },
    },
    opts = function()
      local js_formatters = { "oxfmt", "biome", "prettier", stop_after_first = true }
      local config_formatters = { "dprint", "prettier", stop_after_first = true }
      local c_formatters = { "clang_format" }

      return {
        formatters_by_ft = {
          lua = { "stylua" },
          c = c_formatters,
          cpp = c_formatters,
          javascript = js_formatters,
          typescript = js_formatters,
          javascriptreact = js_formatters,
          typescriptreact = js_formatters,
          astro = js_formatters,
          json = config_formatters,
          yaml = config_formatters,
          markdown = config_formatters,
          go = { "gofumpt", "goimports" },
          python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
              return { "ruff_format" }
            else
              return { "isort", "black" }
            end
          end,
          rust = { "rustfmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        log_level = vim.log.levels.ERROR,
      }
    end,
  },
}
