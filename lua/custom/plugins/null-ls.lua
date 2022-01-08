local ok, null_ls = pcall(require, "null-ls")

if not ok then
   return
end

null_ls.setup {
   sources = {
      -- stylua
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.rustfmt,
      null_ls.builtins.formatting.prettierd,
   },
   on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
         vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
      end
   end,
}
