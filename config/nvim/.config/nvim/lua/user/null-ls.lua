local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	debug = false,
	sources = {
		formatting.stylua,
		formatting.prettierd,
		diagnostics.eslint_d,
		completion.luasnip,
		completion.spell,
		completion.tags,
		code_actions.gitsigns,
	},
	-- Format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
