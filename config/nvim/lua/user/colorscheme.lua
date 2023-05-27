local colorscheme = "catppuccin"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  vim.api.nvim_set_hl(0,"Normal", {bg = "none"})
  vim.api.nvim_set_hl(0,"NormalFloat", {bg = "none"})
if not status_ok then
  return
end

