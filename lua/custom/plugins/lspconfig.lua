local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   -- lspservers with default config

   local servers = { "gopls", "ccls", "tsserver", "cssls", "html", "jsonls", "tailwindcss", "sumneko_lua" }

   for _, lsp in ipairs(servers) do
      local opts = {
         capabilities = capabilities,
         on_attach = attach,
         flags = {
            debounce_text_changes = 150,
         },
      }

      -- NOTE: on windows, language servers installed using npm need to have
      -- .cmd as a suffix, otherwise they won't work. But only for servers
      -- installed using npm.

      if lsp == "cssls" then
         -- windows only fix for cssls
         if vim.fn.has "win32" == 1 then
            opts.cmd = { "vscode-css-language-server.cmd", "--stdio" }
         end

         opts.settings = {
            css = {
               validate = false,
            },
         }
      end

      if lsp == "html" then
         -- windows only fix for html
         if vim.fn.has "win32" == 1 then
            opts.cmd = { "vscode-html-language-server.cmd", "--stdio" }
         end
      end

      if lsp == "tailwindcss" then
         -- windows only fix for tailwindcss
         if vim.fn.has "win32" == 1 then
            opts.cmd = { "tailwindcss-language-server.cmd", "--stdio" }
         end

         -- local tailwindcss_colors = require("tailwindcss-colors")

         -- warp the attach function
         opts.on_attach = function(_, bufnr)
            require("tailwindcss-colors").buf_attach(bufnr)
            attach(_, bufnr)
         end
      end

      if lsp == "jsonls" then
         -- windows only fix for jsonls
         if vim.fn.has "win32" == 1 then
            opts.cmd = { "vscode-json-language-server.cmd", "--stdio" }
         end

         -- setup json schemas for validation
         opts.settings = {
            json = {
               schemas = {
                  {
                     description = "TypeScript compiler configuration file",
                     fileMatch = { "tsconfig.json", "tsconfig.*.json" },
                     url = "http://json.schemastore.org/tsconfig",
                  },
                  {
                     description = "Babel configuration",
                     fileMatch = { ".babelrc.json", ".babelrc", "babel.config.json" },
                     url = "http://json.schemastore.org/lerna",
                  },
                  {
                     description = "ESLint config",
                     fileMatch = { ".eslintrc.json", ".eslintrc" },
                     url = "http://json.schemastore.org/eslintrc",
                  },
                  {
                     description = "Prettier config",
                     fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
                     url = "http://json.schemastore.org/prettierrc",
                  },
                  {
                     description = "Package.json",
                     fileMatch = { "package.json" },
                     url = "https://json.schemastore.org/package.json",
                  },
               },
            },
         }
      end

      if lsp == "sumneko_lua" then
         -- Setup binary path on windows
         if vim.fn.has "win32" == 1 then
            vim.notify "I AM BEING EXECUTED AND LUA IS STUPID!"
            local sumneko_root = "C:\\tools\\sumneko_lua\\"
            local sumneko_binary = sumneko_root .. "bin\\lua-language-server\\Windows\\lua-language-server.exe"
            opts.cmd = { sumneko_binary, "-E", sumneko_root .. "main.lua" }
         end

         -- lua-dev sets things up for neovim plugin development, we can just pass our current lspconfig
         -- settings and it will generate a config with proper path setups for all installed plugins and
         -- neovim function signatures/completions etc
         local luadev = require("lua-dev").setup {
            lspconfig = opts,
         }

         -- Use config generated by lua-dev
         opts = luadev
      end

      lspconfig[lsp].setup(opts)
   end
end

return M
