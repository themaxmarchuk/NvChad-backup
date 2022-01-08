local customPlugins = require "core.customPlugins"

customPlugins.add(function(use)
   use {
      "JoosepAlviste/nvim-ts-context-commentstring",
      requires = { "nvim-treesitter/nvim-treesitter" },
      event = "BufRead",
   }
   use "folke/tokyonight.nvim"
   use "folke/lua-dev.nvim"
   use {
      "themaxmarchuk/tailwindcss-colors.nvim",
      module = "tailwindcss-colors",
      config = function()
         require("tailwindcss-colors").setup()
      end,
   }
   use {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require "custom.plugins.null-ls"
      end,
   }
end)
