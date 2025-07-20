return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
    end,
    keys = {
      {"<leader>F", "<cmd>Telescope find_files<cr>", desc = "Telescope find files"},
      {"<leader>G", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep"},
      {"<leader>B", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers"},
      {"<leader>H", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags"},
    }
  },

  -- Improve the performance of big file
  {
    "pteroctopus/faster.nvim",
    config = function()
      require("faster").setup()
    end,
  },

  -- Fold
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = { "kevinhwang91/promise-async", },
  --   config = function() require('ufo').setup() end
  -- },
  
  {
    "tomtom/tcomment_vim",
    event = "BufRead",
    config = function()
      vim.g.tcomment_maps = true
      vim.g.tcomment_textobject_inlinecomment = ''
    end
  },
}
