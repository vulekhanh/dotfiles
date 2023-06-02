local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion
null_ls.setup({
debug = false,
    sources = {
    formatting.stylua,
    formatting.prettierd,
    formatting.eslint,
    diagnostics.eslint,
    completion.spell,
    },
})
