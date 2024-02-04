local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
local opts = {
  sources = {
    null_ls.builtins.formatting.clang_format,
  },
  on_attach = function (client, buffrn)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = buffrn,
      })
      vim.api.nvim_create_autocmd("BufWritePre",{
        group = augroup,
        buffer = buffrn,
        callback = function ()
         vim.lsp.buf.format({bufffer = buffrn}) 
        end,
      })
    end
  end
}

return opts
