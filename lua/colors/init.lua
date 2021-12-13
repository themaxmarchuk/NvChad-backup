local M = {}

-- if theme given, load given theme if given, otherwise nvchad_theme
M.init = function(theme)
   if not theme then
      theme = require("core.utils").load_config().ui.theme
   end

   -- set the global theme, used at various places like theme switcher, highlights
   vim.g.nvchad_theme = theme

   local present, base16 = pcall(require, "base16")

   if present then
      -- first load the base16 theme
      base16(base16.themes(theme), true)

      -- unload to force reload
      package.loaded["colors.highlights" or false] = nil
      -- then load the highlights
      require "colors.highlights"
   end
end

local tk_colors = require("tokyonight.colors").setup {}

-- returns a table of colors for givem or current theme
M.get = function(theme)
   if not theme then
      theme = vim.g.nvchad_theme
   end

   -- return require("hl_themes." .. theme)
   local colors = {
      white = tk_colors.fg,
      darker_black = "#151621",
      black = "#1A1B26", --  nvim bg
      black2 = tk_colors.bg_dark,
      one_bg = tk_colors.bg_dark,
      one_bg2 = tk_colors.comment,
      one_bg3 = tk_colors.fg_gutter,
      grey = tk_colors.comment,
      grey_fg = tk_colors.dark3,
      grey_fg2 = tk_colors.comment,
      light_grey = tk_colors.dark5,
      red = "#f7768e",
      baby_pink = "#DE8C92",
      pink = tk_colors.magenta2,
      line = tk_colors.fg_gutter, -- for lines like vertsplit
      green = "#9ece6a",
      vibrant_green = "#73daca",
      nord_blue = "#80a8fd",
      blue = "#7aa2f7",
      yellow = tk_colors.yellow,
      sun = "#EBCB8B",
      purple = "#bb9af7",
      dark_purple = "#9d7cd8",
      teal = tk_colors.blue1,
      orange = "#ff9e64",
      cyan = "#7dcfff",
      statusline_bg = "#1d1e29",
      lightbg = tk_colors.fg_gutter,
      lightbg2 = tk_colors.bg_highlight,
      pmenu_bg = tk_colors.blue,
      folder_bg = tk_colors.blue,
   }

   return colors
end

return M
