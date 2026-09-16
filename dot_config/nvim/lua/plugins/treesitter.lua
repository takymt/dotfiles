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
        "hcl",
        "go",
        "rust",
        "python",
      })

      -- use hcl as sub for alloy
      vim.treesitter.language.register("hcl", "alloy")
      vim.filetype.add({
        extension = {
          alloy = "alloy",
        },
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
