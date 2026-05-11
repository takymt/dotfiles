return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- treesitter does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "lua",
        "vim",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "go",
        "rust",
        "python",
      })

      -- Enable treesitter highlighting on FileType
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_setup", { clear = true }),
        callback = function(event)
          pcall(vim.treesitter.start, event.buf)
        end,
      })
    end,
  },
}
