local configs = require("nvim-treesitter.configs")
configs.setup({
  ensure_installed = { "cpp", "lua", "vim", "query", "javascript", "html", "css", "python" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },  
  })
