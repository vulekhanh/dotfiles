vim.cmd([[highlight IndentBlanklineIndent1 guifg=#e78284 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#e5c890 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#a6d189 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#81c8be gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#8caaee gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#ca9ee6 gui=nocombine]])
require("indent_blankline").setup({
	-- context is off by default, use this to turn it on
	show_current_context = true,
	show_current_context_start = true,
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	},
})
