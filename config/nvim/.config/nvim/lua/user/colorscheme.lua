require("catppuccin").setup({
	flavour = "macchiato",
	transparent_background = true,
})
local colorscheme = "catppuccin"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
