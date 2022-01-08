vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_italic_keywords = false

vim.cmd "colorscheme tokyonight"

-- Grab the theme colors
local colors = require("colors").get()

-- Grab some util stuff
local fg = require("core.utils").fg
local fg_bg = require("core.utils").fg_bg
local bg = require("core.utils").bg

-- Override some settings
-- ... would go here..
