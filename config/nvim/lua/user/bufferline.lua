local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end
bufferline.setup({
	options = {
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "center",
				separator = true,
			},
		},
		indicator = {
			style = "underline",
		},
		buffer_close_icon = "",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or ""
        return " " .. icon .. count
    end
	},
})
