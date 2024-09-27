local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format({details = true})
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  },
  window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      -- Need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<Tab>'] = cmp.mapping.confirm({select = false}),
  }),
})
