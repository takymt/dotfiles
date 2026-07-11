-- Override only the indent width set by nvim's bundled markdown ftplugin
-- (markdown_recommended_style forces 4); keep the rest of its recommended
-- style (formatlistpat, comments, commentstring, etc.) intact.
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
