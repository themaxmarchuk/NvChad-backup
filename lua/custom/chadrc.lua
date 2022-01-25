local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

if vim.g.neovide then
   vim.api.nvim_set_option("guifont", "RobotoMono Nerd Font:h18")
end

M.options = {
   relativenumber = true,
   undofile = false,
}

M.ui = {
   theme = "tokyonight",
}

M.ui = {
   hl_override = "custom.colors",
}

vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", { noremap = true, silent = true })

M.mappings.plugins = {
   comment = {
      toggle = "<C-c>",
   },
}

M.plugins = {
   status = {
      colorizer = true,
      vim_matchup = false,
   },
   default_plugin_config_replace = {
      nvim_comment = "custom.plugins.comment",
      nvim_treesitter = "custom.plugins.treesitter",
      feline = "custom.plugins.feline",
      nvim_cmp = "custom.plugins.cmp",
      gitsigns = "custom.plugins.gitsigns",
   },
}

return M
