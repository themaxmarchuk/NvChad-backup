-- IMPORTANT NOTE : This is the user config, can be edited. Will be preserved if updated with internal updater
-- This file is for NvChad options & tools, custom settings are split between here and 'lua/custom/init.lua'

local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

-- NOTE: To use this, make a copy with `cp example_chadrc.lua chadrc.lua`

--------------------------------------------------------------------

-- To use this file, copy the structure of `core/default_config.lua`,
-- examples of setting relative number & changing theme:

-- Set guifont if running inside neovide
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

-- LSP mapping overrides
vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", { noremap = true, silent = true })

-- Override the default plugin mappings
M.mappings.plugins = {
   comment = {
      toggle = "<C-c>",
   },
}

-- NvChad included plugin options & overrides
M.plugins = {
   options = {
      lspconfig = {
         -- path of file containing setups of different lsps (ex : "custom.plugins.lspconfig"), read the docs for more info
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },
   status = {
      colorizer = true,
      vim_matchup = false,
   },
   -- To change the Packer `config` of a plugin that comes with NvChad,
   -- add a table entry below matching the plugin github name
   --              '-' -> '_', remove any '.lua', '.nvim' extensions
   -- this string will be called in a `require`
   --              use "(custom.configs).my_func()" to call a function
   --              use "custom.blankline" to call a file
   default_plugin_config_replace = {
      nvim_comment = "custom.plugins.comment",
      nvim_treesitter = "custom.plugins.treesitter",
      feline = "custom.plugins.feline",
      nvim_cmp = "custom.plugins.cmp",
      gitsigns = "custom.plugins.gitsigns",
   },
}

return M
