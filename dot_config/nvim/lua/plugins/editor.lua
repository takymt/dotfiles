return {
  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
    },
    opts = {
      filters = {
        dotfiles = false,
      },
      git = {
        enable = true,
        ignore = false,
      },
    },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git files" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>gg",
        function()
          local lazygit_cmd = vim.fn.executable("direnv") == 1 and "direnv exec . lazygit" or "lazygit"
          vim.cmd("tabnew")
          vim.cmd("terminal " .. lazygit_cmd)
          vim.cmd("startinsert")
        end,
        desc = "Lazygit",
      },
      {
        "<leader>gd",
        function()
          require("gitsigns").diffthis()
        end,
        desc = "Git diff this",
      },
      {
        "<leader>hp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview hunk",
      },
      {
        "<leader>hs",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage hunk",
      },
      {
        "<leader>hr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset hunk",
      },
      {
        "<leader>hu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "Undo stage hunk",
      },
      {
        "<leader>hb",
        function()
          require("gitsigns").blame_line({ full = true })
        end,
        desc = "Blame line",
      },
      {
        "<leader>hd",
        function()
          require("gitsigns").diffthis()
        end,
        desc = "Diff this",
      },
    },
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, "Next git hunk")

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, "Previous git hunk")

        map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
        map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, "Blame line")
        map("n", "<leader>hd", gitsigns.diffthis, "Diff this")
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage selected hunk")
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset selected hunk")
      end,
    },
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
