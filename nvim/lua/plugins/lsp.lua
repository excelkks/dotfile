return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
        lspconfig.pylsp.setup({})
        lspconfig.ccls.setup({
          init_options = {
            cache = {
              directory = ".ccls-cache";
            }
          }
        })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {"lua_ls", "rust_analyzer", "clangd"},
    },
    dependencies = {
      {"mason-org/mason.nvim", opts = {}},
      "neovim/nvim-lspconfig",
    },
  }
}
